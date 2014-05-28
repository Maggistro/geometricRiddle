function [ configs ] = configValid( riddle, varargin )
%calculates the valid configuration space for all movable objects
%optional parameter is a boolean array which gives information about the
%active(changable) dimensions per object. It dimension is number of
%object x dimensions per object

if(nargin>0) %if specified set enabled dimensions in array
    dimensionsEnabled = varargin;
    rotation = length(dimensionsEnabled(1,:));
else %if not activate all dimensions as default.
    dimensionsEnabled = ones(length(riddle.o),length(riddle.o{1}));
end

%for each object in riddle.o
for i=1:length(riddle.o)
   object = riddle.o{i}; %get object from cell
   objectAnchor = riddle.c{i};
   %save in array each rotation
   tempO = rotateRange(riddle.rotRange*dimensionsEnabled(i,rotation)...%rotate this
                ,object... % object
                ,objectAnchor(1:rotation-1)); %around this point
   %get rims for each rotation of object in tempO
   configs{i} = getRims(tempO,riddle.r,length(object),objectAnchor); 
end

%identify the space the object is in. each rim is then a border which is
%not to be crossed by moving the object.
%TODO: find a way to express the main rim ( border ) of the full puzzle
%TODO: split the configurationspace in tiles by expanding the vectors of
%the non-mainrim rims in the direction they are pointing ( excluding the
%connection vectors beetween the convex subsets ). Each tile can then be
%seen as a valid position in the search graph.


end

