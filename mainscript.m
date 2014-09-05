%mainscript with initial riddle

close all;
clear variables;
%% riddles for vector representation

% simple rotation riddle

%Rim R
R.data = [0,0; 15,0; 15,1; 1,1; 1,9; 15,9; 15,10; 0,10; 0,0];
R.mid = [0,0,0];

%All fixed rim objects
riddleRotation.r={R};


%Obstacle O
O.data = [7,2; 8,2; 8,8; 7,8; 7,2];
O.mid=[7.5,5,0];

%Mainobject M
M.data = [2,4; 3,4; 3,6; 2,6; 2,4];
M.mid=[2.5,5,0];
riddleRotation.m = M;

%All movable objects
riddleRotation.o = {M,O};


%Mainobject M
M.data = [2,4; 3,4; 3,6; 2,6; 2,4];
M.mid=[2.5,5,0];
riddleRotation.m = M;

%Target T
T.data = [12,6; 13,6; 13,8; 12,8; 12,6];
T.mid=[12.5,7,0];
riddleRotation.t = T;

%Configuration space size ( main border )
B_m=[1.5 2; 15.5 2; 15.5 8; 1.5 8; 1.5 2];
B_o=[1.5 4; 15.5 4; 15.5 6; 1.5 6; 1.5 4];
riddleRotation.b = {B_m, B_o}; 


%simple translation riddle

%Rim R
R.data = [-1,-1; 16,-1; 16,0; 0,0; 0,10; 16,10; 16,11; -1,11; -1,-1];
R.mid = [0,0,0];

R1.data = [5,3; 5.5,3; 5.5,10; 5,10; 5,3];
R1.mid = [5.25,7.5,0];

R2.data = [5,2.5; 13,2.5; 13,3; 5,3; 5,2.5];
R2.mid = [8,2.75,0];

R3.data = [7,5.5; 15,5.5; 15,6; 7,6; 7,5.5];
R3.mid = [10,5.75,0];

%All fixed rim objects
riddleSmall.r={};
riddleMultiple.r={R};
riddleBackward.r = {R1,R2,R3};
riddleMultipleBig.r={R};
riddleMultipleBigger.r={R};


%Obstacle O
O1.data = [7,7; 8,7; 8,8; 7,8; 7,7];
O1.mid=[7.5,7.5,0];


O2.data = [7,4.5; 8,4.5; 8,5.5; 7,5.5; 7,4.5];
O2.mid=[7.5,5,0];


O3.data = [7,2; 8,2; 8,3; 7,3; 7,2];
O3.mid=[7.5,2.5,0];

O4.data = [9,7; 10,7; 10,8; 9,8; 9,7];
O4.mid=[9.5,7.5,0];


O5.data = [9,4.5; 10,4.5; 10,5.5; 9,5.5; 9,4.5];
O5.mid=[9.5,5,0];


O6.data = [9,2; 10,2; 10,3; 9,3; 9,2];
O6.mid=[9.5,2.5,0];


O7.data = [5,3; 6,3; 6,4; 5,4; 5,3];
O7.mid=[5.5,3.5,0];


O8.data = [5,6; 6,6; 6,7; 5,7; 5,6];
O8.mid=[5.5,6.5,0];

%All movable objects
riddleSmall.o={M,O1,O2};
riddleMultiple.o = {M,O1,O2,O4,O5};
riddleBackward.o = {M};
riddleMultipleBig.o = {M,O1,O2,O3,O4,O5,O6};
riddleMultipleBigger.o = {M,O1,O2,O3,O4,O5,O6,O7,O8};

%Mainobject M
M.data = [2,4; 3,4; 3,6; 2,6; 2,4];
M.mid=[2.5,5,0];
riddleSmall.m=M;
riddleMultiple.m = M;
riddleBackward.m = M;
riddleMultipleBig.m = M;
riddleMultipleBigger.m = M;

%Target T
T.data = [12,6; 13,6; 13,8; 12,8; 12,6];
T.mid=[12.5,7,0];

TB.data = [11.9,6.9; 12.9,6.9; 12.9,8.9; 11.9,8.9; 11.9,6.9];
TB.mid = [12.5,8,0];

riddleSmall.t=T;
riddleMultiple.t = T;
riddleBackward.t = TB;
riddleMultipleBig.t = T;
riddleMultipleBigger.t = T;

%Configuration space size ( main border )
B = [0 0; 15 0; 15 10; 0 10; 0 0];
B_m=[0.5 1; 14.5 1; 14.5 9; 0.5 9; 0.5 1];
B_o=[0.5 0.5; 14.5 0.5; 14.5 9.5; 0.5 9.5; 0.5 0.5];
B_r=[-10 -10; 20 -10; 20 20; -10 20; -10 -10];
riddleSmall.b = {B_m, B_o, B_o}; 
riddleMultiple.b = {B_m, B_o, B_o, B_o, B_o}; 
riddleBackward.b = {B_m, B_r, B_r, B_r};
riddleMultipleBig.b = {B_m,B_o, B_o, B_o,B_o, B_o, B_o};
riddleMultipleBigger.b = {B_m,B_o, B_o, B_o,B_o, B_o, B_o,B_o,B_o};

riddleSmall.bZ = B; 
riddleMultiple.bZ = B; 
riddleBackward.bZ = B;
riddleMultipleBig.bZ = B;
riddleMultipleBigger.bZ = B;


%% riddle for function representation


% simple rotation riddle

%All fixed rim objects
riddleRotationFunc.r={};

%Obstacle O
O.coeff = {[0,600,-4198],[0,0,8],[0,600,-4798],[0,0,2]};
O.def = {[7,7.01],[7.01,8.01],[8,8.01],[7,8]}; 
O.above = {-1, -1, 1 ,1};
O.mid=[7.5,5,0];

%Mainobject M
M.coeff = {[0,200,-396],[0,0,6],[0,200,-596],[0,0,4]};
M.def = {[2,2.01],[2.01,3.01],[3,3.01],[2,3]}; 
M.above = {-1, -1, 1 ,1};
M.mid=[2.5,5,0];
riddleRotationFunc.m = M;


%All movable objects
riddleRotationFunc.o = {M,O};

%Target T
T.data = [12,6; 13,6; 13,8; 12,8; 12,6];
T.coeff = {[0,200,-2394],[0,0,8],[0,200,-2594],[0,0,6]};
T.def = {[12,12.01],[12.01,13.01],[13,13.01],[12,13]}; 
T.above = {-1, -1, 1 ,1};
T.mid=[12.5,7,0];
riddleRotationFunc.t = T;

%Configuration space size ( main border )
riddleRotationFunc.b =  [0,0; 0,10; 15,10; 15,0];


%safety distance
riddleRotationFunc.s = 0.001;


%simple translation riddles

%Rim objects
R1.coeff = {[0,7000,-34997],[0,0,10],[0,7000,-38497],[0,0,3]};
R1.def = {[5,5.001],[5.001,5.501],[5.5,5.501],[5,5.5]}; 
R1.above = {-1, -1, 1 ,1};
R1.mid=[5.25,6.5,0];

R2.coeff = {[0,500,-2497.5],[0,0,3],[0,500,-6497.5],[0,0,2.5]};
R2.def = {[5,5.001],[5.001,13.001],[13,13.001],[5,13]}; 
R2.above = {-1, -1, 1 ,1};
R2.mid=[9,2.75,0];

R3.coeff = {[0,500,-3494.5],[0,0,6],[0,500,-7494.5],[0,0,5.5]};
R3.def = {[7,7.001],[7.001,15.001],[15,15.001],[7,15]}; 
R3.above = {-1, -1, 1 ,1};
R3.mid=[10.5,5.75,0];

%All fixed rim objects
riddleSmallFunc.r={};
riddleTrans.r={};
riddleBackwardFunc.r={R1, R2, R3};
riddleMultipleFunc.r={};
riddleMultipleBigFunc.r={};
riddleMultipleBiggerFunc.r={};

%Obstacle O
O1.coeff = {[0,200,-1393],[0,0,8],[0,200,-1593],[0,0,7]};
O1.def = {[7,7.005],[7.005,8.005],[8,8.005],[7,8]}; 
O1.above = {-1, -1, 1 ,1};
O1.mid=[7.5,7.5,0];


O2.coeff = {[0,200,-1396],[0,0,5.5],[0,200,-1596],[0,0,4.5]};
O2.def = {[7.0025,7.0075],[7.0075,8.0075],[8.0025,8.0075],[7.0025,8.0025]}; 
O2.above = {-1, -1, 1 ,1};
O2.mid=[7.5,5,0];


O3.coeff = {[0,200,-1399],[0,0,3],[0,200,-1599],[0,0,2]};
O3.def = {[7.005,7.01],[7.01,8.01],[8.005,8.01],[7.005,8.005]}; 
O3.above = {-1, -1, 1 ,1};
O3.mid=[7.5,2.5,0];

O4.coeff = {[0,200,-1793],[0,0,8],[0,200,-1993],[0,0,7]};
O4.def = {[9,9.005],[9.005,10.005],[10,10.005],[9,10]}; 
O4.above = {-1, -1, 1 ,1};
O4.mid=[9.5,7.5,0];


O5.coeff = {[0,200,-1796],[0,0,5.5],[0,200,-1996],[0,0,4.5]};
O5.def = {[9.0025,9.0075],[9.0075,10.0075],[10.0025,10.0075],[9.0025,10.0025]}; 
O5.above = {-1, -1, 1 ,1};
O5.mid=[9.5,5,0];


O6.coeff = {[0,200,-1799],[0,0,3],[0,200,-1999],[0,0,2]};
O6.def = {[9.005,9.01],[9.01,10.01],[10.005,10.01],[9.005,10.005]}; 
O6.above = {-1, -1, 1 ,1};
O6.mid=[9.5,2.5,0];

O7.coeff = {[0,200,-997],[0,0,4],[0,200,-1197],[0,0,3]};
O7.def = {[5,5.005],[5.005,6.005],[6,6.005],[5,6]}; 
O7.above = {-1, -1, 1 ,1};
O7.mid=[5.5,3.5,0];

O8.coeff = {[0,200,-994],[0,0,7],[0,200,-1194],[0,0,6]};
O8.def = {[5,5.005],[5.005,6.005],[6,6.005],[5,6]}; 
O8.above = {-1, -1, 1 ,1};
O8.mid=[5.5,6.5,0];

OT.coeff = {[0,200,-1396],[0,0,6.5],[0,200,-1596],[0,0,3.5]};
OT.def = {[6.9925,7.0125],[7.0125,8.0125],[7.9925,8.0125],[6.9925,7.9925]}; 
OT.above = {-1, -1, 1 ,1};
OT.mid=[7.5,5,0];

%Mainobject M
M.coeff = {[0,200,-396],[0,0,6],[0,200,-596],[0,0,4]};
M.def =  {[2,2.01],[2.01,3.01],[3,3.01],[2,3]};
M.above = {-1, -1, 1 ,1};
M.mid=[2.5,5,0];
riddleSmallFunc.m = M;
riddleTrans.m = M;
riddleBackwardFunc.m = M;
riddleMultipleFunc.m = M;
riddleMultipleBigFunc.m = M;
riddleMultipleBiggerFunc.m = M;

%All movable objects
riddleSmallFunc.o = {M,O1,O2};
riddleTrans.o = {M,O};
riddleBackwardFunc.o ={M};
riddleMultipleFunc.o = {M,O1,O2,O4,O5};
riddleMultipleBigFunc.o = {M,O1,O2,O3,O4,O5,O6};
riddleMultipleBiggerFunc.o = {M,O1,O2,O3,O4,O5,O6,O7,O8};

%Target T
T.data = [12,6; 13,6; 13,8; 12,8; 12,6];
T.coeff = {[0,200,-2394],[0,0,8],[0,200,-2594],[0,0,6]};
T.def = {[12,12.01],[12.01,13.01],[13,13.01],[12,13]}; 
T.above = {-1, -1, 1 ,1};
T.mid=[12.5,7,0];

TB.data = [12,7; 13,7; 13,9; 12,9; 12,7];
TB.coeff = {[0,200,-2393],[0,0,9],[0,200,-2593],[0,0,7]};
TB.def = {[12,12.01],[12.01,13.01],[13,13.01],[12,13]}; 
TB.above = {-1, -1, 1 ,1};
TB.mid=[12.5,8,0];

riddleSmallFunc.t = T;
riddleTrans.t = T;
riddleBackwardFunc.t = TB;
riddleMultipleFunc.t = T;
riddleMultipleBigFunc.t = T;
riddleMultipleBiggerFunc.t = T;

%Configuration space size ( main border )
riddleSmallFunc.b =  [0,0; 0,10; 15,10; 15,0];
riddleTrans.b =  [0,0; 0,10; 15,10; 15,0];
riddleBackwardFunc.b = [0,0; 0,10; 15,10; 15,0];
riddleMultipleFunc.b =  [0,0; 0,10; 15,10; 15,0];
riddleMultipleBigFunc.b = [0,0; 0,10; 15,10; 15,0];
riddleMultipleBiggerFunc.b = [0,0; 0,10; 15,10; 15,0];


%safety distance
riddleSmallFunc.s = 0.001;
riddleTrans.s = 0.001;
riddleBackwardFunc.s = 0.001;
riddleMultipleFunc.s = 0.001;
riddleMultipleBigFunc.s = 0.001;
riddleMultipleBiggerFunc.s = 0.001;


%% calling solveriddle

warning('off','MATLAB:rankDeficientMatrix');
warning('off','MATLAB:singularMatrix');
times = zeros(10,1);
Paths = cell(10,1);
for i=1:11
    tic;
    %set flag to true for function implementation, false for vector
    Paths(i) = {solveRiddle(riddleBackward,false)};
    times(i)=toc
end

out=Paths{1};
figure(2);
hold on;
plot(out(:,1),out(:,2),'black');
plot(out(:,4),out(:,5),'blue');
plot(out(:,7),out(:,8),'blue');
plot(out(:,10),out(:,11),'blue');
plot(out(:,13),out(:,14),'blue');
plot(out(:,16),out(:,17),'blue');
axis([0 17 0 12]);
hold off;
