function valid = isValidFunc(border,collision_set)
%returns wether the current configuration is valid or not
valid=true;

%check collision_set
%pick first object
for object_number_first = 1:length(collision_set)
    firstObject = collision_set{object_number_first};
    %check if object is inside border
    valid = valid & isInsideBorder(border,firstObject);
    
    %pick second object
    for object_number_second = object_number_first+1:length(collision_set)
        secondObject = collision_set{object_number_second};
    
        %check if second object is inside first object or otherway around
        valid = valid & isInsideFunc(firstObject,secondObject);
        if(~valid)
            return;
        end
    end
end



end