function [] = drawPath( path, riddle )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


figureData.fig = 1;
figureData.Rim = riddle.r{1}.data;
figureData.riddle = riddle;
figureData.Target =riddle.t.data;
figureData.start = riddle.m.mid;
figureData.current = riddle.m.mid;
figureData.pause = 1;


for i=1:size(path,1)
    figureData.current = path(i,:);
    drawMainObject(figureData);
end

end

