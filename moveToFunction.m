function [ nextNode,dist ] = moveToFunction(node, direction,object,border,func,def,above)
%moves the object in the direction dir to the function func defined
%in the range def searching for the nextNode for object object

nextNode = node;
dist = inf; %no valid nextNode
%iterate over all functions in object,find crossing and remember the
%closest function ( smallest movement of center towards direction )

%calculate funcValue at ends of defenition range
funcValue_min = (def(1)^2)*func(1) + def(1)*func(2) + func(3);
funcValue_max = (def(2)^2)*func(1) + def(2)*func(2) + func(3);

for obj_function_number = 1:length(object.coeff)
    %get current function and range
    obj_func = object.coeff{obj_function_number};
    obj_def = object.def{obj_function_number};
    
    % move along y coordinate ( up/down)
    if(mod(abs(direction),3)==2)
        %% get the x-range used by both function ( inner borders )
        min_y = (def(1)>obj_def(1))*def(1) + (def(1)<=obj_def(1))*obj_def(1);
        max_y = (def(2)<=obj_def(2))*def(2) + (def(2)>obj_def(2))*obj_def(2);
        
        %% check if function lies in the way
        if(min_y > max_y) % if no common range exists, take borders
            %% calculate function values
            objValue_min = (obj_def(1)^2)*obj_func(1) + obj_def(1)*obj_func(2) + obj_func(3);
            objValue_max = (obj_def(2)^2)*obj_func(1) + obj_def(2)*obj_func(2) + obj_func(3);
            
            %check for max/min
            if objValue_min>objValue_max
                temp = objValue_min;
                objValue_min=objValue_max;
                objValue_max=temp;
            end
            
            
            if(sign(direction)==-1) % down the y axis
                diff_min = border(1,2) - objValue_min;
                diff_max = border(1,2) - objValue_max;
            else % up the y axis
                diff_min = border(3,2) - objValue_max;
                diff_max = border(3,2) - objValue_min;
            end
        elseif(min_y<=max_y) %start to find collision
            
            %% calculate function values
            objValue_min = (min_y^2)*obj_func(1) + min_y*obj_func(2) + obj_func(3);
            objValue_max = (max_y^2)*obj_func(1) + max_y*obj_func(2) + obj_func(3);
            
            %check for max/min
            if objValue_min>objValue_max
                temp = objValue_min;
                objValue_min=objValue_max;
                objValue_max=temp;
            end
            
            if funcValue_min>funcValue_max
                temp = funcValue_min;
                funcValue_min=funcValue_max;
                funcValue_max=temp;
            end
            
            
            diff_min = funcValue_min - objValue_min;
            diff_max = funcValue_max - objValue_max;
            
            %% check if function collide
            %if(sign(diff_min)~=sign(diff_max))
            %    if(sign(diff_min)~=0 && sign(diff_max)~=0)
            %        error('invalid state. Collision before movement detected');
            %    end
            %end
            
            if(diff_min==0 || diff_max==0) %check if object function overlapps function
                %check if overlapp is a point
                if(objValue_min == objValue_max)
                    continue;
                end
                %check if function borders the object on the other side
                if(sign(direction)==sign(object.above{obj_function_number})) 
                    continue;
                end
            end %else calculate
            
            
            
            
            %% check if func lies in search direction
            %if(sign(diff_min)~=sign(direction))
            %    return;
            %end
            
        end
        %% choose smaller distance...
        if(abs(diff_min)<abs(diff_max) && abs(diff_min)<abs(dist))
            nextNode(abs(direction)) = node(abs(direction)) + diff_min; %... and nextNode;
            dist = diff_min;
        elseif(abs(diff_max)<abs(dist))
            nextNode(abs(direction)) = node(abs(direction)) + diff_max; %... and nextNode;
            dist = diff_max;
        end
    else %  move along x coordinate (right/left)
        %% calculate function values
        objValue_min = (obj_def(1)^2)*obj_func(1)  + obj_def(1)*obj_func(2) + obj_func(3);
        objValue_max = (obj_def(2)^2)*obj_func(1)  + obj_def(2)*obj_func(2) + obj_func(3);
        
        %% get the y-range used by both function ( inner borders )
        min_y = (objValue_min>funcValue_min)*objValue_min + (objValue_min<=funcValue_min)*funcValue_min;
        max_y = (objValue_max<funcValue_max)*objValue_max + (objValue_max>=funcValue_max)*funcValue_max;
        
        if(min_y > max_y) % if no common range exists, jump to next function
            if(sign(direction)==-1)
                diff_min = border(1,1) - obj_def(1);
                diff_max = border(1,1) - obj_def(2);
            else
                diff_min = border(3,1) - obj_def(2);
                diff_max = border(3,1) - obj_def(1);
            end
            
        elseif(min_y<=max_y)
            
            
            %% calculate x values to min_y and max_y
            %linear functions
            if(func(1)==0)
                if(func(2)==0)
                    funcX_min = def(1);
                    funcX_max = def(2);
                else
                    funcX_min = (min_y - func(3))/func(2);
                    funcX_max = (max_y - func(3))/func(2);
                end
            else%quadratic functions
                [x1_min,x2_min]=solve(poly2sym([func(1),func(2),func(3)-min_y]));
                [x1_max,x2_max]=solve(poly2sym([func(1),func(2),func(3)-max_y]));
                
                %choose x nearest to the object using search direction sign
                if(sign(direction)==-1)
                    funcX_min = (x1_min>x2_min)*x1_min +(x1_min<=x2_min)*x2_min;
                    funcX_max = (x1_max>x2_max)*x1_max +(x1_max<=x2_max)*x2_max;
                else
                    funcX_min = (x1_min<x2_min)*x1_min +(x1_min>=x2_min)*x2_min;
                    funcX_max = (x1_max<x2_max)*x1_max +(x1_max>=x2_max)*x2_max;
                end
            end
            
            %linear functions
            if(obj_func(1)==0)
                if(obj_func(2)==0)
                    objX_min = obj_def(1);
                    objX_max = obj_def(2);
                else
                    objX_min = (min_y - obj_func(3))/obj_func(2);
                    objX_max = (max_y - obj_func(3))/obj_func(2);
                end
            else%quadratic functions
                [x1_min,x2_min]=solve(poly2sym([obj_func(1),obj_func(2),obj_func(3)-min_y]));
                [x1_max,x2_max]=solve(poly2sym([obj_func(1),obj_func(2),obj_func(3)-max_y]));
                
                %choose x nearest to the function using search direction sign
                if(sign(direction)==-1)
                    objX_min = (x1_min<x2_min)*x1_min +(x1_min>=x2_min)*x2_min;
                    objX_max = (x1_max<x2_max)*x1_max +(x1_max>=x2_max)*x2_max;
                else
                    objX_min = (x1_min>x2_min)*x1_min +(x1_min<=x2_min)*x2_min;
                    objX_max = (x1_max>x2_max)*x1_max +(x1_max<=x2_max)*x2_max;
                end
            end
            
            
            diff_min = funcX_min - objX_min;
            diff_max = funcX_max - objX_max;
        %% check if function collide
        %if(sign(diff_min)~=sign(diff_max))
        %    if(sign(diff_min)~=0 && sign(diff_max)~=0)
        %        error('invalid state. Collision before movement detected');
        %    end
        %end
        
        %if(diff_min==0 || diff_max==0) %check if object lies besides function
        %    if(sign(direction)==sign(above)) %if object is moving away from function
        %        continue;
        %    end
        %end
        
        if(diff_min==0 ||diff_max==0) %object function overlapps function
            if diff_min==0 %pick the point at which the functions overlapp
                contactPoint = objX_min;
            else
                contactPoint = objX_max;
            end
            %calculate the relative position of object to function ( >0 =
            %left, <0 = right )
            relPos = object.above{obj_function_number} * diffAtPoint(obj_func,contactPoint);
            %continue if bordered at other side or horizontal line
            if (sign(direction)~=sign(relPos)) || (relPos == 0) 
                continue;
            end
        end %else calculate the needed movement
        
        %% check if func lies in search direction
        if(sign(diff_min)~=sign(direction) && diff_min ~=0)
            return;
        end
        end
        
        %% choose smaller distance...
        if(abs(diff_min)<abs(diff_max)&&abs(diff_min)<abs(dist))
            nextNode(abs(direction)) = node(abs(direction)) + diff_min; %... and nextNode;
            dist = diff_min;
        elseif(abs(diff_max)<abs(dist))
            nextNode(abs(direction)) = node(abs(direction)) + diff_max; %... and nextNode;
            dist = diff_max;
        end
        if nextNode==[7.5 5 0 7.5 8 0 7.5 5 0 7.5 2 0]
            node;
        end
        
    end
end


end