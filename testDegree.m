clear all;

objectCount = 3;
angleRange = 360;

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

