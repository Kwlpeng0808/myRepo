function DifferentHazeRemove(InputImage)
%Implement single image haze removal using dark channel prior
%Try many different improvement and compare the result
%Example: DifferentHazeRemove('HazedIMG1.jpg')
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
%% Implement haze removal without the guided filter
R = IMG(:,:,1); G = IMG(:,:,2); B = IMG(:,:,3);
RemovedR = R; RemovedG = G; RemovedB = B;
% for i = 1:M
%     for j = 1:N
%         RemovedR(i,j) = A(1)+(R(i,j)-A(1))/min(max(K/abs(R(i,j)-A(1)),1)*max([t(i,j),t0]),1);
%         RemovedG(i,j) = A(2)+(G(i,j)-A(2))/min(max(K/abs(G(i,j)-A(2)),1)*max([t(i,j),t0]),1);
%         RemovedB(i,j) = A(3)+(B(i,j)-A(3))/min(max(K/abs(B(i,j)-A(3)),1)*max([t(i,j),t0]),1);
%     end
% end
for i = 1:M
    for j = 1:N
        RemovedR(i,j) = A(1)+(R(i,j)-A(1))/max([t(i,j),t0]);
        RemovedG(i,j) = A(2)+(G(i,j)-A(2))/max([t(i,j),t0]);
        RemovedB(i,j) = A(3)+(B(i,j)-A(3))/max([t(i,j),t0]);
    end
end
RemovedR = (RemovedR-min(RemovedR(:)))*255/(max(RemovedR(:))-min(RemovedR(:))); %Scaled
RemovedG = (RemovedG-min(RemovedG(:)))*255/(max(RemovedG(:))-min(RemovedG(:))); %Scaled
RemovedB = (RemovedB-min(RemovedB(:)))*255/(max(RemovedB(:))-min(RemovedB(:))); %Scaled
NewIMG = cat(3,RemovedR,RemovedG,RemovedB);
figure(5)
imshow(uint8(NewIMG))
title('Image With  Haze Removal(No guided filter)')
imwrite(uint8(NewIMG),'PrimaryResult.jpg')
%% Implement the guided filter or the fastguided filter
r = 80;
eps = 10^-6;
t1 = fastguidedfilter_color(IMG, t, r, eps,6); % Fast Guided Filter
T1 = (t1-min(t1(:)))*255/(max(t1(:))-min(t1(:))); %Scaled
figure(6)
imshow(uint8(T1))
title('Fast Filtered Transmission')
imwrite(uint8(T1),'FilteredTransmission(fast).jpg')
t = guidedfilter_color(IMG, t, r, eps);
T = (t-min(t(:)))*255/(max(t(:))-min(t(:))); %Scaled
figure(7)
imshow(uint8(T))
title('Filtered Transmission')
imwrite(uint8(T),'FilteredTransmission.jpg')
%% Implement haze removal with fast guided fiter
R = IMG(:,:,1); G = IMG(:,:,2); B = IMG(:,:,3);
RemovedR = R; RemovedG = G; RemovedB = B;
% for i = 1:M
%     for j = 1:N
%         RemovedR(i,j) = A(1)+(R(i,j)-A(1))/min(max(K/abs(R(i,j)-A(1)),1)*max([t1(i,j),t0]),1);
%         RemovedG(i,j) = A(2)+(G(i,j)-A(2))/min(max(K/abs(G(i,j)-A(2)),1)*max([t1(i,j),t0]),1);
%         RemovedB(i,j) = A(3)+(B(i,j)-A(3))/min(max(K/abs(B(i,j)-A(3)),1)*max([t1(i,j),t0]),1);
%     end
% end
for i = 1:M
    for j = 1:N
        RemovedR(i,j) = A(1)+(R(i,j)-A(1))/max([t1(i,j),t0]);
        RemovedG(i,j) = A(2)+(G(i,j)-A(2))/max([t1(i,j),t0]);
        RemovedB(i,j) = A(3)+(B(i,j)-A(3))/max([t1(i,j),t0]);
    end
end
RemovedR = (RemovedR-min(RemovedR(:)))*255/(max(RemovedR(:))-min(RemovedR(:))); %Scaled
RemovedG = (RemovedG-min(RemovedG(:)))*255/(max(RemovedG(:))-min(RemovedG(:))); %Scaled
RemovedB = (RemovedB-min(RemovedB(:)))*255/(max(RemovedB(:))-min(RemovedB(:))); %Scaled
NewIMG1 = cat(3,RemovedR,RemovedG,RemovedB);
figure(8)
imshow(uint8(NewIMG1))
title('Image With Project Haze Removal(Fast Guided Filter)')
imwrite(uint8(NewIMG1),'FastGuidedfiltered.jpg')
%% Implement haze removal with guided filter
R = IMG(:,:,1); G = IMG(:,:,2); B = IMG(:,:,3);
RemovedR = R; RemovedG = G; RemovedB = B;
for i = 1:M
    for j = 1:N
        RemovedR(i,j) = A(1)+(R(i,j)-A(1))/max([t(i,j),t0]);
        RemovedG(i,j) = A(2)+(G(i,j)-A(2))/max([t(i,j),t0]);
        RemovedB(i,j) = A(3)+(B(i,j)-A(3))/max([t(i,j),t0]);
    end
end
RemovedR = (RemovedR-min(RemovedR(:)))*255/(max(RemovedR(:))-min(RemovedR(:))); %Scaled
RemovedG = (RemovedG-min(RemovedG(:)))*255/(max(RemovedG(:))-min(RemovedG(:))); %Scaled
RemovedB = (RemovedB-min(RemovedB(:)))*255/(max(RemovedB(:))-min(RemovedB(:))); %Scaled
NewIMG2 = cat(3,RemovedR,RemovedG,RemovedB);
figure(9)
imshow(uint8(NewIMG2))
title('Image With Project Haze Removal(Guided Filter)')
imwrite(uint8(NewIMG2),'Guidedfiltered.jpg')
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
% for i = 1:M
%     for j = 1:N
%         RemovedR(i,j) = A(1)+(R(i,j)-A(1))/max([t(i,j),t0]);
%         RemovedG(i,j) = A(2)+(G(i,j)-A(2))/max([t(i,j),t0]);
%         RemovedB(i,j) = A(3)+(B(i,j)-A(3))/max([t(i,j),t0]);
%     end
% end
RemovedR = (RemovedR-min(RemovedR(:)))*255/(max(RemovedR(:))-min(RemovedR(:))); %Scaled
RemovedG = (RemovedG-min(RemovedG(:)))*255/(max(RemovedG(:))-min(RemovedG(:))); %Scaled
RemovedB = (RemovedB-min(RemovedB(:)))*255/(max(RemovedB(:))-min(RemovedB(:))); %Scaled
NewIMG3 = cat(3,RemovedR,RemovedG,RemovedB);
figure(10)
imshow(uint8(NewIMG3))
title('Image With Project Haze Removal(Guided Filter and para)')
imwrite(uint8(NewIMG3),'Guidedfiltered(para).jpg')
%% Implement haze removal with enhancement and guided filter
AdjustedIMG = autotune(NewIMG3,0.001);
figure(11)
imshow(uint8(AdjustedIMG))
title('Project Haze Removal(Guided Filter and Autotune)')
imwrite(uint8(AdjustedIMG),'HazeRemovedIMG(Autotune).jpg')
AdjustedIMG = autocontrast(NewIMG3,0.001);
figure(12)
imshow(uint8(AdjustedIMG))
title('Project Haze Removal(Guided Filter and Autocontrast)')
imwrite(uint8(AdjustedIMG),'FinalHazeRemovedIMG(Autocontrast).jpg')
end