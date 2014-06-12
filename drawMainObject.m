%function for drawing the riddle on the fly while solving it. Gets a cell
%array figureData containing all the necessary information
function drawMainObject(figureData)

%select figure to draw on
figure(figureData.fig);

%adapt objects

plot(figureData.Rim(:,1),figureData.Rim(:,2),'black');
hold on;
for objectNumber=1:length(figureData.riddle.o)
    temp = figureData.riddle.o{objectNumber};
%    if(objectNumber~=1)
%    temp.data = figureData.collision{1}{objectNumber-1}; 
%    end
    temp.data = Rot(figureData.current(objectNumber*3),temp.data,temp.mid(1:2));
    temp.data = temp.data - ones(length(temp.data),1)*temp.mid(1:2) + ones(length(temp.data),1)*figureData.current((objectNumber-1)*3+1:(objectNumber-1)*3+2);
    if(objectNumber==1)
        color='g';
    else
        color='b';
    end
    plot(temp.data(:,1),temp.data(:,2),color);
end
plot(figureData.Target(:,1),figureData.Target(:,2),'r');
axis([-2,17,-2,12]);
hold off;

pause(1);


%rotate Obstacles
%figureData.Main = Rot(figureData.current(3),figureData.Main,figureData.start(1,1:2));

%get next Main object
%figureData.Main = figureData.Main - ones(length(figureData.Main),1)*figureData.start(1,1:2) + ones(length(figureData.Main),1)*figureData.current(1,1:2);



%rotate Obstacles
%rotObstacle = Rot(figureData.current(6),figureData.Obstacle,figureData.ConfObstacle(1,1:2));

%move Obstacle
%movObstacle = rotObstacle - ones(length(rotObstacle),1)*figureData.start(1,4:5) + ones(length(rotObstacle),1)*figureData.current(1,4:5);

%movObstacle = figureData.collision{1};

end
