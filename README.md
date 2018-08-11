Single Image Haze Removal Using Dark Channel Prior
====
This project simulates a paper written by Kaiming He to implement single image haze removal. Compare with the orginal result, this project improves the dehazing performance in the atmospheric area. <br>

This project mainly contains ten .m files.<br>

1)DifferentHazeRemove.m
----
Implement single image haze removal using dark channel prior. Try many different improvements and compare the results.<br>

Example: DifferentHazeRemove('HazedIMG1.jpg')<br>
Example: DifferentHazeRemove('HazedIMG2.jpg')<br>
Example: DifferentHazeRemove('HazedIMG3.jpg')<br>

figure(1) Original Image<br>
figure(2) MATLAB Result<br>
figure(3) Dark Channel<br>
figure(4) Transmission Map<br>
figure(5) Primiary Result<br>
figure(6) Filtered Transmission Map using fast guided filter<br>
figure(7) Filtered Transmission Map using guided filter<br>
figure(8) The result after using fast guided filter<br>
figure(9) The result after using guided filter<br>
figure(10) The result after using guided filter in addition of  a parameter to improve haze removal in the sky region.<br>
figure(11) The result after using guided filter in addition of  a parameter to improve haze removal in the sky region. Auto color gradation to enhancement the saturation<br>
figure(12) The result after using guided filter in addition of  a parameter to improve haze removal in the sky region. Auto contrast to enhancement the saturation<br>

2)HazeRemove.m
----
Implement improved single image haze removal using dark channel prior.<br>

Example: HazeRemove('HazedIMG1.jpg')<br>
Example: HazeRemove('HazedIMG2.jpg')<br>
Example: HazeRemove('HazedIMG3.jpg')<br>

figure(1) Original Image<br>
figure(2) MATLAB Result<br>
figure(3) Dark Channel<br>
figure(4) Transmission Map<br>
figure(5) Filtered Transmission Map<br>
figure(6) Dehazed Image<br>

3)dcp.m
----
Calculate the dark channel prior.<br>

function DCP = dcp(IMG)<br>
Input matrix of the image: IMG<br>

figure(3) Dark Channel<br>

4)transEst.m
----
Estimate the transmission map.<br>

function [A,t,t0] = transEst(IMG,DCP)<br>
Matrix of the input image: IMG<br>
Dark channel prior: DCP<br>

figure(4) Transmission Map<br>

5)boxfilter.m
----
Time box filtering using cumulative sum.Equivalent to the function: colfilt(imSrc, [2*r+1, 2*r+1], 'sliding', @sum),But much faster.<br>

function imDst = boxfilter(imSrc, r)<br>
Input: imSrc<br>
Definition imDst(x, y)=sum(sum(imSrc(x-r:x+r,y-r:y+r)));<br>
Local window radius: r<br>

6)guidedfilter_color.m
----
Implementation of guided filter using a color image as the guidance.<br>

function q = guidedfilter_color(I, p, r, eps)<br>
Guidance image: I (should be a color (RGB) image)<br>
Filtering input image: p (should be a gray-scale/single channel image)<br>
Local window radius: r<br>
Regularization parameter: eps<br>

7)fastguidedfilter_color.m
----
Implementation of guided filter using a color image as the guidance.<br>

function q = fastguidedfilter_color(I0, p0, r0, eps,s)<br>
Guidance image: I0 (should be a color (RGB) image)<br>
Filtering input image: p0 (should be a gray-scale/single channel image)<br>
Local window radius: r0<br>
Regularization parameter: eps<br>
Downsampling factor: s<br>

8)autocontrast.m
----
Adjust the contrast automatically.<br>

function OutputIMG = autocontrast(IMG,ratio)<br>
Input matrix of the image: IMG<br>
THe ratio of adjustment: ratio<br>

9)autotune.m
----
Adjust the color tune automatically.<br>

function OutputIMG = autotune(IMG,ratio)<br>
Input matrix of the image: IMG<br>
THe ratio of adjustment: ratio<br>

10)HistEqu_color.m
----
Implement the histogram equalization to the input color images.<br>

function HistEqu_color(InputImage)<br>
Example: HistEqu_color('HazeRemovedIMG1.jpg')<br>
Example: HistEqu_color('HazeRemovedIMG2.jpg')<br>
Example: HistEqu_color('HazeRemovedIMG3.jpg')<br>

figure(1) Comparison between input histogram and output histogram in R Channel<br>
figure(2) Comparison between input histogram and output histogram in G Channel<br>
figure(3) Comparison between input histogram and output histogram in B Channel<br>
figure(4) Comparison between input image and output image<br>
