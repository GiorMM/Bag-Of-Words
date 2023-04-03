clear all; close all; clc;
IMG_DIR = '../images/';

%read and show the test image
test_img = imread('../test/test.jpg');
subplot(2,4,1);
imshow(test_img);
title('Input searching image');


load('st.mat');
%Read in the features of each image 
%and perform histogram
hist = [];
for i = 0:1:999
	[sift,para] = ReadSiftFeature([IMG_DIR FileName(i)]);%Read in feature
    t = Measure(st,h_k,sift);
    hist = [hist;t];
end
%L1 normalize
s = sum(abs(hist),2);
L1hist = hist./s;


[sift,para] = ReadSiftFeature('../test/test.jpg.dsift');
t = Measure(st,h_k,sift);
t = t./sum(abs(t));

L1err = sum(abs(L1hist-t),2);
[result,tag] = sort(L1err);

%show top 4 similar images
j = 5;
for i = 1:1:4
    k = tag(i);
    img = imread([IMG_DIR ImageName(k-1)]);
    subplot(2,4,j);
    imshow(img);
    j = j+1;
    title(['Retrieve result',num2str(j-5)]);
end

