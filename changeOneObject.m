function newObject = changeOneObject(direction,object)
%changes an object according to direction


%rotate object
rotObject = Rot(direction(3),object.data,object.mid(1:2));

%move object
newObject.data = rotObject - ones(length(rotObject),1)*object.mid(1,1:2) + ones(length(rotObject),1)*direction(1:2);
newObject.mid = direction;
end