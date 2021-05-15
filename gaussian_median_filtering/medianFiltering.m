function out = medianFiltering(im,filterSize)
out = zeros(size(im));
filH = filterSize(1,1);
filW = filterSize(1,2);

halfH = floor(filH/2);
halfW = floor(filW/2);
for ch = 1:size(im,3)
    for y = 1:size(im,1)
        for x = 1:size(im,2)
            startY = y -halfH;
            endY = y +halfH;
            startX = x - halfW;
            endX = x+ halfW;
            if startY < 1; startY =1; end
            if startX < 1; startX =1; end
            if endY>size(im,1); endY = size(im,1);end
            if endX>size(im,2); endX = size(im,2);end
            
            filter = im(startY:endY,startX:endX);
            medianFilter=median(filter,'all');
            
            out(y, x ,ch) = medianFilter;
            
        end
    end
end

end

