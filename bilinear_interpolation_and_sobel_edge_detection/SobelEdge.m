function [result] = SobelEdge(im)
result = zeros(size(im,1),size(im,2));
for i=1:size(im,1)-2
    for j=1:size(im,2)-2
        % Sobel mask for the X direction:
        Gx=((2*im(i+2,j+1)+im(i+2,j)+im(i+2,j+2))-(2*im(i,j+1)+im(i,j)+im(i,j+2)));
        % Sobel mask for the Y direction:
        Gy=((2*im(i+1,j+2)+im(i,j+2)+im(i+2,j+2))-(2*im(i+1,j)+im(i,j)+im(i+2,j)));
        
        % edge magnitude
        %B(i,j)=abs(Gx)+abs(Gy);
        result(i,j)=sqrt(double(Gx.^2+Gy.^2));
    end
end
end

