%function for drawing the riddle on the fly while solving it. Gets a cell
%array figureData containing all the necessary information
function drawMainObject(figureData)

%select figure to draw on
figure(figureData.fig);

%get next Main object
figureData.Main = figureData.Main - ones(length(figureData.Main),1)*figureData.start(1,1:2) + ones(length(figureData.Main),1)*figureData.current(1,1:2);

%rotate Obstacles
rotObstacle = Rot(figureData.current(6),figureData.Obstacle,figureData.ConfObstacle(1,1:2));

%move Obstacle
movObstacle = rotObstacle - ones(length(rotObstacle),1)*figureData.start(1,4:5) + ones(length(rotObstacle),1)*figureData.current(1,4:5);

%movObstacle = figureData.collision{1};

plot(figureData.Rim(:,1),figureData.Rim(:,2),'black',figureData.Main(:,1),figureData.Main(:,2),'g',...
    movObstacle(:,1),movObstacle(:,2),'b',figureData.Target(:,1),figureData.Target(:,2),'r');
axis([-2,17,-2,12]);
hold off;

pause(1);

end
