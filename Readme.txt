#This project contains ten .m files.

##1. DifferentHazeRemove.m
###Implement single image haze removal using dark channel prior. Try many different improvements and compare the results.
###
Example: DifferentHazeRemove('HazedIMG1.jpg')
Example: DifferentHazeRemove('HazedIMG2.jpg')
Example: DifferentHazeRemove('HazedIMG3.jpg')
###
figure(1) Original Image
figure(2) MATLAB Result
figure(3) Dark Channel
figure(4) Transmission Map
figure(5) Primiary Result
figure(6) Filtered Transmission Map using fast guided filter
figure(7) Filtered Transmission Map using guided filter
figure(8) The result after using fast guided filter
figure(9) The result after using guided filter
figure(10) The result after using guided filter in addition of  a parameter to improve haze removal in the sky region.
figure(11) The result after using guided filter in addition of  a parameter to improve haze removal in the sky region. Auto color gradation to enhancement the saturation
figure(12) The result after using guided filter in addition of  a parameter to improve haze removal in the sky region. Auto contrast to enhancement the saturation

##2. HazeRemove.m
###Implement improved single image haze removal using dark channel prior.
###
Example: HazeRemove('HazedIMG1.jpg')
Example: HazeRemove('HazedIMG2.jpg')
Example: HazeRemove('HazedIMG3.jpg')
###
figure(1) Original Image
figure(2) MATLAB Result
figure(3) Dark Channel
figure(4) Transmission Map
figure(5) Filtered Transmission Map
figure(6) Dehazed Image

##3. dcp.m
###Calculate the dark channel prior.
###
function DCP = dcp(IMG)
Input matrix of the image: IMG
###
figure(3) Dark Channel

##4. transEst.m
###Estimate the transmission map.
###
function [A,t,t0] = transEst(IMG,DCP)
Matrix of the input image: IMG
Dark channel prior: DCP
###
figure(4) Transmission Map

##5. boxfilter.m
###Time box filtering using cumulative sum.Equivalent to the function: colfilt(imSrc, [2*r+1, 2*r+1], 'sliding', @sum),But much faster.
###
function imDst = boxfilter(imSrc, r)
Input: imSrc
Definition imDst(x, y)=sum(sum(imSrc(x-r:x+r,y-r:y+r)));
Local window radius: r

##6. guidedfilter_color.m
###Implementation of guided filter using a color image as the guidance.
###
function q = guidedfilter_color(I, p, r, eps)
Guidance image: I (should be a color (RGB) image)
Filtering input image: p (should be a gray-scale/single channel image)
Local window radius: r
Regularization parameter: eps

##7. fastguidedfilter_color.m
###Implementation of guided filter using a color image as the guidance.
function q = fastguidedfilter_color(I0, p0, r0, eps,s)
Guidance image: I0 (should be a color (RGB) image)
Filtering input image: p0 (should be a gray-scale/single channel image)
Local window radius: r0
Regularization parameter: eps
Downsampling factor: s

##8. autocontrast.m
###Adjust the contrast automatically.
###
function OutputIMG = autocontrast(IMG,ratio)
Input matrix of the image: IMG
THe ratio of adjustment: ratio

##9. autotune.m
###Adjust the color tune automatically.
###
function OutputIMG = autotune(IMG,ratio)
Input matrix of the image: IMG
THe ratio of adjustment: ratio

##10. HistEqu_color.m
###Implement the histogram equalization to the input color images.
###
function HistEqu_color(InputImage)
Example: HistEqu_color('HazeRemovedIMG1.jpg')
Example: HistEqu_color('HazeRemovedIMG2.jpg')
Example: HistEqu_color('HazeRemovedIMG3.jpg')
###
figure(1) Comparison between input histogram and output histogram in R Channel
figure(2) Comparison between input histogram and output histogram in G Channel
figure(3) Comparison between input histogram and output histogram in B Channel
figure(4) Comparison between input image and output image