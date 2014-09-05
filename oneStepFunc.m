function [ nextNode, collision_set ] = oneStepFunc( node,direction,curr_collision_set,riddle )
%calculates the next node and adapted collision_set in the given direction starting with the
%curr_collision_set,node and the static information in riddle
object_pos=floor((abs(direction)-1)/3) + 1 ;

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
if(inTargetCell) %if main object, calculate connection to target
    object = curr_collision_set{object_pos}; %pick main object
    %connection = cell(length(object.coeff),1); % init connection array
    px = object.def{1}(1);
    for i=1:length(object.coeff)
        if px==object.def{i}(1); %pick next x-coordinate ( move along border )
            px=object.def{i}(2);
            tx=riddle.t.def{i}(2);
        else
            px=object.def{i}(1);
            tx=riddle.t.def{i}(1);
        end
        %calculate y-coordinate
        py = object.coeff{i}(1)*px*px + object.coeff{i}(2)*px + object.coeff{i}(3);
        ty = riddle.t.coeff{i}(1)*tx*tx + riddle.t.coeff{i}(2)*tx + riddle.t.coeff{i}(3);
        connection.coeff(i)={[ (py-ty)/(px-tx) , py - (py-ty)/(px-tx)*px ]}; %set function
        %check for maximum
        if(px > tx) %switch values if set wrong
                temp_y=tx;
                tx = px;
                px = temp_y;
        end
        connection.def(i)={[px tx]}; %set definition range
    end
end


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
            inBeetween = [];
            for i=1:length(connection.coeff)
            if(func(1)==0) %linear case
                x1=(connection.coeff{i}(2)-func(3))/(func(2) - connection.coeff{i}(1));
                x2=x1;
            else %quadratic case
                a=func(1);
                b=func(2)-connection.coeff{i}(1);
                c=func(3)-connection.coeff{i}(2);
                root = b^2 - 4*a*c;
                if root==0 % if solution exists
                    x1 = (-b)/(2*a);
                    x2=x1;
                elseif root>0
                    x1 = (-b + sqrt(root))/(2*a);
                    x2 = (-b - sqrt(root))/(2*a);
                end
            end
        
            %check for crossing point
            if (((def(1)<=x1 && def(2)>=x1) || (def(1)<=x2 && def(2)>=x2)) &&...%check for func border
                ((connection.def{i}(1)<=x1 && connection.def{i}(2)>=x1) || (connection.def{i}(1)<=x2 && connection.def{i}(2)>=x2))) %check if beetween main and target
                        inTargetCell = false; %assume false
          
                %check if parallel
                if abs(func(2)-connection.coeff{i}(1)) < 0.001
                    inTargetCell = true;
                end
                
                %check if only point
                if (abs(def(1) - x1) ==0 || abs(def(1) - x2) ==0 ||...
                    abs(def(2) - x1) ==0 || abs(def(2) - x2) ==0)
                    inTargetCell = true; 
                end
                
            elseif ((connection.def{i}(1)<=x1 && connection.def{i}(2)>=x1) || (connection.def{i}(1)<=x2 && connection.def{i}(2)>=x2))
                %mark if beetween connection lines
                inBeetween = [inBeetween,connection.coeff{i}(1)*def(1) + connection.coeff{i}(2) < min_y];
             end
            end
            
            %check if beetween connection lines
            if(sum(inBeetween)~=length(connection.coeff) && sum(inBeetween)~=0)
                inTargetCell = false;
            end
            
        end
        
        %% get nextNode in search direction. if function not in the way, dist = inf.
        [tempNode,dist] = moveToFunction(node,direction,curr_collision_set{object_pos},riddle.b,func,def,object.above{function_number});
        
        %save new minimum ( closest function in the way ) and nextNode
        if abs(dist) < abs(min_dist)
            min_dist = min(abs(min_dist),abs(dist))*sign(dist);
            nextNode=tempNode;
        end
    end
end

%% build new collision set from chosen node
curr_collision_set{object_pos}=moveFunc(min_dist,direction,curr_collision_set{object_pos});
collision_set = curr_collision_set;

if inTargetCell
    nextNode(1:3) = riddle.t.mid;
    return
end


end

