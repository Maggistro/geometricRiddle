function [] = drawPathFunc( path, figureData,collision_set,R )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
filename='funcPath';
set(gcf, 'Renderer','zbuffer')

video = VideoWriter(filename);
video.FrameRate = 1;
open(video);

for i=1:size(path,1)     
    figureData.o = collision_set{find(sum(abs(R - ones(size(R,1),1)*path(i,:))<0.001,2)==size(R,2))};
    drawMainObjectFunc(figureData);

    drawMainObjectFunc(figureData);
    drawnow;
    pause(1);
    frame = getframe(figureData.fig);
    writeVideo(video,frame);
end
close(video);

end
