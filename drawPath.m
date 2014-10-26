function [] = drawPath( path, figureData )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
filename='vectorPath';
set(gcf, 'Renderer','zbuffer')

video = VideoWriter(filename);
video.FrameRate = 1;
open(video);

for i=1:size(path,1)
    figureData.current = path(i,:);
    drawMainObject(figureData);
    drawnow;
    pause(1);
    frame = getframe(figureData.fig);
    writeVideo(video,frame);
end
close(video);

end

