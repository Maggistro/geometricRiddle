function valid = isInsideFunc(firstObject,secondObject)
%checks if firstObject is inside secondObject or otherway around
valid = true;
firstInSecond = true;
secondInFirst = true;
for func_numb_first=1:length(firstObject.coeff)
    firstFunc = firstObject.coeff{func_numb_first};
    firstDef = firstObject.def{func_numb_first};
    %% calculate endpoints
    first_min(1) = firstDef(1);
    first_min(2) = first_min(1)^2*firstFunc(1) + first_min(1)*firstFunc(2)...
        + firstFunc(3);
    
    first_max(1) = firstDef(2);
    first_max(2) = first_max(1)^2*firstFunc(1) + first_max(1)*firstFunc(2)...
        + firstFunc(3);
    
    %iterate over all functions in other object and check for position
    %of endpoint and crossings
    for func_numb_second=1:length(secondObject.coeff)
        secondFunc = secondObject.coeff{func_numb_second};
        secondDef = secondObject.def{func_numb_second};
        
        
        %% check if common x range
        %get the x-range used by both function ( inner borders )
        min_y = (secondDef(1)>firstDef(1))*secondDef(1) + (secondDef(1)<=firstDef(1))*firstDef(1);
        max_y = (secondDef(2)<=firstDef(2))*secondDef(2) + (secondDef(2)>firstDef(2))*firstDef(2);
        
        if(min_y > max_y) % if no common range exists, jump to next function
            continue;
        end
        
        %% check if lines intersect
        if (firstFunc(1)==0 && firstFunc(1)==0) %both are linear functions
            
            if(firstFunc(2) - secondFunc(2)~=0) %check for parallel lines
                cross = (secondFunc(3) - firstFunc(3))/(firstFunc(2) - secondFunc(2));
            else
                     cross = [];
            end
        else %one line quadratic, other linear
            
            %new parameters
            a = firstFunc(1) - secondFunc(1);
            b = firstFunc(2) - secondFunc(2);
            c = firstFunc(3) - secondFunc(3);
            
            root = (b^2-4*a*c);
            if( root < 0 ) %if no solution available ( no cross )
                cross = [];
            elseif (root == 0) % else calculate solution
                cross = -b / (2*a);
            else
                cross(1) = (-b + sqrt(b^2-4*a*c) ) / (2*a);
                cross(2) = (-b + sqrt(b^2-4*a*c) ) / (2*a);
            end
        end
        
        %iterate over up to two crossing points
        for i=1:length(cross)
            if(cross(i)>min_y && cross(i)<max_y) %check if crossing point matters
                valid = false;
                return;
            end
        end
        
        
        %% lines dont intersect, check if points are on the correct side
        %only if its still possible that objects encapsule each other
        if(secondInFirst || firstInSecond)
            
            %calculate endpoints
            first_min(1) = min_y;
            first_min(2) = first_min(1)^2*firstFunc(1) + first_min(1)*firstFunc(2)...
                + firstFunc(3);
            
            first_max(1) = max_y;
            first_max(2) = first_max(1)^2*firstFunc(1) + first_max(1)*firstFunc(2)...
                + firstFunc(3);
            
            %calculate endpoints
            second_min(1) = min_y;
            second_min(2) = second_min(1)^2*secondFunc(1) + second_min(1)*secondFunc(2)...
                + secondFunc(3);
            
            second_max(1) = max_y;
            second_max(2) = second_max(1)^2*secondFunc(1) + second_max(1)*secondFunc(2)...
                + secondFunc(3);
            
            diff_min = first_min(2) - second_min(2);
            diff_max = first_max(2) - second_max(2);
            
            %check if second object is encapsuled by first
            %-1 means object is below function , 1 means above
            if(sign(diff_min) == firstObject.above{func_numb_first}) %if point is on correct side
                secondInFirst = false;
            end
            
            if(sign(diff_max) == secondObject.above{func_numb_first}) %if point is on correct side
                secondInFirst = false;
            end
            
            %check if first object is encapsuled in second
            if(-sign(diff_min) == secondObject.above{func_numb_second}) %if point is on correct side
                firstInSecond = false;
            end
            
            if(-sign(diff_max) == secondObject.above{func_numb_second}) %if point is on correct side
                firstInSecond = false;
            end
            
        end
        
        
    end
end


end