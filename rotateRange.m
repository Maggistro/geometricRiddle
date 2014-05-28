function [ rPoints ] = rotateRange( phi,points,mid )
%rotate points of an object around the middle point mid in angles given by
%the vector phi.

points = points - ones(length(points),1)*mid;
rPoints = zeros(length(points)*length(phi),length(mid));
for i=1:length(phi)
R = [cosd(phi(i)) -sind(phi(i));sind(phi(i)) cosd(phi(i))];
rPoints((i-1)*length(points)+1:i*length(points),:) = (R'*points')';
end
rPoints = rPoints + ones(length(points)*length(phi),1)*mid;

end

