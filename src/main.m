%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                                                                     %%%
%%%                          FACE RECOGNITION                           %%%
%%%                                                                     %%%
%%% main.m: Uses the results of previous scripts to select an image,    %%%
%%%         load the neural network, clasify the image while displaying %%%
%%%         the results.                                                %%%
%%%                                                                     %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Select an image 
[filename, pathname] = uigetfile('..\img\*.jpg','File Selector');
Img = imread([pathname,filename]);

%%% Extract Features from selected image
feat = featureExtraction(Img, true);

%%% Load and use neural network to classify image
addpath('..\out')
load net
out = sim(net,feat);

%%% Show infomation of classification on figure
subplot(1,3,1)
title(['Original Image - ',  pathname(end-8:end-1)])
subplot(1,3,3)
if out(1)>out(2)
    title(['Cassified as Subject0 - ', num2str(out(1)*100), '%'])
else
    title(['Cassified as Subject1 - ', num2str(out(2)*100), '%'])
end

%%% Note: the percentage means how certain the classification is
