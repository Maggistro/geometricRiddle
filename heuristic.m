function value = heuristic( current, target )
%berechnet einen heuristicwert für den Momentanen Punkt
current(3)=current(3)*0.01;
target(3)=target(3)*0.01;
value=norm(current-target,2);


end

