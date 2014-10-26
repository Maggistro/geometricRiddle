function heuristic = heuristicObstacle(configuration,path)
%calculates a value for the obstacles to be used as heuristic for their
%movements. Lower value means better heuristic. node contains the currenct
%configuration, path the path withouth obstacles.

for i=1:3:length(configuration)
   %pick the current objects config
   point = configration(i:i+1);
   xDiff = path - point(1);
   yDiff = path - point(2);
   [~,p] = min(abs(xDiff));
   if xDiff(p)<0
       vector = path(p+1)-path(p);
   else
       vector = path(p)-path(p-1);
   end
end



end