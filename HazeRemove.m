function HazeRemove(InputImage)
%Implement single image haze removal using dark channel prior
%Example: HazeRemove('HazedIMG.jpg')
figure(1)
imshow(InputImage)
IMG = double(imread(InputImage));
title('Original Image')
K = 50;
[M,N,~] = size(IMG);
IMG1 = imreducehaze(imread(InputImage));
imwrite(uint8(IMG1),'MATLABIMG.jpg')
figure(2)
imshow(IMG1)
title('Image With Matlab Haze Removal')
DCP = dcp(IMG); % Calculate the dark channel prior
[A,t,t0] = transEst(IMG,DCP); % Estimate the transmission and the atmospheric light
%% Implement the guided filter
r = 80;
eps = 10^-6;
t = guidedfilter_color(IMG, t, r, eps);
T = (t-min(t(:)))*255/(max(t(:))-min(t(:))); %Scaled
figure(5)
imshow(uint8(T))
title('Filtered Transmission')
imwrite(uint8(T),'FilteredTransmission.jpg')
%% Implement haze removal with guided filter
R = IMG(:,:,1); G = IMG(:,:,2); B = IMG(:,:,3);
RemovedR = R; RemovedG = G; RemovedB = B;
for i = 1:M
    for j = 1:N
        RemovedR(i,j) = A(1)+(R(i,j)-A(1))/min(max(K/abs(R(i,j)-A(1)),1)*max([t(i,j),t0]),1);
        RemovedG(i,j) = A(2)+(G(i,j)-A(2))/min(max(K/abs(G(i,j)-A(2)),1)*max([t(i,j),t0]),1);
        RemovedB(i,j) = A(3)+(B(i,j)-A(3))/min(max(K/abs(B(i,j)-A(3)),1)*max([t(i,j),t0]),1);
    end
end
RemovedR = (RemovedR-min(RemovedR(:)))*255/(max(RemovedR(:))-min(RemovedR(:))); %Scaled
RemovedG = (RemovedG-min(RemovedG(:)))*255/(max(RemovedG(:))-min(RemovedG(:))); %Scaled
RemovedB = (RemovedB-min(RemovedB(:)))*255/(max(RemovedB(:))-min(RemovedB(:))); %Scaled
NewIMG3 = cat(3,RemovedR,RemovedG,RemovedB);
%% Implement haze removal with enhancement
AdjustedIMG = autocontrast(NewIMG3,0.001);
figure(6)
imshow(uint8(AdjustedIMG))
title('Project Haze Removal(Guided Filter and Autocontrast)')
imwrite(uint8(AdjustedIMG),'HazeRemovedIMG.jpg')
end
