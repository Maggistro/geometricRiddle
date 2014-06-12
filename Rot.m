function Rpoints = Rot( phi,points,mid )
%rotiert punkte points um den punkt mid
points=points-ones(length(points),1)*mid;
R=[cosd(phi) -sind(phi);sind(phi) cosd(phi)];
Rpoints = [R*points']';
Rpoints=Rpoints + ones(length(points),1)*mid;

end

