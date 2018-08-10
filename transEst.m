function [A,t,t0] = transEst(IMG,DCP)
% Estimate the transmission
% Matrix of the input image: IMG
% Dark channel prior: DCP
[M,N,P] = size(IMG);
% S = min([M,N])*15/511;
S = 15;
Sedge = floor(S/2);
%% Estimate the atmospheric light
Order = sort(DCP(:),'descend');
Threshold = Order(round(M*N*0.001)); %top 0.1% brightest pixels
Index = DCP(:)>=Threshold;
A = zeros(1,P); %Atomspheric Light
for i = 1:P
    Chan = IMG(:,:,i);
    Chan = Chan(:);
    A(i) = max(Chan(Index));
end
%% Estimate the transmission, OMEGA = 0.95
Omega = 0.95;
imgTend = wextend('2D','sym',IMG,Sedge); %Extend the image
t = imgTend;
R = imgTend(:,:,1); G = imgTend(:,:,2); B = imgTend(:,:,3);
for i = 1+Sedge:M+Sedge
    for j = 1+Sedge:N+Sedge
        windowR = R(i-Sedge:i+Sedge,j-Sedge:j+Sedge);
        Rmin = min(windowR(:)/A(1));
        windowG = G(i-Sedge:i+Sedge,j-Sedge:j+Sedge);
        Gmin = min(windowG(:)/A(2));
        windowB = B(i-Sedge:i+Sedge,j-Sedge:j+Sedge);
        Bmin = min(windowB(:)/A(3));
        t(i,j) = 1 - Omega * min([Rmin,Gmin,Bmin]);
    end
end
t = t(1+Sedge:M+Sedge,1+Sedge:N+Sedge);
t0 = 0.1; %Threshold
img = (t-min(t(:)))*255/(max(t(:))-min(t(:))); %Scaled
figure(4)
imshow(uint8(img))
title('Transmission')
imwrite(uint8(img),'TransmissionMap.jpg')
end