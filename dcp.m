function DCP = dcp(IMG)
% Calculate the dark channel prior
% Input matrix of the image: IMG
[M,N,~] = size(IMG);
S = 15;
Sedge = floor(S/2);
IMG2 = zeros(M,N);
for i = 1:M
    for j = 1:N
        IMG2(i,j) = min(IMG(i,j,:));
    end
end
imgTend = wextend('2D','sym',IMG2,Sedge); %Extend the image
DCP = imgTend;
for i = 1+Sedge:M+Sedge
    for j = 1+Sedge:N+Sedge
        window = imgTend(i-Sedge:i+Sedge,j-Sedge:j+Sedge);
        DCP(i,j) = min(window(:)); %Minimum filter
    end
end
DCP = DCP(1+Sedge:M+Sedge,1+Sedge:N+Sedge);
img = (DCP-min(DCP(:)))*255/(max(DCP(:))-min(DCP(:))); %Scaled
figure(3)
imshow(uint8(img))
title('Dark Channel')
imwrite(uint8(img),'DarkChannel.jpg')
end