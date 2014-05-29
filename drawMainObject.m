%function for drawing the riddle on the fly while solving it. Gets a cell
%array figureData containing all the necessary information
function drawMainObject(figureData)

%select figure to draw on
figure(figureData.fig);

%get next Main object
figureData.Main = figureData.Main - ones(length(figureData.Main),1)*figureData.start(1,1:2) + ones(length(figureData.Main),1)*figureData.current(1,1:2);

%rotate Obstacles
rotObstacle = Rot(figureData.current(3),figureData.Obstacle,figureData.ConfObstacle(1,1:2));

plot(figureData.Rim(:,1),figureData.Rim(:,2),'black',figureData.Main(:,1),figureData.Main(:,2),'g',...
    rotObstacle(:,1),rotObstacle(:,2),'b',figureData.Target(:,1),figureData.Target(:,2),'r');
axis([-2,17,-2,12]);
hold off;

pause(0.01);

end