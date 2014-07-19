function [object] = changeOneObjectFunc(nextNode,direction,object)

    if(mod(direction,3)==0) %rotation
        rotateFunc(nextNode((object_pos-1)*3+1:object_pos*3),object);

end