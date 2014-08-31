%mainscript with initial riddle

close all;
clear variables;
%% riddles for vector representation

% simple rotation riddle

%Rim R
R.data = [0,0; 15,0; 15,1; 1,1; 1,9; 15,9; 15,10; 0,10; 0,0];
R.mid = [0,0,0];

%All fixed rim objects
riddle.r={R};


%Obstacle O
O.data = [7,2; 8,2; 8,8; 7,8; 7,2];
O.mid=[7.5,5,0];

%Mainobject M
M.data = [2,4; 3,4; 3,6; 2,6; 2,4];
M.mid=[2.5,5,0];
riddle.m = M;

%All movable objects
riddle.o = {M,O};


%Mainobject M
M.data = [2,4; 3,4; 3,6; 2,6; 2,4];
M.mid=[2.5,5,0];
riddle.m = M;

%Target T
T.data = [12,6; 13,6; 13,8; 12,8; 12,6];
T.mid=[12.5,7,0];
riddle.t = T;

%Configuration space size ( main border )
B_m=[1.5 2; 15.5 2; 15.5 8; 1.5 8; 1.5 2];
B_o=[1.5 4; 10.5 4; 10.5 6; 1.5 6; 1.5 4];
riddle.b = {B_m, B_o}; 


%simple translation riddle

%Rim R
R.data = [0,0; 15,0; 15,1; 1,1; 1,9; 15,9; 15,10; 0,10; 0,0];
R.mid = [0,0,0];

%All fixed rim objects
riddleMultiple.r={R};
riddleMultipleBig.r={R};


%Obstacle O
O1.data = [7,7; 8,7; 8,8; 7,8; 7,7];
O1.mid=[7.5,7.5,0];


O2.data = [7,4.5; 8,4.5; 8,5.5; 7,5.5; 7,4.5];
O2.mid=[7.5,5,0];


O3.data = [7,1; 8,1; 8,2; 7,2; 7,1];
O3.mid=[7.5,2.5,0];

O4.data = [9,7; 10,7; 10,8; 9,8; 9,7];
O4.mid=[9.5,7.5,0];


O5.data = [9,4.5; 10,4.5; 10,5.5; 9,5.5; 9,4.5];
O5.mid=[9.5,5,0];


O6.data = [9,1; 10,1; 10,2; 9,2; 9,1];
O6.mid=[9.5,2.5,0];


%Mainobject M
M.data = [2,4; 3,4; 3,6; 2,6; 2,4];
M.mid=[2.5,5,0];
riddle.m = M;

%All movable objects
riddleMultiple.o = {M,O1,O2,O3};
riddleMultipleBig.o = {M,O1,O2,O3,O4,O5,O6};

%Mainobject M
M.data = [2,4; 3,4; 3,6; 2,6; 2,4];
M.mid=[2.5,5,0];
riddleMultiple.m = M;
riddleMultipleBig.m = M;

%Target T
T.data = [12,6; 13,6; 13,8; 12,8; 12,6];
T.mid=[12.5,7,0];
riddleMultiple.t = T;
riddleMultipleBig.t = T;

%Configuration space size ( main border )
B_m=[1.5 2; 15.5 2; 15.5 8; 1.5 8; 1.5 2];
B_o=[1.5 1.5; 10.5 1.5; 10.5 8.5; 1.5 8.5; 1.5 1.5];
riddleMultiple.b = {B_m, B_o, B_o, B_o}; 
riddleMultipleBig.b = {B_m,B_o, B_o, B_o,B_o, B_o, B_o};

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

%All fixed rim objects
riddleMultipleFunc.r={};
riddleMultipleBigFunc.r={};

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

%Mainobject M
M.coeff = {[0,200,-396],[0,0,6],[0,200,-596],[0,0,4]};
M.def =  {[2,2.01],[2.01,3.01],[3,3.01],[2,3]};
M.above = {-1, -1, 1 ,1};
M.mid=[2.5,5,0];
riddleMultipleFunc.m = M;
riddleMultipleBigFunc.m = M;

%All movable objects
riddleMultipleFunc.o = {M,O1,O2,O3};
riddleMultipleBigFunc.o = {M,O1,O2,O3,O4,O5,O6};

%Target T
T.data = [12,6; 13,6; 13,8; 12,8; 12,6];
T.coeff = {[0,200,-2394],[0,0,8],[0,200,-2594],[0,0,6]};
T.def = {[12,12.01],[12.01,13.01],[13,13.01],[12,13]}; 
T.above = {-1, -1, 1 ,1};
T.mid=[12.5,7,0];
riddleMultipleFunc.t = T;
riddleMultipleBigFunc.t = T;

%Configuration space size ( main border )
riddleMultipleFunc.b =  [0,0; 0,10; 15,10; 15,0];
riddleMultipleBigFunc.b = [0,0; 0,10; 15,10; 15,0];

%safety distance
riddleMultipleFunc.s = 0.001;
riddleMultipleBigFunc.s = 0.001;


%% calling solveriddle

warning('off','MATLAB:rankDeficientMatrix');
warning('off','MATLAB:singularMatrix');
tic
    %set flag to true for function implementation, false for vector
    out = solveRiddle(riddleMultipleBigFunc,true);
toc

figure(2);
hold on;
plot(out(:,1),out(:,2),'black');
plot(out(:,4),out(:,5),'blue');
plot(out(:,7),out(:,8),'blue');
plot(out(:,10),out(:,11),'blue');
axis([0 17 0 12]);
hold off;
