function [newPoint] = rotatePointAtPoint(oldPoint,mid,angle)
%rotates one point around another
        angle = angle/360  * 2 * pi;
        newPoint(1) = (oldPoint(1)-mid(1))*cos(angle) -...
             (oldPoint(2)-mid(2))*sin(angle) + mid(1);
         newPoint(2) = (oldPoint(1)-mid(1))*sin(angle) +...
             (oldPoint(2)-mid(2))*cos(angle) + mid(2);
end