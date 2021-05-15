function [out] = bilinearInterpolation(im, scale)

out_rows = size(im,1)*scale;
out_cols = size(im,2)*scale;
out = zeros(out_rows,out_cols,3);

% Upscaling the image 
for d = 1:size(im,3)
    for r = 1:size(im,1)
        for c = 1:size(im,2)
            out((r-1)*scale+1,(c-1)*scale+1,d)=im(r,c,d);
        end
    end
end

for d = 1:size(out,3)
    for r = 1:size(out,1)
        for c = 1:size(out,2)
            
            % Skip the position which has the origin pixel value
            if mod(r,scale) == 1 && mod(c,scale) ==1
                continue;
            end
            % Skip if it is the edge
            if c+scale-1 > size(out,2) || r+scale-1 > size(out,1)
                continue;
            end
            % Find a start point
            if c>scale
                diff_col_from_start = mod(c-1,scale);
                start_col = c-diff_col_from_start;
            else
                diff_col_from_start = c - 1;
                start_col = 1;
            end
            % Find an end point
            end_col = start_col+scale;
            diff_col_from_end= end_col -c;
            
            if r>scale
                diff_row_from_start = mod(r-1,scale);
                start_row = r-diff_row_from_start;
            else
                diff_row_from_start= r - 1;
                start_row = 1;
            end
            end_row = start_row+scale;
            diff_row_from_end= end_row -r;
            
            
            
            % The column which has the origin pixel value.
            if mod(r,scale) == 1 && mod(c,scale) ~=1
                out(r,c,d) = ceil(out(r,start_col,d)*diff_col_from_end/scale +  out(r,end_col,d)*diff_col_from_start/scale);
            % The row which has the origin pixel value
            elseif mod(r,scale) ~= 1 && mod(c,scale) ==1
                out(r,c,d) = ceil(out(start_row,c,d)*diff_row_from_end/scale +  out(end_row,c,d)*diff_row_from_start/scale);
            end
        end
    end
    for r = 1:size(out,1)
        for c = 1:size(out,2)
            
            end_col = c+scale;
            end_row = r+scale;
            % Skip if it is NOT the edge
            if end_col-1 <= size(out,2) && end_row-1 <= size(out,1)
                continue;
            end
            
            % Fill the edge with the nearest neighbor pixel value
            if end_col-1 > size(out,2) && end_row-1 > size(out,1)
                out(r,c,d) = out(r-1,c-1,d);
            elseif end_col-1 > size(out,2)
                out(r,c,d) = out(r,c-1,d);
            elseif end_row-1 > size(out,1)
                out(r,c,d) = out(r-1,c,d);
            end
        end
    end
    
    for r = 1:size(out,1)
        for c = 1:size(out,2)
            
            % Skip if it's the position which has the origin pixel value
            if mod(r,scale) == 1 && mod(c,scale) ==1
                continue;
            end
            % Skip if it is the edge
            if c+scale-1 > size(out,2) || r+scale-1 > size(out,1)
                continue;
            end
            
            if c>scale
                diff_col_from_start = mod(c-1,scale);
                start_col = c-diff_col_from_start;
            else
                diff_col_from_start = c - 1;
                start_col = 1;
            end
            end_col = start_col+scale;
            diff_col_from_end= end_col - c;
            
            
            % Fill the empty space.
            if mod(r,scale) ~= 1 && mod(c,scale) ~=1
                out(r,c,d) = ceil(out(r,start_col,d)*diff_col_from_end/scale +  out(r,end_col,d)*diff_col_from_start/scale);
                continue;
            end
            
        end
    end
end

out =uint8(out);
end
