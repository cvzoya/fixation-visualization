% Zoya Bylinskii (January 2016)
% based on code by Phillip Isola (2015)
% https://github.com/cvzoya/fixation-visualization

% Visualization to create a spotlight on top of an image to highlight parts
% of the image fixated by a group of observers. Here, most visible on the
% image are the areas with a highest density of fixations, with the rest of
% the image darker. This is in contrast to standard visualizations of
% fixations where a heatmap is overlayed on top of an image, obscuring the
% image content underneath. 

function [output] = plotSpotlight(im,h,n_levels)
% im is an image
% h is a heatmap
% n_levels specifies the discretization for the resulting visualization
% output is the resulting visualization

    a_ = imresize(h,size(im(:,:,1)));
    a_ = mat2gray(a_);
    a = zeros(size(a_));
    %%
    %which_prctiles = fliplr(95:-10:(95-n_levels*10));
    which_prctiles = fliplr(100:-5:(95-n_levels*5));
    for i=1:n_levels-1
        a = a+single(a_>prctile(a_(:),which_prctiles(i)));
    end
    %%
    a = max(1.5*mat2gray(a),0.35);
    output = repmat(a,[1 1 3]).*single(im)/255;
    imshow(output);
end