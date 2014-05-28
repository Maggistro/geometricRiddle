function [ realRims ] = getRims( objectPoints, rims, objectCount,mid )
%calculates the realRims of the object o defined by its corner points,
%such that no point inside the rim is valid for object o. Rims gives 
%positions of multiple fixed rim objects.

realRims=cell(length(rims),1);
rimcount=1;
%for each rim in rims
for rim=rims    
    rimData = rim{1}.data;
    %split up the rim in convex parts
    convexRim = [];
    start=rimData(1,:); %pick start point
    vecOld = rimData(2,:) - rimData(1,:); %set start vec
    subsetCount = 1;
    subsets{subsetCount}=rimData(1,:);
    
    %search along the points of the choosen rim
    % for each step calculate vector from vecOld:i-1 to i and vec:i-1 to i+1
    % and compare. The result gives information about point i ( start ).
    for  i=2:length(rimData)
        stop=rimData(mod(i,length(rimData))+1,:); %pick end point
        vec=stop-start; %get vector from start to end
        %get angle diffrence to x-axis for each two vectors
        dirStop = sign((vecOld(2)*vec(1) - vecOld(1)*vec(2)))...
            *acos( (vec(1)*vecOld(1) + vec(2)*vecOld(2))/(norm(vec)*norm(vecOld)));
        %dirStop = acos(vec(1)/norm(vec))-acos(vecOld(1)/norm(vecOld));
        if dirStop<=0 %smaller means part will be concave
            subsets{subsetCount} = [subsets{subsetCount};rimData(i,:)];
        else %greater zero means new point is starting new part
            subsets{subsetCount} = [subsets{subsetCount};rimData(i,:)];
            subsetCount = subsetCount+1;
            subsets{subsetCount}=[];
            %subsets{subsetCount} = rim{1}(i,:);
        end
        start=rimData(mod(i-1,length(rimData))+1,:);
        vecOld = stop - start;
    end
    

    
    
    %now each subset contains a convex part of the rim
    %we then move the object along the points of each subset
    %and construct the convex hull of that set
    subsetCount=1;
    convexSubsets = cell(length(subsets),1);
    masks = cell(length(subsets),1);
    poly = cell(length(subsets),1);
    for set = subsets %for each set in subsets
        mSet = cell2mat(set);
        for i=1:size(mSet,1) %we take each value
            v=mSet(i,:);
            %and add the points of the object as seen from the origin
            %TODO: Add another loop for iterating over the rotated
            %objects saved in objectPoints beyond objectCount
                poly{subsetCount} =...
                    [poly{subsetCount};...
                    (ones(objectCount,1)*(v - mid(1:2))...
                    +objectPoints(1:objectCount,:))]; 
        end
        %calculate the points for a convex polygon
        if size(mSet,1)>2
            [convexSubsets{subsetCount},masks{subsetCount}] = getConvexPolygon(mSet,poly{subsetCount},objectCount);
        else
            convexSubsets{subsetCount} = poly{subsetCount};
            masks{subsetCount} = ones(length(poly{subsetCount}),1);
        end
        subsetCount = subsetCount + 1;
    end
    
    %now put the pieces back together. To do that we connect each start and
    %end of two adjacent subsets by finding the correct point in the
    %convexSet
    
    if(length(subsets)==1)
        convexRim = convexSubsets{1};
    else        
    for i = 1:length(subsets)-1
        %add first point of first subset
        if i==1
            convexRim = convexSubsets{i}(1,:);
        end
        
        stop = subsets{i};
        stop = stop(size(stop,1),:); % take last point of a set
        
        start = subsets{mod(i,length(subsets))+1};
        start = start(1,:); %take first point of next set
        if(stop==start)
            start = subsets{mod(i,length(subsets))+1};
            start = start(2,:); %take second point
        end
        
        connect = start - stop; % create vector beetween those two
        
        %find point to the right of connect from stop which is in a convex
        %subset. 
        
        %create vectors for stop
        maskStopSet = masks{i};
        maskStop = maskStopSet(length(maskStopSet)-objectCount+1:length(maskStopSet));
        pointsStopSet = poly{i};
        pointsStop = pointsStopSet(size(pointsStopSet,1)...
            -objectCount+1:size(pointsStopSet,1),:);
        %pointsStop = pointsStop(maskStop==1,:); % select only the points from the convex set
        vectorStop = pointsStop - ones(size(pointsStop,1),1)*stop; 
        dirStop = acos(vectorStop(:,1)./sqrt(sum(vectorStop.^2,2)))...
            - ones(size(pointsStop,1),1)*acos(connect(1)/norm(connect));
        [v,pStop] = min(dirStop); %select the one farest to the right
        
        %lengthcheck
        p=find(dirStop==v);
        if(length(p)>1) %check if there are more than one with same angle
            lengthcheck = sqrt( sum((pointsStop(p,:)-ones(size(p,1),1)*start).^2,2));
            [~,pStop] = min(lengthcheck);
            pStop=p(pStop);
        end
        
        maskStartSet = masks{mod(i,length(subsets))+1};
        maskStart = maskStartSet(1:objectCount);
        %maskStart = maskStartSet(length(maskStartSet)-objectCount+1:length(maskStartSet));
        pointsStartSet = poly{mod(i,length(subsets))+1};
        pointsStart = pointsStartSet(1:objectCount,:);%...
           % -objectCount+1:size(pointsStartSet,1),:);
       % pointsStart = pointsStart(maskStart==1,:); % select only the points from the convex set
        vectorStart = pointsStart - ones(size(pointsStart,1),1)*start;
        dirStart = acos(vectorStart(:,1)./sqrt(sum(vectorStart.^2,2)))...
            - ones(size(pointsStart,1),1)*acos(connect(1)/norm(connect));
        [v,pStart] = min(dirStart); %select the one farest to the right
  
        
        %lengthcheck
        p=find(dirStart==v);
        if(length(p)>1) %check if there are more than one with same angle
            lengthcheck = sqrt( sum( (pointsStart(p,:)-ones(size(p,1),1)*pointsStop(pStop,:)).^2,2));
            [~,pStart] = min(lengthcheck);
            pStart=p(pStart);
        end
        
        %put pieces back together
        %take only the points beetween start and stop of each set
        %startrest = pointsStartSet(objectCount+1:size(pointsStartSet,1)-objectCount,:);
        %stoprest = pointsStopSet(objectCount+1:size(pointsStopSet,1)-objectCount,:);
        
        %mask the non convex ones out
        %startrest = startrest(maskStartSet(objectCount+1:size(pointsStartSet,1)-objectCount)==1,:);
        %stoprest = stoprest(maskStopSet(objectCount+1:size(pointsStopSet,1)-objectCount)==1,:);
        
        %try using ordered convexSubsets information for points in beetween
        %end point
        if length(maskStartSet)>objectCount
            startrest = convexSubsets{i+1}(2:size(convexSubsets{i+1},1)-1,:);
        else
            startrest = [];
        end
        
        if length(maskStopSet)>objectCount
            stoprest = convexSubsets{i}(2:size(convexSubsets{i},1)-1,:);
        else
            stoprest = [];
        end
        
        
       
        %put all in the convexRim
        convexRim = [convexRim;stoprest;pointsStop(pStop,:);pointsStart(pStart,:);startrest];
        
        %NOTE: the stop points from the first set will be added last to the
        %convexRim set of points. Can be solved by using indexing for
        %convexRim and allocating it beforehead
        
        if i==length(subsets)-1
            convexRim = [convexRim;convexSubsets{i+1}(size(convexSubsets{i+1},1),:)];
        end
        
        
    end
        
    end
    %put the convexRim in final return cell
    realRims{rimcount}=convexRim;
    rimcount=rimcount+1;
    
    
    
    
    
end

end

