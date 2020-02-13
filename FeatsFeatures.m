category ={'stem_rust','leaf_rust','healthy_wheat'};
imds = imageDatastore(fullfile(category),'IncludeSubfolders',true,'LabelSource','foldernames');

%%
coloredimage = readimage(imds,55);
gray =  rgb2gray(coloredimage); 
BW = imbinarize(gray);  
%%
for i=1:numel(imds.Files)
coloredimage = readimage(imds,35);
gray =  rgb2gray(coloredimage); 
BW = imbinarize(gray); 



end
[B,L,N,A] = bwboundaries(BW); 
figure; imshow(coloredimage); hold on; 
% Loop through object boundaries  
for k = 1:N 
    % Boundary k is the parent of a hole if the k-th column 
    % of the adjacency matrix A contains a non-zero element 
    if (nnz(A(:,k)) > 10) 
        boundary = B{k}; 
        plot(boundary(:,2),... 
            boundary(:,1),'r','LineWidth',2); 
        % Loop through the children of boundary k 
        for l = find(A(:,k)) 
            boundary = B{l}; 
           plot(boundary(:,2),... 
               boundary(:,1),'g','LineWidth',2); 
        end 
    end 
end

%%


% Loop through object boundaries  


%%
lab_he = rgblab(gray);
ab = lab_he(:,:,2:3);
ab = im2single(ab);
nColors = 3;
% repeat the clustering 3 times to avoid local minima
pixel_labels = imsegkmeans(ab,nColors,'NumAttempts',3);

imshow(pixel_labels,[])
title('Image Labeled by Cluster Index');
