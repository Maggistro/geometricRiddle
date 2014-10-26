function msg = solveRiddle(riddle,func,cell)
%solveRiddle initialise needed variables and starts search
%func is a boolean for switching beetween function and vector
%implementation
%figure(1);
%axis equal;
%axis ([0 10 0 10]);

figureData.fig = 1;
figureData.start = riddle.m.mid;
figureData.current = riddle.m.mid;
figureData.pause = 0;
if(func)
    figureData.o = riddle.o;
    figureData.b = riddle.b;
    figureData.Target = riddle.t;
else
    figureData.riddle = riddle;
    figureData.Rim = riddle.r;
    figureData.b = riddle.bZ;
    figureData.Target =riddle.t.data;
end

%drawMainObject(figureData);

if(func)
    if cell
%        tempObjects = riddle.o;
%        riddle.o = riddle.o(1);
        Path = path_by_dijkstraCell(riddle,figureData);
%        riddle.o = tempObjects;
%        Path = path_by_dijkstraCell(riddle,figureData,Path);
    else
        Path = path_by_dijkstraFunc(riddle,figureData);
    end
else
    warning('off','MATLAB:rankDeficientMatrix');
    warning('off','MATLAB:singularMatrix');
    warning('off','MATLAB:nearlySingularMatrix');
    Path = path_by_dijkstra(riddle,figureData);
end

msg=Path;

end