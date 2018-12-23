%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                                                                     %%%
%%%                          FACE RECOGNITION                           %%%
%%%                                                                     %%%
%%% featureExtraction.m: extracts the corner points, using minimum      %%%
%%%                      eigenvalue algorithm, of the mouth nose and    %%%
%%%                      eyes found in the original image.              %%%
%%%                                                                     %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [F] = featureExtraction(I, show)

    %%% Get image size
    [a,b] = size(I);

    %%% Eyes, Nose and Mouth detection
    [eyes, boxe] = extractObject(I, 'EyePairSmall');
    [nose, boxn] = extractObject(I, 'Nose');
    [mouth, boxm] = extractObject(I, 'Mouth');
    
    %%%  Initialize new image for the corresponding features
    F = zeros(size(I));
    
    if ~isempty(eyes)
        %%% Detect features
        e = detectMinEigenFeatures(eyes);
        %%% Transform Locations to original image
        le = zeros(e.Count,2);
        for i = 1:e.Count
            le(i,:) = round(e.Location(i,:) + boxe(2:-1:1));
            F(min(a,le(i,1)),min(b,le(i,2))) = e.Metric(i); % Record features in matrix
        end 
    end
    
    if ~isempty(nose)
        %%% Detect features
        n = detectMinEigenFeatures(nose);
        %%% Transform Locations to original image
        ln = zeros(n.Count,2);
        for i = 1:n.Count
            ln(i,:) = round(n.Location(i,:) + boxn(2:-1:1));
            F(min(a,ln(i,1)),min(b,ln(i,2))) = n.Metric(i);  % Record features in matrix
        end
    end
    
    if ~isempty(mouth)
        %%% Detect features
        m = detectMinEigenFeatures(mouth);
        %%% Transform Locations to original image
        lm = zeros(m.Count,2);
        for i = 1:m.Count
            lm(i,:) = round(m.Location(i,:) + boxm(2:-1:1));
            F(min(a,lm(i,1)),min(b,lm(i,2))) = m.Metric(i);
        end
        
    end

    %%% Make smaller feature matrix
    F = imresize(F,[10,10]);
    F = F(:);
    F = F/max(F);

    %%% Show result in figure
    if show
        figure
        subplot(1,3,1)
            imshow(I),
        subplot(3,3,2)
            imshow(eyes)
            hold on
            plot(e.Location(:,2),e.Location(:,1),'rd')
            title('Eyes')
        subplot(3,3,5)
            imshow(nose)
            hold on
            plot(n.Location(:,2),n.Location(:,1),'bd')
            title('Nose')
        subplot(3,3,8)
            imshow(mouth)
            hold on
            plot(m.Location(:,2),m.Location(:,1),'gd')
            title('Mouth')
        subplot(1,3,3)
            imshow(I),
            hold on
            plot(le(:,2),le(:,1),'rd')
            plot(ln(:,2),ln(:,1),'bd')
            plot(lm(:,2),lm(:,1),'gd')
    end
    
end