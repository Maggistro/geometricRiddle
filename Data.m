close all;
clear all;
%Rim R
R.data = [0,0;
    15,0;
    15,1;
    1,1;
    1,9;
    15,9;
    15,10;
    0,10
    0,0];
R.mid = [0,0,0];
%All fixed rim objects
r={R};


%Mainobject M
M.data = [2,4;
    3,4;
    3,6;
    2,6;
    2,4];
M.mid=[2.5,5,0];

%Obstacle O
O.data = [7,2;
    8,2;
    8,8;
    7,8;
    7,2];
O.mid=[7.5,5,0];

%All movable objects
o = {M,O};


%Target T
T.data = [14,4;
    15,4;
    15,6;
    14,6;
    14,4];
T.mid=[14.5,5,0];
t = {T};


%Struct A with all information
A.R=R;
A.O=O;
A.M=M;
A.T=T;

riddle.r=r;
riddle.o = o;
riddle.t = t;
riddle.oMpos = 1;



%struct C with all configurations
%C.R = C_r;
%C.O = {C_m C_o};
%C.M = C_m;
%C.T = C_t;

%riddle.c = C;

%plot riddle
figure(1);
%start with plotting the figures
%black for rim, green for main object, blue for obstacles
%and red for target area
plot(R.data(:,1),R.data(:,2),'black',M.data(:,1),M.data(:,2),'g',O.data(:,1),O.data(:,2),'b',T.data(:,1),T.data(:,2),'r');
hold on;
%draw the objects angle points
plot(R.mid(1,1),R.mid(1,2),'*black');
plot(O.mid(1,1),O.mid(1,2),'*b');
plot(M.mid(1,1),M.mid(1,2),'*g');
plot(T.mid(1,1),T.mid(1,2),'*r');
axis([-2,17,-2,12]);
hold off;
%riddle plot finished

%save for on-the-fly plotting
figureData.fig = 1;
figureData.Rim = R.data;
figureData.Obstacle = O.data;
figureData.ConfObstacle = O.mid;
figureData.Main = M.data;
figureData.Target =T.data;


%pause;

%TODO
%CS=config(C,A)


%mit Hand berechnet
CS.M=[1.5 2; 15.5 2; 15.5 8; 1.5 8; 1.5 2];

CS_m=[];
KKR_oh=[];

%Berechnen der Kollision von O mit H
%mit Hand für eine Rotation
%Koll_oh = [7.5,1;
%        8.5,1;
%        8.5,9;
%        7.5,9;
%        7.5,1];
%rims =  {M};


disp('setting up angle combinations');
%calculate all possible angle combinations
angles = calcAngleCombination(length(riddle.o),360);

disp('calculating bounding boxes');

% also call this for each obstacle in the riddle ( best do that in a loop)
% then merge the resulting spaces
% NOTE: this will kill every processor there is
Coll_set_complete=cell(length(angles),length(riddle.o));
%outer loop over all objects
for j=1:length(riddle.o)
    firstObject = riddle.o{j};
    copyObjects = riddle.o;
    for comb = 1:length(angles)
        for i=1:length(riddle.o)
            copyObjects{i}.data = Rot(angles(comb,i),riddle.o{i}.data,riddle.o{i}.mid(1:2));
        end
        copyObjects(j) = [];
        Coll_set_complete{comb,j} = getRims(firstObject.data,copyObjects,length(firstObject.data),firstObject.mid);
    end
end

disp('setting up configuration space');
%merge all information from Coll_set_complete into one spacial array CS
%calculate size for preallocation
size = 0;
for i=1:length(riddle.o)
    size = size + length(Coll_set_complete{1,i}{1});
end
stepsize = size;
size = size * length(angles);

position = 1;
ConfigSpace=zeros();
for comb=1:length(angles)
    indexVec = [];
    for object=1:length(riddle.o)
        indexVec = [indexVec,Coll_set_complete{comb,object}{1},angles(comb,object)*ones(length(Coll_set_complete{comb,object}{1}),1)];
    end
    ConfigSpace(position:position+stepsize-1,:) = indexVec;
    position = position + stepsize;
end

save('cSpace.mat',ConfigSpace);
disp('finished with configuration setup. To start searching for solution, press key');

%Berechnen der Lage des Hindernisses f�r jeder Rotation
%do that with multiple obstacles ( should stay as simple as that )
for x=0:360
    KKR_oh=[KKR_oh;[Rot(x,Coll_set_complete{1}{1},O.mid(1:2)),ones(length(Coll_set_complete{1}{1}),1)*x]];
    CS_m=[CS_m;[CS.M,ones(length(CS.M),1)*x]];
end



%plot configuration spaces
%Regression über konfigurationsr
%Eckpunkte verbinden von KR_o zum Zeichnen
KR_o_plotvert = [CS_m(CS_m(:,3)==0|CS_m(:,3)==360,1),...
    CS_m(CS_m(:,3)==0|CS_m(:,3)==360,2),...
    CS_m(CS_m(:,3)==0|CS_m(:,3)==360,3)];

KR_o_plothor = [KR_o_plotvert(1,:);KR_o_plotvert(6,:);KR_o_plotvert(1,:);...
    KR_o_plotvert(2,:);KR_o_plotvert(7,:);KR_o_plotvert(2,:);...
    KR_o_plotvert(3,:);KR_o_plotvert(8,:);KR_o_plotvert(3,:);...
    KR_o_plotvert(4,:);KR_o_plotvert(9,:);KR_o_plotvert(4,:)];

%Eckpunkte verbinden von KKR_oh zum Zeichnen
% KKR_oh_plotvert1 =[KKR_oh(KKR_oh(:,3)==0,1),KKR_oh(KR_o(:,3)==0,2),KKR_oh(KR_o(:,3)==0,3)];
% KKR_oh_plotvert2 =[KKR_oh(KKR_oh(:,3)==360,1),KKR_oh(KKR_oh(:,3)==360,2),KKR_oh(KKR_oh(:,3)==360,3)];
%
% KKR_oh_plothor1 = [KKR_oh(1:5:length(KKR_oh),1),KKR_oh(1:5:length(KKR_oh),2),KKR_oh(1:5:length(KKR_oh),3)];
% KKR_oh_plothor2 = [KKR_oh(2:5:length(KKR_oh),1),KKR_oh(2:5:length(KKR_oh),2),KKR_oh(2:5:length(KKR_oh),3)];
% KKR_oh_plothor3 = [KKR_oh(3:5:length(KKR_oh),1),KKR_oh(3:5:length(KKR_oh),2),KKR_oh(3:5:length(KKR_oh),3)];
% KKR_oh_plothor4 = [KKR_oh(4:5:length(KKR_oh),1),KKR_oh(4:5:length(KKR_oh),2),KKR_oh(4:5:length(KKR_oh),3)];


figure(2);
hold on;
plot3(KKR_oh(:,1),KKR_oh(:,2),KKR_oh(:,3));%Hindernis
plot3(KR_o_plotvert(:,1),KR_o_plotvert(:,2),KR_o_plotvert(:,3),'g');%linien vertikal
plot3( KR_o_plothor(:,1),KR_o_plothor(:,2),KR_o_plothor(:,3),'g');%linien horizontal
plot3(C.M(1),C.M(2),C.M(3),'g*');
plot3(C.T(1),C.T(2),C.T(3),'r*');
print(1,'png');

%TODO:
%Wegsuche

%Zylindric algebraic decomposition

%Path = path_by_grassfire([K.O],KR_o,KKR_oh,K.O,K.Z);
pause();
tic
%Path = path_by_dijkstra(KR_o,KKR_oh,K.O,K.Z);
Path = path_by_dijkstra(CS.M,ConfigSpace,M.mid,T.mid,figureData);
toc
figure(2);
plot3(Path(:,1),Path(:,2),Path(:,3),'black');

%libSVM lib supportvektoren

%tangens substitution
