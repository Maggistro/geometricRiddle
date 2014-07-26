function [] = drawMainObjectFunc(figureData)
%select figure to draw on
figure(figureData.fig);

%% plot border
plot([figureData.b(:,1);figureData.b(1,1)],[figureData.b(:,2);figureData.b(1,2)],'black');
hold on;

%% plot objects
for objectNumber=1:length(figureData.o)
    %pick object
    temp = figureData.o{objectNumber};
    for func_number = 1:length(temp.coeff)
        %pick function
        func = temp.coeff{func_number};
        def = temp.def{func_number}';
        points = def(1):0.001:def(2);
        values = subs(poly2sym(func),points);
        
        if(objectNumber==1)
            color='g';
        else
            color='b';
        end
        plot(points,values,color);      
    end
end

%% plot target
target = figureData.Target;
for func_number = 1:length(target.coeff)
    %pick function
    func = target.coeff{func_number};
    def = target.def{func_number}';
    points = def(1):0.001:def(2);
    values = subs(poly2sym(func),points);
    plot(points,values,'r');
    
end
axis([-2,17,-2,12]);
hold off;

if figureData.pause>0
    pause(figureData.pause);
end

end