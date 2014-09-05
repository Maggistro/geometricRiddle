function diff = diffAtPoint(coeff,point)
%%
%calculates the gradient of a quadratic function at a specific point
    diff = 2*coeff(1)*point + coeff(2);
end