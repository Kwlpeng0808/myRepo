function LapEnhance(InputImage)
%Using Laplace operator to implement the image shapening to the input images
%Example: LapEnhance('HazeRemovedIMG1.jpg')
img = double(imread(InputImage));
[M,N,~] = size(img);
% L=256;
imgTend = wextend('2D','sym',img,1);% extend the image
% imgTend = wextend('2','zpd',img,1);% extend the image
%% R channel
imgTendR = imgTend(:,:,1);
imgTend1_R = imgTendR;
% imgTend2_R = imgTendR;
for i = 2:M+1
    for j = 2:N+1
%         s0 = imgTendR(i-1:i+1,j-1:j+1);%configure neighborhood pixels
        imgTend1_R(i,j) = imgTendR(i,j)-(imgTendR(i+1,j)+imgTendR(i-1,j)+imgTendR(i,j+1)+imgTendR(i,j-1)...
            -4*imgTendR(i,j));
%         imgTend2_R(i,j) = imgTendR(i,j)-(sum(s0(:))-9*imgTendR(i,j));
    end
end
%restore the extended image
imgTend1_R = imgTend1_R(2:M+1,2:N+1);
% imgTend2_R = imgTend2_R(2:M+1,2:N+1);
%% G channel
imgTendG = imgTend(:,:,2);
imgTend1_G = imgTendG;
% imgTend2_G = imgTendG;
for i = 2:M+1
    for j = 2:N+1
%         s0 = imgTendG(i-1:i+1,j-1:j+1);%configure neighborhood pixels
        imgTend1_G(i,j) = imgTendG(i,j)-(imgTendG(i+1,j)+imgTendG(i-1,j)+imgTendG(i,j+1)+imgTendG(i,j-1)...
            -4*imgTendG(i,j));
%         imgTend2_G(i,j) = imgTendG(i,j)-(sum(s0(:))-9*imgTendG(i,j));
    end
end
%restore the extended image
imgTend1_G = imgTend1_G(2:M+1,2:N+1);
% imgTend2_G = imgTend2_G(2:M+1,2:N+1);
%% B channel
imgTendB = imgTend(:,:,3);
imgTend1_B = imgTendB;
% imgTend2_B = imgTendB;
for i = 2:M+1
    for j = 2:N+1
%         s0 = imgTendB(i-1:i+1,j-1:j+1);%configure neighborhood pixels
        imgTend1_B(i,j) = imgTendB(i,j)-(imgTendB(i+1,j)+imgTendB(i-1,j)+imgTendB(i,j+1)+imgTendB(i,j-1)...
            -4*imgTendB(i,j));
%         imgTend2_B(i,j) = imgTendB(i,j)-(sum(s0(:))-9*imgTendB(i,j));
    end
end
%restore the extended image
imgTend1_B = imgTend1_B(2:M+1,2:N+1);
% imgTend2_B = imgTend2_B(2:M+1,2:N+1);
%% Implement the enhancement
imgTend1 = cat(3,imgTend1_R,imgTend1_G,imgTend1_B);
% imgTend2 = cat(3,imgTend2_R,imgTend2_G,imgTend2_B);
figure(1);
imshow(InputImage);title('InputImage')
figure(2)
imshow(uint8(imgTend1));title('OutputImage1')
imwrite(uint8(imgTend1),'Laplacesharpening.jpg')
% figure
% imshow(uint8(imgTend2));title('OutputImage2')
end