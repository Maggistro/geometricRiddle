function [nextNode, newCollSet] = oneStep(node,direction,collSet,riddle)
%calculates the next node in the direction on an extended vector from 
%objects' bordervectors

%check an object other than the main object is moved. If so just return the
%same point. Valid check will elimate it later.
if abs(direction) > 2
    %create new node
    tempAdd = zeros(1,length(node));
    tempAdd(abs(direction))=sign(direction)*1;
    nextNode = node + tempAdd;
    
    if(abs(direction) == 3)
        %rotate main object and recalculate collSet
        %TODO
        newCollSet = collSet;
        return;
    end
    
    %change objects according to new configuration
    %find object that changed
    objectPos = floor((abs(direction)-1)/3); %substract main object
    riddle.o{objectPos} = changeOneObject(direction,riddle.o{objectPos});
    newCollSet = getRims(riddle.m.data,riddle.o,length(riddle.m.data),riddle.m.mid);
    return;
end

%if main object was moved, iterate trough objects and calculate extended
%vectors
newCollSet = collSet;
min_dist = inf;
nextNode = node;
for object=collSet
    points = object{1};
    for i=1:length(points)
        %calculate line from points
        offset = points(i,:);
        vector = points(mod(i,length(points))+1,:)-points(i,:);
        %solve for x and y points
        x =  vector\(node(1:2) - offset) ;
        
        %check if line is parallel to searching direction
        if(x(2,mod(abs(direction),2)+1)==0)
            continue;
        end
        
        %get point on same x,y coordinate
        %get x to move in y direction and otherwise
        if(abs(direction)==1)
            p = offset + x(2,2)*vector;%get point on same y
        else
            p = offset + x(2,1)*vector;%get point on same x
        end
        
        %vector from node to temp point on line
        node_to_point = p-node(1:2);
        %get distance to those points if direction is ok       
        if sign(node_to_point(abs(direction))) ~= sign(direction)
            d = inf;
        else
            d = norm(p - node(1:2));
        end
        
        %save new minimum and new point on line
        if d < min_dist
            min_dist = min(min_dist,d);
            nextNode(1:2) = p + 0.001*node_to_point;
        end
    end
end

end