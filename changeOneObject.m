function newObject = changeOneObject(direction,object)
%changes an object according to direction
newObject = object;
if( mod(abs(direction)-4,3) + 1)>2 %check if not x,y direction
    %rotate object
    newObject.data = Rot(sign(direction),object.data,object.mid(1:2));
else %if x,y move object with oneStep
    object.data(:,mod(abs(direction)-4,3) + 1) =...
        object.data(:,mod(abs(direction)-4,3) + 1) + sign(direction);
    newObject.data = object.data;
end

    newObject.mid(mod(abs(direction)-4,3) + 1) = object.mid(mod(abs(direction)-4,3) + 1) + sign(direction);

end