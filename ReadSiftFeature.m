function [ SiftFeat_1, paraFeat_1] = ReadSiftFeature(featPath_1)
fid_1 = fopen(featPath_1, 'rb');
featNum_1 = fread(fid_1, 1, 'int32'); %Number of SIFT features in the file
SiftFeat_1 = zeros(128, featNum_1); 
paraFeat_1 = zeros(4, featNum_1);
for i = 1 : featNum_1 %Read SIFT features one by one
    SiftFeat_1(:, i) = fread(fid_1, 128, 'uchar'); %Read in the 128 dimensional descriptor first
    paraFeat_1(:, i) = fread(fid_1, 4, 'float32'); %Read in the [x, y, scale, orientation] information
end
fclose(fid_1);
end

