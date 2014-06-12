%mainscript with initial riddle

close all;
clear variables;

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
B_o=[1.5 2; 15.5 2; 15.5 8; 1.5 8];
riddleMultiple.b = {B_m, B_o, B_o, B_o}; 




tic
   solveRiddle(riddle);
toc

