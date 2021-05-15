function result = histEq(im, level)
[H,W] = size(im);
hist = zeros(level,1);

%% Make histogram
for h = 1:H
    for w= 1:W
        if im(h,w)+1<=level
            hist(im(h,w)+1) = hist(im(h,w)+1)+1;
        end
    end
end
prob = hist / (H*W);

% make CDF
cum_prob = zeros(level,1);
cum_prob(1) = prob(1);

for k=2:level
    cum_prob(k)= cum_prob(k-1) + prob(k);
end

target = (level-1)*cum_prob;
target_round = round(target);
im_eq = zeros(size(im),'uint8');

for h =1:H
    for w =1:W
        if im(h,w)<=level
            im_eq(h,w) =target_round(im(h,w));
        end
    end
end
result = im_eq;
end
