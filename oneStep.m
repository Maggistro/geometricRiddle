function nextNode = oneStep(node,direction,objects)
%calculates the next node in the direction on an extended vector from 
%objects' bordervectors

%check an object other than the main object is moved. If so just return the
%same point. Valid check will elimate it later.
if abs(direction) > 2
    tempAdd = zeros(1,length(node));
    tempAdd(abs(direction))=direction;
    nextNode = node + tempAdd;
    return;
end

%if main object was moved, iterate trough objects and calculate extended
%vectors
min_dist = inf;
nextNode = node;
for object=objects
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
            nextNode(1:2) = p;
        end
    end
end

end