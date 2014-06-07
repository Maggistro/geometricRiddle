function [nextNode, newCollSet] = oneStep(node,direction,collSet,riddle)
%calculates the next node in the direction on an extended vector from
%objects' bordervectors

%check an object other than the main object is moved. If so just return the
%same point. Valid check will elimate it later.
newCollSet = collSet;
if abs(direction) > 2
    %create new node
    tempAdd = zeros(1,length(node));
    tempAdd(abs(direction))=sign(direction)*1;
    nextNode = node + tempAdd;
    
    
    %change objects according to new configuration
    %find objects that changed
    for objectPos=1:length(riddle.o)
        %objectPos = floor((abs(direction)-1)/3)+1;
        riddle.o{objectPos} = changeOneObject(nextNode((objectPos-1)*3+1:objectPos*3),riddle.o{objectPos});
    end
    
    for objectPos=1:length(riddle.o)
        temp = riddle.o;
        temp(objectPos) = [];
        newCollSet{objectPos} = getRims(riddle.o{objectPos}.data,temp,...
            length(riddle.o{objectPos}.data),riddle.o{objectPos}.mid);
    end
    return;
end

%if main object was moved, iterate trough objects and calculate extended
%vectors
min_dist = inf;
nextNode = node;
inTargetCell = true;
node_to_target = (riddle.t.mid(1:2)-node(1:2))';
for object=collSet{1}
    points = object{1};
    for i=1:length(points)
        %calculate line from points
        offset = points(i,:);
        vector = points(mod(i,length(points))+1,:)-points(i,:);
        
        offset_to_vector = [offset;vector+offset]; % save for cell determination
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
        
        
        if(inTargetCell)
            %find out if direct way to target is possible
            x=(node(1:2) - offset)';
            A=[vector', -node_to_target];
            sol = A\x;
            
            %point_on_line = offset + sol(1)*vector;
            
            %check if lines intersect (aka way to target is free )
            if(sol(1)>=0 && sol(1)<=1 && sol(2)>=0 && sol(2)<=1)
                inTargetCell = inTargetCell && false;
            end
            
        end
    end
end
if inTargetCell
    nextNode(1:3) = riddle.t.mid;
end

end