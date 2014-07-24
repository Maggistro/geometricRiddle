function [object] = rotateFunc(newConf, object)
%rotates the functions in object around object.mid

for func_number=1:length(object.coeff)
    mid = object.mid(1:2);
    angleDiff = newConf(3)-object.mid(3);
    func=object.coeff{func_number};
    def = object.def{func_number};
    
    %if linear just rotate endpoints and recalculate coefficients 
    if(func(1)==0)
        %get points at range borders
        min_point = [def(1),func(2)*def(1)+func(3)];
        max_point = [def(2),func(2)*def(2)+func(3)];
        
        %rotate points
        rot_min=rotatePointAtPoint(min_point,mid,angleDiff);      
        rot_max = rotatePointAtPoint(max_point,mid,angleDiff); 
         %check if min is now max
         if(rot_min(1)>rot_max(1)) %change order
            %set new range borders
            def(1)=rot_max(1);
            def(2)=rot_min(1);
         
            %recalculate coefficients
            func(2) = (rot_min(2)-rot_max(2))/(def(2)-def(1));
            func(1) = rot_max(2) - func(2)*def(1);
         elseif(rot_min(1)==rot_max(1)) % REALLY BAD
            %TODO: think of someway to represent this
         else
            %set new range borders
            def(1)=rot_min(1);
            def(2)=rot_max(1);
         
            %recalculate coefficients
            func(2) = (rot_max(2)-rot_min(2))/(def(2)-def(1));
            func(1) = rot_min(2) - func(2)*def(1);
         end
         object.coeff{func_number}=func;
         object.def{func_number} = def;
         
    else %rotate three points on the function for reconstruction
         %and two extra point for checking if its still a function
        %get point in the middle of range
        tPoint(1) = (def(2)+def(1))/2;
        tPoint(2) = func(3)*tPoint(1) + func(2)*tPoint + func(3);
        
        %get checkPoints
        checkPointMin(1) = def(1)+0.001;
        checkPointMin(2) = func(3)*checkPointMin(1) + func(2)*checkPointMin + func(3);
        
        checkPointMax(1) = def(2) - 0.001;
        checkPointMax(2) = func(3)*checkPointMax(1) + func(2)*checkPointMax + func(3);
       
        
        %get points at range borders
        min_point = [def(1),func(2)*def(1)+func(3)];
        max_point = [def(2),func(2)*def(2)+func(3)];
        
        %rotate all points
        rot_tPoint = rotatePointAtPoint(tPoint,mid,angleDiff);
        rot_min = rotatePointAtPoint(min_point,mid,angleDiff);
        rot_max = rotatePointAtPoint(max_point,mid,angleDiff);
        checkPointMinRot = rotatePointAtPoint(checkPointMin,mid,angleDiff);
        checkPointMaxRot = rotatePointAtPoint(checkPointMax,mid,angleDiff);
        
        %check if endpoints are still endpoints
        if checkPointMinRot(1)>=rot_min(1) && checkPointMaxRot(1)<=rot_max(1) %everything allright?
            %refit a function to the tree points
            func=polyFit([rot_min(1),tPoint(1),rot_max(1)],...
                [rot_min(2),tPoint(2),rot_max(2)],2);
        elseif checkPointMinRot(1)>rot_min(1)
            %TODO:
        elseif checkPointMaxRot(1)>rot_max(1)
            %TODO:
        end
        
        object.coeff{func_number}=func;
        object.mid(3) = object. mid(3) + angleDiff;
end

end