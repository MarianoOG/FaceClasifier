%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                                                                     %%%
%%%                          FACE RECOGNITION                           %%%
%%%                                                                     %%%
%%% createFeatureDatabase.m: using featureExtraction.m iteratively,     %%%
%%%                          creates the database of features from all  %%%
%%%                          the phots of the subjects in the           %%%
%%%                          data base.                                 %%%
%%%                                                                     %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Extract Features from the photos of the first two subjects
for i = 0:1 % For every subject
    
    %%% Initialize Feature matrix
    F = zeros(200,10*10); % 200 photos, 10*10 features
    
    for j = 1:200 % For all the photos of each subject
        
        %%% Read the input image
        I = imread(['..\img\Subject', num2str(i), '\', num2str(j), '.jpg']);
        
        %%% Calculate Features
        F(j,:) = featureExtraction(I, false);
        
        %%% Display progres every 25 photos
        if sum(j == 0:25:200)
            disp(['Subject: ', num2str(i), ', progress: ', ...
                num2str(j/2), '%'])
        end
        
    end
    
    % Save featureDatabase for each subject
    save(['..\data\Subject', num2str(i)],'F')
    
end
