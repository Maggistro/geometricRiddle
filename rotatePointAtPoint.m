function [newPoint] = rotatePointAtPoint(oldPoint,mid,angle)
%rotates one point around another
        newPoint(1) = (oldPoint(1)-mid(1))*cos(angle) -...
             (oldPoint(2)-mid(2))*sin(angleDiff) + mid(1);
         newPoint(2) = (oldPoint(1)-mid(1))*sin(angle) +...
             (oldPoint(2)-mid(2))*cos(angleDiff) + mid(2);
end