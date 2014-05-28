function nextNode = oneStep(node,direction,objects)
%calculates the next node in the direction on an extended vector from 
%objects' bordervectors

%check an object other than the main object is moved. If so just return the
%same point. Valid check will elimate it later.
if direction > 2
    nextNode = node;
    return;
end

%if main object was moved, iterate trough objects and calculate extended
%vectors
for object=objects
    points = object.data;
    for i=1:length(points)
        diff = points(i+1,:) - points(i,:);
        d = abs(diff(1)*node(1) - diff(2)*node(2) - ...
            points(i,1)*points(i+1,2) + points(i+1,1)*points(i,2));
        d = d/sqrt(diff(1)^2 + diff(2)^2);
    end
end

end