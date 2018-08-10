function HistEqu_color(InputImage)
%Implement the histogram equalization to the input color images
img = double(imread(InputImage));
[M,N,~] = size(img);
L = 256; 
n1_R = zeros(1,L);
n2_R = zeros(1,L);
n1_G = zeros(1,L);
n2_G = zeros(1,L);
n1_B = zeros(1,L);
n2_B = zeros(1,L);
s = zeros(1,L);
OutputImage1 = img(:,:,1);
OutputImage2 = img(:,:,2);
OutputImage3 = img(:,:,3);
%% R channel equalization
for k = 1:L%for each intensity of the image
    index = img(:,:,1) == k-1; 
    n1_R(k) = sum(index(:));%obtain the number of pixels
    s(k) = round((L-1)/(M*N)*sum(n1_R(1:k)));%calculation the equalization
    OutputImage1(index(:)) = s(k);%replace original value with the equalization
end
for k = 1:L%calculate the histogram of new image
    index2 = OutputImage1 == k-1;
    n2_R(k) = sum(index2(:));
end
%% G channel equalization
for k = 1:L%for each intensity of the image
    index = img(:,:,2) == k-1; 
    n1_G(k) = sum(index(:));%obtain the number of pixels
    s(k) = round((L-1)/(M*N)*sum(n1_G(1:k)));%calculation the equalization
    OutputImage2(index(:)) = s(k);%replace original value with the equalization
end
for k = 1:L%calculate the histogram of new image
    index2 = OutputImage2 == k-1;
    n2_G(k) = sum(index2(:));
end
%% B channel equalization
for k = 1:L%for each intensity of the image
    index = img(:,:,3) == k-1; 
    n1_B(k) = sum(index(:));%obtain the number of pixels
    s(k) = round((L-1)/(M*N)*sum(n1_B(1:k)));%calculation the equalization
    OutputImage3(index(:)) = s(k);%replace original value with the equalization
end
for k = 1:L%calculate the histogram of new image
    index2 = OutputImage3 == k-1;
    n2_B(k) = sum(index2(:));
end
InputHist_R = n1_R/(M*N);
OutputHist_R = n2_R/(M*N);
InputHist_G = n1_G/(M*N);
OutputHist_G = n2_G/(M*N);
InputHist_B = n1_B/(M*N);
OutputHist_B = n2_B/(M*N);
OutputImage = cat(3,OutputImage1,OutputImage2,OutputImage3)./255;
figure(1)
subplot(1,2,1)
bar(0:L-1,InputHist_R);title('InputHist_R')
xlim([0 255])
grid on
subplot(1,2,2)
bar(0:L-1,OutputHist_R);title('OutputtHist_R')
xlim([0 255])
grid on
figure(2)
subplot(1,2,1)
bar(0:L-1,InputHist_G);title('InputHist_G')
xlim([0 255])
grid on
subplot(1,2,2)
bar(0:L-1,OutputHist_G);title('OutputtHist_G')
xlim([0 255])
grid on
figure(3)
subplot(1,2,1)
bar(0:L-1,InputHist_B);title('InputHist_B')
xlim([0 255])
grid on
subplot(1,2,2)
bar(0:L-1,OutputHist_B);title('OutputtHist_B')
xlim([0 255])
grid on
figure(4)
subplot(1,2,1)
imshow(InputImage);title('OriginalImage')
subplot(1,2,2)
imshow(OutputImage);title('HistEquImage')
imwrite(OutputImage,'HistEquIMG.jpg')
end