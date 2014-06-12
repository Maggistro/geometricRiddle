function msg = solveRiddle(riddle)
%solveRiddle initialise needed variables and starts search
figure(1);
axis equal;
axis ([0 10 0 10]);

msg = 0;

figureData.fig = 1;
figureData.Rim = riddle.r{1}.data;
figureData.riddle = riddle;
figureData.Target =riddle.t.data;
figureData.start = riddle.m.mid;
figureData.current = riddle.m.mid;

%drawMainObject(figureData);

Path = path_by_dijkstra(riddle,figureData);


figure(2);
plot(Path(:,1),Path(:,2),'black');
axis([0 17 0 12]);
Path

end