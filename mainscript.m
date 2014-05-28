%mainscript with initial riddle

close all;
clear all;

%Rim R
R.data = [0,0; 15,0; 15,1; 1,1; 1,9; 15,9; 15,10; 0,10; 0,0];
R.mid = [0,0,0];

%All fixed rim objects
riddle.r={R};


%Obstacle O
O.data = [7,2; 8,2; 8,8; 7,8; 7,2];
O.mid=[7.5,5,0];

%All movable objects
riddle.o = {O};


%Mainobject M
M.data = [2,4; 3,4; 3,6; 2,6; 2,4];
M.mid=[2.5,5,0];
riddle.m = M;

%Target T
T.data = [14,4; 15,4; 15,6; 14,6; 14,4];
T.mid=[14.5,5,0];
riddle.t = T;

%Configuration space size ( main border )
B=[1.5 2; 15.5 2; 15.5 8; 1.5 8];
riddle.b = B; 

tic
   solveRiddle(riddle);
toc

