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
B_m=[1.5 2; 15.5 2; 15.5 8; 1.5 8];
B_o=[1.5 4; 10.5 4; 10.5 6; 1.5 6];
riddle.b = {B_m, B_o}; 


%simple translation riddle

%Rim R
R.data = [0,0; 15,0; 15,1; 1,1; 1,9; 15,9; 15,10; 0,10; 0,0];
R.mid = [0,0,0];

%All fixed rim objects
riddleMultiple.r={R};


%Obstacle O
O1.data = [7,7; 8,7; 8,9; 7,9; 7,7];
O1.mid=[7.5,8,0];


O2.data = [7,4; 8,4; 8,6; 7,6; 7,4];
O2.mid=[7.5,5,0];


O3.data = [7,1; 8,1; 8,3; 7,3; 7,1];
O3.mid=[7.5,2,0];

%Mainobject M
M.data = [2,4; 3,4; 3,6; 2,6; 2,4];
M.mid=[2.5,5,0];
riddle.m = M;

%All movable objects
riddleMultiple.o = {M,O1,O2,O3};


%Mainobject M
M.data = [2,4; 3,4; 3,6; 2,6; 2,4];
M.mid=[2.5,5,0];
riddleMultiple.m = M;

%Target T
T.data = [12,6; 13,6; 13,8; 12,8; 12,6];
T.mid=[12.5,7,0];
riddleMultiple.t = T;

%Configuration space size ( main border )
B_m=[1.5 2; 15.5 2; 15.5 8; 1.5 8];
B_o=[1.5 2; 10.5 2; 10.5 8; 1.5 8];
riddleMultiple.b = {B_m, B_o, B_o, B_o}; 

%% riddle for function representation

%simple translation riddle

%All fixed rim objects
riddleMultipleFunc.r={};

%Obstacle O
O1.coeff = {[0,200,-1393],[0,0,9],[0,200,-1593],[0,0,7]};
O1.def = {[7,7.01],[7.01,8.01],[8,8.01],[7,8]}; 
O1.above = {-1, -1, 1 ,1};
O1.mid=[7.5,8,0];


O2.coeff = {[0,200,-1396],[0,0,6],[0,200,-1596],[0,0,4]};
O2.def = {[7,7.01],[7.01,8.01],[8,8.01],[7,8]}; 
O2.above = {-1, -1, 1 ,1};
O2.mid=[7.5,5,0];


O3.coeff = {[0,200,-1399],[0,0,3],[0,200,-1599],[0,0,1]};
O3.def = {[7,7.01],[7.01,8.01],[8,8.01],[7,8]}; 
O3.above = {-1, -1, 1 ,1};
O3.mid=[7.5,2,0];

%Mainobject M
M.coeff = {[0,200,-396],[0,0,6],[0,200,-596],[0,0,4]};
M.def = {[2,2.01],[2.01,3.01],[3,3.01],[2,3]}; 
M.above = {-1, -1, 1 ,1};
M.mid=[2.5,5,0];
riddleMultipleFunc.m = M;

%All movable objects
riddleMultipleFunc.o = {M,O1,O2,O3};

%Target T
T.data = [12,6; 13,6; 13,8; 12,8; 12,6];
T.coeff = {[0,200,-2394],[0,0,8],[0,200,-2594],[0,0,6]};
T.def = {[12,12.01],[12.01,13.01],[13,13.01],[12,13]}; 
T.above = {-1, -1, 1 ,1};
T.mid=[12.5,7,0];
riddleMultipleFunc.t = T;

%Configuration space size ( main border )
riddleMultipleFunc.b =  [0,0; 0,10; 15,10; 15,0];

%safety distance
riddleMultipleFunc.s = 0.001;



%% calling solveriddle

warning('off','MATLAB:rankDeficientMatrix');
warning('off','MATLAB:singularMatrix');
tic
    %set flag to true for function implementation, false for vector
    out = solveRiddle(riddleMultipleFunc,true);
toc

