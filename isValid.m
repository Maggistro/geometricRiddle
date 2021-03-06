function valid = isValid(configPoint,borders,collision_sets)
%checks for collision

valid = 1;
%loop over the given object configurations
for i=1:3:length(configPoint)
    
    borderPoints = borders{floor((i-1)/3)+1};
    %check if inside border regarding x and y
    valid = valid && configPoint(i) >= borderPoints(1,1) && configPoint(i) <=borderPoints(2,1) &&...
            configPoint(i+1) >= borderPoints(1,2) && configPoint(i+1) <=borderPoints(3,2);
       
    %check if inside any object
    %loop over objects
    objects = collision_sets{floor((i-1)/3)+1}; % get curresponding collision set
    for object=objects' %iterate over all objects in it
        objectPoints = object{1};
        subValid=1;
        for j=1:length(objectPoints)-1
            subValid = subValid && ~((objectPoints(j,1) - objectPoints(j+1,1))*(configPoint(i+1)-objectPoints(j+1,2)) >...
            (objectPoints(j,2) - objectPoints(j+1,2))*(configPoint(i) - objectPoints(j+1,1)));
        end
        %if ~isempty(objectPoints)
        %    valid = valid && ~(...
        %        configPoint(i) >= min(objectPoints(:,1)) && configPoint(i) <= max(objectPoints(:,1)) &&...
        %        configPoint(i+1) >= min(objectPoints(:,2)) && configPoint(i+1) <= max(objectPoints(:,2)));
        %else valid = 0;
        %end    
        valid = valid && ~subValid;
    end
end

end

