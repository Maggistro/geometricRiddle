function value = heuristic( current, target )
%heuristic function for calculating "goodness" of a specifig point
diff = current(1:3) - target(1:3);
% make object movement less expensive. ( better move something than search
% complete space )
%diff(4:length(diff)) = diff(4:length(diff))*0.01; 
value=norm(diff,2);
end

