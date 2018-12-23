%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                                                                     %%%
%%%                          FACE RECOGNITION                           %%%
%%%                                                                     %%%
%%% neuralNetworkTraining.m: have the functionality to create and train %%%
%%%                          the neural network that will clasify the   %%%
%%%                          images.                                    %%%
%%%                                                                     %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Define the input variables
addpath('../data')
input = [];
load Subject0
input = [input;F(1:200,:)];
load Subject1
input = [input;F(1:200,:)]';

%%% Define the target variable
target = [ones(200,1),zeros(200,1); ...
          zeros(200,1),ones(200,1)]';

%%% Parameters for Neural Network
numHiddenNeurons = 20;            % Number of hidden layers of neurons
trainSet = 0.7;                   % Between 0-1           (70% Training - 140 photos)
valSet = 0.15;                    % Between 0-(1 - train) (15% Validation - 30 photos)
testSet = 1 - trainSet - valSet;  % The remaining trials  (15% Test - 30 photos)

%%% Create Neural Network with desired parameters:
net = newpr(input,target,numHiddenNeurons);
net.divideParam.trainRatio = trainSet;
net.divideParam.valRatio = valSet;
net.divideParam.testRatio = testSet;

%%% Train Network:
[net, tr] = train(net, input, target);
plotperf(tr)

%%% Save Net
save('../out/net','net')

%%% Plot results
output = sim(net, input);
plotconfusion(target,output)