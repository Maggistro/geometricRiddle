function valid = isInsideBorder(border,object)
%checks if object is inside the border defined by the 4 border points

valid = true;
for func_number=1:length(object.coeff)
    obj_func = object.coeff{func_number};
    obj_def = object.def{func_number};
    %% check for left/right
    valid = valid && (border(1,1)<obj_def(1) &&...
        border(3,1)>obj_def(1));
    
    %% check for up/down
    %calculate function values
    objValue_min = obj_func(1) + obj_def(1)*obj_func(2) + (obj_def(1)^2)*obj_func(3);
    objValue_max = obj_func(1) + obj_def(2)*obj_func(2) + (obj_def(2)^2)*obj_func(3);
    
    %check for max/min
    if objValue_min>objValue_max
        temp = objValue_min;
        objValue_min=objValue_max;
        objValue_max=temp;
    end
    
    valid = valid && (border(1,2) < objValue_min &&...
        border(3,2) > objValue_max);
    
    if ~valid
        return;
    end
end

end