clear all; close all; clc;

%path of image folder
img = '../images/'

%construct the vision code with 200000 features(may less than this)
code = ConstructVisionCode(img, 200000);

%save the code
save('code.mat', 'code');

%load code
load('code.mat')


%Set the number of categories for each layer of kmeans 
%results will be less than or equal to the concatenated multiplication of h_k
h_k = [20 19 18];

tic;
%Hierarchical k-means clustering
st = BoWHKmeans(code, h_k);

['Total time spent on BoWHKmeans： ', num2str(toc), 's']

%Read in the features of each image 
%and perform histogram
hist = [];
for i = 0:1:999
	[sift,para] = ReadSiftFeature([img FileName(i)]);%Read in feature
    t = Measure(st,h_k,sift);
    hist = [hist;t];
end

%L1 normalize
s = sum(abs(hist),2);
L1hist = hist./s;
%L2 normalize
s = sqrt(sum((hist.^2),2));
L2hist= hist./s;

%%Different distance measure result
L1result = []; %L1 distance
L2result = []; %L2 distance
for i = 1:1:1000
    t1 = L1hist(i,:);
    t2 = L2hist(i,:);
    
    %error under two distance measure
    L1err = sum(abs(L1hist-t1),2);
    L2err = sum((L2hist-t2).^2,2);
    
    %Sort the error results in ascending order
    %Result is the sorting result
    %tag is the serial number corresponding to the sorting result
    [result,tag] = sort(L1err);
    L1result = [L1result;(tag(1:4))'];%Top 4
    [result,tag] = sort(L2err);
    L2result = [L2result;(tag(1:4))'];%Top 4
end

%Number of false detections at two distances
L1wrong = 0;
L2wrong = 0;
for i = 1:4:1000
    r1 = L1result(i:i+3,:);
    r2 = L2result(i:i+3,:);
    
    L1wrong = L1wrong+size(find(r1<i),1)+size(find(r1>i+3),1);
    L2wrong = L2wrong+size(find(r2<i),1)+size(find(r2>i+3),1);
end

['Accuracy under L1 distance measure:', num2str((4000-L1wrong)/40), '%']
['Accuracy under L2 distance measure:', num2str((4000-L2wrong)/40), '%']

%save the BoWHKmeans struct
save('st.mat', 'st', 'h_k');