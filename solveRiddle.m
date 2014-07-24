function msg = solveRiddle(riddle,func)
%solveRiddle initialise needed variables and starts search
%func is a boolean for switching beetween function and vector
%implementation
figure(1);
axis equal;
axis ([0 10 0 10]);

msg = 0;

figureData.fig = 1;
figureData.riddle = riddle;
figureData.start = riddle.m.mid;
figureData.current = riddle.m.mid;
figureData.pause = 0.5;
if(func)
    
else
    figureData.Rim = riddle.r{1}.data;
    figureData.Target =riddle.t.data;
end

%drawMainObject(figureData);

if(func)
    Path = path_by_dijkstraFunc(riddle,figureData);
else
    Path = path_by_dijkstra(riddle,figureData);
end


figure(2);
plot(Path(:,1),Path(:,2),'black');
axis([0 17 0 12]);
msg=Path;

end