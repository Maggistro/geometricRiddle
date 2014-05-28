function path = path_by_grassfire( choosen,K_o,KKR_oh,start,target)
%calculates the path rekursivly from K.O to K.Z without entering KKR_oh

if(start==target)
    path=target;
    return;
else
    if(isValid(start,K_o,KKR_oh))
        %set directions
        dir_x_plus=start+[0.1,0,0];
        dir_x_minus=start+[-0.1,0,0];
        dir_y_plus=start+[0,0.1,0];
        dir_y_minus=start+[0,-0.1,0];
        %add point to visited list
        choosen=[choosen;start];
        
        %check if next points where already visited
        path1=[];
        path2=[];
        path3=[];
        path4=[];
        if(~(sum(ismember(dir_x_plus,choosen))==3))
        path1=path_by_grassfire(choosen,K_o,KKR_oh,dir_x_plus,target);
        end
        if(~(sum(ismember(dir_x_plus,choosen))==3))
        path2=path_by_grassfire(choosen,K_o,KKR_oh,dir_x_minus,target);
        end
        if(~(sum(ismember(dir_x_plus,choosen))==3))
        path3=path_by_grassfire(choosen,K_o,KKR_oh,dir_y_plus,target);
        end
        if(~(sum(ismember(dir_x_plus,choosen))==3))
        path4=path_by_grassfire(choosen,K_o,KKR_oh,dir_y_minus,target);
        end
        
        
        if(sum(ismember(target,path1))==3)
            path=[start;path1];
        elseif(sum(ismember(target,path2))==3)
            path=[start;path2];
        elseif(sum(ismember(target,path3))==3)
            path=[start;path3];
        elseif(sum(ismember(target,path4))==3)
            path=[start;path4];
        else
            path=[];
        end
    else
        path=[];
        return;
    end
end


end

