function valid = isValid(configPoint,border,objects)
%checks for collision

valid = 1;
%check if inside border regarding x and y
for i=1:3:length(configPoint)
valid = valid && configPoint(i) >= border(1,1) && configPoint(i) <=border(2,1) &&...
        configPoint(i+1) >= border(1,2) && configPoint(i+1) <=border(3,2);
end
%check if inside any object

%loop over objects
for object=objects
objectPoints = object{1}.data;
if ~isempty(objectPoints)
valid = valid && ~(...
        configPoint(1) >= min(objectPoints(:,1)) && configPoint(1) <= max(objectPoints(:,1)) &&...
        configPoint(2) >= min(objectPoints(:,2)) && configPoint(2) <= max(objectPoints(:,2))); 
else valid = 0;
end
    
end


end

