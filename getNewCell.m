function newCell = getNewCell(node,collision_set,funcCount)
%function calculates the cell id from node and collision set


%build function array
funcArray = zeros(funcCount,3);

oldPos=0;
for object_number=1:length(collision_set)
    object = collision_set{object_number};
    for func_number=1:length(object.coeff)
        func = object.coeff{func_number};
        funcArray(oldPos+func_number,:) = func;
    end
    oldPos=oldPos+length(object.coeff);
end

%each cell line consists of a hash for the functions and one rotation
%identifier
newCell = zeros(1,length(node)/3 + length(node)/3);

%iterate over node
for i=1:3:length(node)
    %build x value array
    xValue = ones(funcCount,1)*[node(i)^2,node(i),1];
    
    %Evaluate functions
    yValue = sum(funcArray.*xValue,2);
    
    %compare to y value in node to get binary list
    eval = (yValue<node(i+1))';
    hash = 0;
    for pos=1:length(eval)
        hash = hash + eval(pos)*2^(length(eval)-pos);
    end
    newCell(floor(i/3)+1) = hash;
    
    %set rotation
    newCell(length(node)/3 + floor(i/3) + 1) = node(i+2);
    
end

end