function [nextNode, newCollSet] = oneStep(node,direction,collSet,riddle,jump_over)
%calculates the next node in the direction on an extended vector from
%objects' bordervectors

%check an object other than the main object is moved. If so just return the
%same point. Valid check will elimate it later.
newCollSet = collSet;
object_pos=floor((abs(direction)-1)/3) + 1 ;


if mod(abs(direction),3) == 0
    %create new node
    tempAdd = zeros(1,length(node));
    tempAdd(abs(direction))=sign(direction)*1;
    nextNode = node + tempAdd;

    for object=1:length(riddle.o)
        riddle.o{object} = changeOneObject(nextNode((object-1)*3+1:object*3),riddle.o{object});    
    end
    
    for object=1:length(riddle.o)
        temp = riddle.o;
        temp(object) = [];
        newCollSet{object}= getRims(riddle.o{object}.data,temp,...
            length(riddle.o{object}.data),riddle.o{object}.mid);
    end
     return;
end
   
%if main object was moved, iterate trough objects and calculate extended
%vectors
min_dist = inf;
nextNode = node;
temp = collSet{object_pos};
temp{length(temp)+1} = riddle.b{object_pos};
%if(sum(abs(node-[ 9.3568    6.9987    1.0000   10.4952    5.0000   -2.0000])<0.001)==6)
%    warning('on','MATLAB:rankDeficientMatrix');
%    warning('on','MATLAB:singularMatrix');
%end
node_to_target = (riddle.t.mid(1:2)-node(1:2))';
inTargetCell = object_pos==1;
for object=temp'
    points = object{1};
    for i=1:length(points)
        %calculate line from points
        offset = points(i,:);
        vector = points(mod(i,length(points))+1,:)-points(i,:);

        %solve for x and y points
        x =  vector\(node((object_pos-1)*3+1:(object_pos-1)*3+2) - offset) ;
        
        %check if point is in same cell as target
        if(inTargetCell)
            %find out if direct way to target is possible
            temp=(node(1:2) - offset)';
            A=[vector', -node_to_target];
            sol = A\temp;
            
            point_on_line = offset + sol(1)*vector;
            point_on_line = node(1:2)' + sol(2)*node_to_target;
            
            %check if lines intersect (aka way to target is free )
            if(sol(1)>=0 && sol(1)<=1 && sol(2)>=0 && sol(2)<=1)
                inTargetCell = inTargetCell && false;
            end    
        end
        
        %check if line is parallel to searching direction
        if(vector(mod(mod(abs(direction),3),2)+1)<0.001)
            continue;
        end
        
        %get point on same x,y coordinate
        %get x to move in y direction and otherwise
        if(mod(abs(direction),3)==1)
            if(x(2,2)<0.001)
                continue;
            end
            p = offset + x(2,2)*vector;%get point on same y
        else
            if(x(1,1)<0.001)
                continue;
            end
            p = offset + x(1,1)*vector;%get point on same x
        end
        
        %vector from node to temp point on line
        node_to_point = p-node((object_pos-1)*3+1:(object_pos-1)*3+2);
        %get distance to those points if direction is ok
        if sign(node_to_point(mod(abs(direction),3)))~= sign(direction)
            d = inf;
        else
            d = norm(p - node((object_pos-1)*3+1:(object_pos-1)*3+2));
        end
        
        %save new minimum and new point on line
        if d < min_dist
            min_dist = min(min_dist,d);
            if (jump_over==1)
            nextNode((object_pos-1)*3+1:(object_pos-1)*3+2) = p + (node_to_point~=0)*0.001;
            else
            nextNode((object_pos-1)*3+1:(object_pos-1)*3+2) = p - (node_to_point~=0)*0.001;
            end
        end
        
    end
end

if inTargetCell && object_pos==1
    nextNode(1:3) = riddle.t.mid;
    return
end

  for object=1:length(riddle.o)
        riddle.o{object} = changeOneObject(nextNode((object-1)*3+1:object*3),riddle.o{object});    
    end
  

for object=1:length(riddle.o)
        temp = riddle.o;
        temp(object) = [];
        newCollSet{object}= getRims(riddle.o{object}.data,temp,...
            length(riddle.o{object}.data),riddle.o{object}.mid);
    end


end