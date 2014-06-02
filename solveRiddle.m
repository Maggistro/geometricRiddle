function msg = solveRiddle(riddle)
%solveRiddle initialise needed variables and starts search
figure(1);
axis equal;
axis ([0 10 0 10]);

msg = 0;

figureData.fig = 1;
figureData.Rim = riddle.r{1}.data;
figureData.Obstacle = riddle.o{2}.data;
figureData.ConfObstacle = riddle.o{2}.mid;
figureData.Main = riddle.m.data;
figureData.Target =riddle.t.data;
figureData.start = riddle.m.mid;
figureData.current = riddle.m.mid;

%drawMainObject(figureData);

Path = path_by_dijkstra(riddle,figureData);

end