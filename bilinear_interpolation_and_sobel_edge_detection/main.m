close all; clear all; clc;

im = imread('Lenna.png');
scale = 2;

result = bilinearInterpolation(im, scale);

imwrite(result, 'result_bilinearInterpolation.png'); 


%%
close all; clear all; clc;

im = imread('Lenna_salt_pepper.png');


result = SobelEdge(im);
imwrite(result, 'result_SobelEdge.png'); 

im = medfilt2(im);

result = SobelEdge(im);
imwrite(result, 'result_SobelEdge_medianFilter.png'); 

