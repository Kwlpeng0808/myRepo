function q = fastguidedfilter_color(I0, p0, r0, eps,s)
%   FASTGUIDEDFILTER_COLOR   O(1) time implementation of guided filter using a color image as the guidance.
%
%   - guidance image: I0 (should be a color (RGB) image)
%   - filtering input image: p0 (should be a gray-scale/single channel image)
%   - local window radius: r0
%   - regularization parameter: eps
%   - downsampling factor: s
[A,B,C] = size(I0);
[P,Q] = size(p0);
I = cat(3,zeros(round(A/s),round(B/s)),zeros(round(A/s),round(B/s)),zeros(round(A/s),round(B/s)));
for i = 1:C
    I(:,:,i) = imresize(I0(:,:,i),[round(A/s),round(B/s)]);
end
p = imresize(p0,[round(P/s),round(Q/s)]);
r = round(r0/s);

[hei, wid] = size(p);
N = boxfilter(ones(hei, wid), r); % the size of each local patch; N=(2r+1)^2 except for boundary pixels.

mean_I_r = boxfilter(I(:, :, 1), r) ./ N; % mean I
mean_I_g = boxfilter(I(:, :, 2), r) ./ N;
mean_I_b = boxfilter(I(:, :, 3), r) ./ N;

mean_p = boxfilter(p, r) ./ N; % mean p

mean_Ip_r = boxfilter(I(:, :, 1).*p, r) ./ N; % corr I p
mean_Ip_g = boxfilter(I(:, :, 2).*p, r) ./ N;
mean_Ip_b = boxfilter(I(:, :, 3).*p, r) ./ N;

% covariance of (I, p) in each local patch.
cov_Ip_r = mean_Ip_r - mean_I_r .* mean_p; % cov I p
cov_Ip_g = mean_Ip_g - mean_I_g .* mean_p;
cov_Ip_b = mean_Ip_b - mean_I_b .* mean_p;

% variance of I in each local patch: the matrix Sigma in Eqn (14).
% Note the variance in each local patch is a 3x3 symmetric matrix:
%           rr, rg, rb
%   Sigma = rg, gg, gb
%           rb, gb, bb
var_I_rr = boxfilter(I(:, :, 1).*I(:, :, 1), r) ./ N - mean_I_r .*  mean_I_r; % var I
var_I_rg = boxfilter(I(:, :, 1).*I(:, :, 2), r) ./ N - mean_I_r .*  mean_I_g; 
var_I_rb = boxfilter(I(:, :, 1).*I(:, :, 3), r) ./ N - mean_I_r .*  mean_I_b; 
var_I_gg = boxfilter(I(:, :, 2).*I(:, :, 2), r) ./ N - mean_I_g .*  mean_I_g; 
var_I_gb = boxfilter(I(:, :, 2).*I(:, :, 3), r) ./ N - mean_I_g .*  mean_I_b; 
var_I_bb = boxfilter(I(:, :, 3).*I(:, :, 3), r) ./ N - mean_I_b .*  mean_I_b; 

a = zeros(hei, wid, 3);
for y=1:hei
    for x=1:wid        
        Sigma = [var_I_rr(y, x), var_I_rg(y, x), var_I_rb(y, x);
            var_I_rg(y, x), var_I_gg(y, x), var_I_gb(y, x);
            var_I_rb(y, x), var_I_gb(y, x), var_I_bb(y, x)];
        %Sigma = Sigma + eps * eye(3);
        
        cov_Ip = [cov_Ip_r(y, x), cov_Ip_g(y, x), cov_Ip_b(y, x)];        
        
        a(y, x, :) = cov_Ip * inv(Sigma + eps * eye(3)); % Eqn. (14) in the paper;
    end
end

b = mean_p - a(:, :, 1) .* mean_I_r - a(:, :, 2) .* mean_I_g - a(:, :, 3) .* mean_I_b; % Eqn. (15) in the paper;

mean_a_r = imresize(boxfilter(a(:, :, 1), r),[A,B]);
mean_a_g = imresize(boxfilter(a(:, :, 2), r),[A,B]);
mean_a_b = imresize(boxfilter(a(:, :, 3), r),[A,B]);
mean_b = imresize(boxfilter(b, r)./ N,[A,B]);
q = (mean_a_r.* I0(:, :, 1)+ mean_a_g.* I0(:, :, 2)+ mean_a_b.* I0(:, :, 3))+mean_b;  % Eqn. (16) in the paper;
end