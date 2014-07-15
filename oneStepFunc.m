function [ nextNode_ ] = oneStepFunc( node,direction,riddle,jump_over )
%calculates the next node in the direction


%check an object other than the main object is moved. If so just return the
%same point. Valid check will elimate it later.
%newCollSet = collSet;
object_pos=floor(abs(direction)/4) + 1 ;

%handle rotation
if mod(abs(direction),3) == 0
    %create new node
    tempAdd = zeros(1,length(node));
    tempAdd(abs(direction))=sign(direction)*1;
    nextNode = node + tempAdd;
    
    %rotate object to fit new configuration
    riddle.o{object_pos} = changeOneObjectFunc(nextNode((object_pos-1)*3+1:object_pos*3),riddle.o{object_pos});
    
    %    for object=1:length(riddle.o)
    %        temp = riddle.o;
    %        temp(object) = [];
    %        newCollSet{object}= getRims(riddle.o{object}.data,temp,...
    %            length(riddle.o{object}.data),riddle.o{object}.mid);
    %    end
    return;
end

%if object was moved, iterate trough objects and move to the next border
min_dist = inf;
nextNode = node;

node_to_target = (riddle.t.mid(1:2)-node(1:2))'; %distance for mainobject to target
inTargetCell = object_pos==1; %only check for target cell if main object is moved
for object_number=1:length(riddle.o) %iterate over all objects
    if(object_number==object_pos) %skip if object is moving object
        continue;
    end
    %pick object
    object = riddle.o{object_number};
    
    %pick function from object
    for function_number=1:length(object.coeff)
        func=object.coeff{function_number};
        def=object.def{function_number};
        
        %calculate min_y, max_y
        if(func(3)==0) %linear function
            min_y = func(1) + def(1).*func(2);%function value left border
            max_y = func(1) + def(2).*func(2);%function value right border
            if(min_y > max_y) %switch values if set wrong
                temp_y=max_y;
                max_y = min_y;
                min_y = temp_y;
            end
        else
            %TODO: solve quadratic function for min/max
            %TODO: save x coordinate in ext_x
        end
        
        %check if point is in same cell as target
        if(inTargetCell)
            
            %check if x is ok
            inTargetCell = inTargetCell &&...
                sign(node(1)-def(1)) == sign(riddle.t.mid(1) - def(1)) &&... %left border
                sign(node(1)-def(2)) == sign(riddle.t.mid(1) - def(2)) &&... %right border
                (func(3)==0||(sign(node(1)-ext_x) == sign(riddle.t.mid(1) - ext_x))); %quadratic function only
            
            %check if y is ok
            inTargetCell = inTargetCell &&...
                sign(node(2)-max_y) == sign(riddle.t.mid(2) - max_y) &&... %upper border
                sign(node(2)-min_y) == sign(riddle.t.mid(2) - min_y); %lower border
        end
        %move in direction. if function not in the way, dist = inf.
        [tempNode,dist] = moveToFunction(node,direction,riddle.o{object_pos},func,def);
        
        %save new minimum and new point on line
        if abs(dist) < min_dist
            min_dist = min(min_dist,abs(d));
            nextNode=tempNode;
        end
    end
end

if inTargetCell && object_pos==1
    nextNode(1:3) = riddle.t.mid;
    return
end


end

