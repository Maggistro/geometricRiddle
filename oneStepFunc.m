function [ nextNode, collision_set ] = oneStepFunc( node,direction,curr_collision_set,riddle )
%calculates the next node and adapted collision_set in the given direction starting with the
%curr_collision_set,node and the static information in riddle
object_pos=floor(abs(direction)/4) + 1 ;

%% handle rotation
if mod(abs(direction),3) == 0
    %create new node
    tempAdd = zeros(1,length(node));
    tempAdd(abs(direction))=sign(direction)*1;
    nextNode = node + tempAdd;
    
    %rotate object to fit new configuration
    curr_collision_set{object_pos} = rotateFunc(nextNode((object_pos-1)*3+1:object_pos*3),curr_collision_set{object_pos});
    collision_set = curr_collision_set;
    return;
end

%% if object was moved, iterate trough objects and move to the next function
min_dist = inf;
nextNode = node;
ext_x=0;

inTargetCell = object_pos==1; %only check for target cell if main object is moved
for object_number=1:length(curr_collision_set) %iterate over all objects
    if(object_number==object_pos) %skip if object is moving object
        continue;
    end
    %pick object
    object = curr_collision_set{object_number};
    
    %pick function from object
    for function_number=1:length(object.coeff)
        func=object.coeff{function_number};
        def=object.def{function_number};
        
        %% calculate min_y, max_y and ext_x
           min_y = func(1)*def(1)^2 + def(1).*func(2)+func(3);%function value left border
            max_y = func(1)*def(2)^2 + def(2).*func(2)+func(3);%function value right border
            if(min_y > max_y) %switch values if set wrong
                temp_y=max_y;
                max_y = min_y;
                min_y = temp_y;
            end
         if(func(1)~=0) %if function quadratic, check for extrema
            syms x;
            symPolynom = poly2sym(func);
            ext_x = solve(diff(symPolynom,x));
            if def(1)<ext_x && def(2)>ext_x %if extrema is in range
                y = subs(symPolynom,ext_x);
                if y< min_y %check if min or max
                    min_y=y;
                else
                    max_y=y;
                end
            end
        end
        
        %% check if point is in same cell as target
        if(inTargetCell)
            
            %check if x is ok
            inTargetCell = inTargetCell &&...
                sign(node(1)-def(1)) == sign(riddle.t.mid(1) - def(1)) &&... %left border
                sign(node(1)-def(2)) == sign(riddle.t.mid(1) - def(2)) &&... %right border
                (func(1)==0||(sign(node(1)-ext_x) == sign(riddle.t.mid(1) - ext_x))); %quadratic function only
            
            %check if y is ok
            inTargetCell = inTargetCell &&...
                sign(node(2)-max_y) == sign(riddle.t.mid(2) - max_y) &&... %upper border
                sign(node(2)-min_y) == sign(riddle.t.mid(2) - min_y); %lower border
        end
        
        %% get nextNode in search direction. if function not in the way, dist = inf.
        [tempNode,dist] = moveToFunction(node,direction,curr_collision_set{object_pos},riddle,func,def);
        
        %save new minimum ( closest function in the way ) and nextNode
        if abs(dist) < min_dist
            min_dist = min(abs(min_dist),abs(dist))*sign(min_dist);
            nextNode=tempNode;
        end
    end
end

%% build new collision set from chosen node
curr_collision_set{object_pos}=moveFunc(min_dist,direction,curr_collision_set{object_pos});
collision_set = curr_collision_set;

if inTargetCell && object_pos==1
    nextNode(1:3) = riddle.t.mid;
    return
end


end

