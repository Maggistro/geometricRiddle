%calculates all combination of angles in the given range 0:angleRange
%for objectCount objects. Returns a matrix with each row containing one
%possible combination
function [ angles ] = calcAngleCombination(objectCount, angleRange)

angles = zeros(angleRange^objectCount,objectCount);
for j=2:angleRange^objectCount
        angles(j,:) = angles(j-1,:);
        angles(j,1) = angles(j,1) +1;
        for p=1:objectCount-1
            if(mod(angles(j,p),angleRange)~=0)
                break;
            else
                angles(j,p) = 0;
                angles(j,p+1) = angles(j,p+1) + 1;
            end
        end
end

end