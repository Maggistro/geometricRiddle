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
    %if(objectNumber==2)
    %    
    %temp = rotateFunc([figureData.o{objectNumber}.mid(1:2) -15],figureData.o{objectNumber});
    %end

    for func_number = 1:length(temp.coeff)   
        points=[];
        values=[];
        %pick function
        func = temp.coeff{func_number};
        def = temp.def{func_number}';
        points = [points, def(1), def(2)];
        values = [values,func(1)*def(1)*def(1) + func(2)*def(1) + func(3),...
                        func(1)*def(2)*def(2) + func(2)*def(2) + func(3)];   
 
        if(objectNumber==1)
            color='g';
        else
            color='b';
        end
        plot(points,values,color);
    end
    
    plot(temp.mid(1),temp.mid(2),'*');
end

%% plot target
target = figureData.Target;
for func_number = 1:length(target.coeff)
    %pick function
    func = target.coeff{func_number};
    def = target.def{func_number}';
    values =[ func(1)*def(1)*def(1) + func(2)*def(1) + func(3),...
                        func(1)*def(2)*def(2) + func(2)*def(2) + func(3)];
    plot(def,values,'r');
    
end
axis([-2,17,-2,12]);
hold off;

if figureData.pause>0
    pause(figureData.pause);
end

end