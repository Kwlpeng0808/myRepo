function OutputIMG = autocontrast(IMG,ratio)
% Adjust the color tune automatically
% Input matrix of the image: IMG
% THe ratio of adjustment: ratio
[M,N,~] = size(IMG);
R0 = IMG(:,:,1);
G0 = IMG(:,:,2);
B0 = IMG(:,:,3);
R = IMG(:,:,1);
G = IMG(:,:,2);
B = IMG(:,:,3);
orderR = sort(R0(:));
orderG = sort(G0(:));
orderB = sort(B0(:));
minR = orderR(floor(M*N*ratio));
minG = orderG(floor(M*N*ratio));
minB = orderB(floor(M*N*ratio));
maxR = orderR(floor(M*N*(1-ratio)));
maxG = orderG(floor(M*N*(1-ratio)));
maxB = orderB(floor(M*N*(1-ratio)));
MIN = min([minR,minG,minB]);
MAX = max([maxR,maxG,maxB]);
for i = 1:M
    for j = 1:N
        if R0(i,j)<MIN
            R(i,j) = 0;
        elseif R0(i,j)>MAX
            R(i,j) = 255;
        else
            R(i,j) = (R0(i,j)-MIN)/(MAX-MIN)*255;
        end
        if G0(i,j)<MIN
            G(i,j) = 0;
        elseif G0(i,j)>MAX
            G(i,j) = 255;
        else
            G(i,j) = (G0(i,j)-MIN)/(MAX-MIN)*255;
        end
        if B0(i,j)<MIN
            B(i,j) = 0;
        elseif B0(i,j)>MAX
            B(i,j) = 255;
        else
            B(i,j) = (B0(i,j)-MIN)/(MAX-MIN)*255;
        end
    end
end
OutputIMG = cat(3,R,G,B);
end