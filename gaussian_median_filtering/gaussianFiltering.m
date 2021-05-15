function out = gaussianFiltering(im,sigma)
weight = gaussFilterWeight(sigma);
out = convolve(im,weight);
end

function out = convolve(in,weight)
out = zeros(size(in));
[filH,filW] = size(weight);
halfH = floor(filH/2);
halfW = floor(filW/2);
for ch = 1:size(in,3)
    for y = 1:size(in,1)
        for x = 1:size(in,2)
            for s= -halfH : halfH
                for t = -halfW : halfW
                    ys = y-s;
                    xt = x-t;
                    % replicate the pixel to the nearest pixel if it's over the image size.
                    if ys < 1; ys =1; end
                    if xt < 1; xt =1; end
                    if ys>size(in,1); ys = size(in,1);end
                    if xt>size(in,2); xt = size(in,2);end
                    out(y,x ,ch) = out(y,x,ch)+weight(s+halfH+1,t+halfW+1)* in(ys,xt,ch);                    
                end
            end
        end
    end
end
end


function weight = gaussFilterWeight(sigma)

filterSize = 2*ceil(2*sigma)+1;
halfFs = floor(filterSize/2);

weight= zeros(filterSize,filterSize);

for y = -halfFs:halfFs
    for x = -halfFs : halfFs
        weight(y+halfFs+1,x+halfFs+1) = 1/(2*pi*sigma^2) * exp(-(y^2+x^2)/(2*sigma^2));
    end
end
weight = weight / sum(weight, 'all');
end
