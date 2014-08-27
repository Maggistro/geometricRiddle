function [object] = moveFunc(diff,dir,object)
%moves the object in direction dir by the distance diff

if(mod(abs(dir),3)==1) %along x axis
    for function_number=1:length(object.coeff)%iterate over all functions
       func = object.coeff{function_number};
       if func(1)==0 %function is linear
           %b(x-d)+c = bx + ( -bd + c)
           func(3)=-func(2)*diff+func(3);  
       else %function is quadratic
           %a(x-d)^2 + b(x-d) + c =
           %ax^2 - 2adx + ad^2 + bx - bd + c =
           %ax^2 + (-2ad + b)x + (ad^2 - bd + c)
           b = -2*func(1)*diff + func(2);
           c = func(1)*diff^2 - diff*func(2) + func(3);
           func(2)=b;
           func(3)=c;
       end
       object.coeff{function_number}=func;
       object.def{function_number}=object.def{function_number}+diff;
    end
    object.mid(1) = object.mid(1) + diff;
elseif(mod(abs(dir),3)==2)%along y axis
    for function_number=1:length(object.coeff)%iterate over all functions
       func = object.coeff{function_number};
       func(3) = func(3) + diff;
       object.coeff{function_number}=func;       
    end
    object.mid(2)=object.mid(2) + diff;
else
    error('not a valid direction to move object along');
end