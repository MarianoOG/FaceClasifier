%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                                                                     %%%
%%%                          FACE RECOGNITION                           %%%
%%%                                                                     %%%
%%% extractObject.m: extracts the mouth, eyes or nose from the image,   %%%
%%%                  returns a new image and the box from the original  %%%
%%%                  image from wich it was taken                       %%%
%%%                                                                     %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [i, box] = extractObject(I, object)
    
    %%% Detection of the part of the face
    detect = vision.CascadeObjectDetector(object, 'MergeThreshold', 0);
    
    %%% Find the box (in pixels) where the part of the face is.
    box = step(detect, I);
    
    %%% Return the image if it was found or an empty matrix if no part was
    %%% found
    if isempty(box)
        i = [];
    else
        box = box(1,:);
        i = I(box(2):box(2)+box(4), box(1):box(1)+box(3));
    end
    
end