function [] = drawPathFuncCell(Pathset,figureData)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
filename='cellPath';
set(gcf, 'Renderer','zbuffer')

video = VideoWriter(filename);
video.FrameRate = 1;
open(video);

for i=1:size(Pathset,2)  
    figureData.o = Pathset(i);
    figureData.o = figureData.o{1};
    drawMainObjectFunc(figureData);
    drawnow;
    pause(1);
    frame = getframe(figureData.fig);
    writeVideo(video,frame);
end
close(video);

end
