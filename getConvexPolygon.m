function [ tempConvex,mask ] = getConvexPolygon( set, poly, objectCount )
%generates a binary mask for the pointset poly which indicates the points
%that form the convex hull of the set and object with a 1
%we know that in poly there are  length(set) x objectCount points with each set of
%objectCount refering to a specific point in the starting polygon set

tempConvex=zeros((length(set)-1)*2,2);
mask = zeros(length(poly),1);
for i=1:length(set)-1
    start = set(i,:); %starting point in set
    stop = set(i+1,:);%end point in next set
    vec = stop-start; %vector from start to stop
    %find connection point in poly at start to next point stop
    dir = zeros(objectCount,1);
    for j=(i-1)*objectCount+1:i*objectCount %iterate over all points at start
        startCon = poly(j,:); %pick point
        vecCon = stop-startCon;%get vector from point to stop
        %get angle diffrence to x-axis for each two vectors vec and vecCon
        dir(j-(i-1)*objectCount) = sign((vecCon(2)*vec(1) - vecCon(1)*vec(2)))...
    *acos( (vec(1)*vecCon(1) + vec(2)*vecCon(2))/(norm(vec)*norm(vecCon))); 
    end
    %get the point farest to the right from the vec start->stop
    [v,~] = max(dir); %maybe check if only positiv?? should not happen
    p=find(dir==v);
    if(length(p)>1) %check if there are more than one with same angle
    lengthcheck = sqrt(sum((poly((i-1)*objectCount + p,:)-ones(length(p),1)*stop).^2,2));
    [~,pPos] = max(lengthcheck);
    p=p(pPos);
    end
    startCon = poly((i-1)*objectCount + p,:);
    tempConvex((i-1)*2 + 1,:) = startCon;
    mask((i-1)*objectCount + p)=1;
    vecHalfCon = stop-startCon;
  
    %find connection point in poly at stop for startCon
    dir = zeros(objectCount,1);
    for j=i*objectCount+1:(i+1)*objectCount %iterate over all points at stop
        stopCon = poly(j,:); %pick point
        vecCon = stopCon-startCon;%get vector from point to stop
        %get angle diffrence to x-axis for each two vectors vec and vecCon
        dir(j-i*objectCount) = sign((vecCon(2)*vecHalfCon(1) - vecCon(1)*vecHalfCon(2)))...
    *acos( (vecHalfCon(1)*vecCon(1) + vecHalfCon(2)*vecCon(2))/(norm(vecHalfCon)*norm(vecCon)));
    end
    
    %get the point farest to the right from the vec startCon->stop
    %also farest away for same angles
    [v,~] = min(dir); %maybe check if only negativ?? should not happen
    p=find(dir==v);
    if(length(p)>1) %check if there are more than one with same angle
    lengthcheck = sqrt(sum((poly(i*objectCount + p,:)-ones(length(p),1)*startCon).^2,2));
    [~,pPos] = max(lengthcheck);
    p=p(pPos);
    end
    %stopCon = poly(i*objectCount + p,:); %information not needed
    mask(i*objectCount + p)=1;
    tempConvex((i-1)*2 + 2,:) = poly(i*objectCount +p,:);
    
end

    


end

