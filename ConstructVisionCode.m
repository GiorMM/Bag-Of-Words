function code = ConstructVisionCode(image_root_path, N)
%Input: image_root_path = the path of image folder
%       N = total number of sift features in the vision code
%Output: code = the vision code

code = [];
n = round(N/1000);
for i = 0:999
    file = [image_root_path, FileName(i)];
    [sift, para] = ReadSiftFeature(file);
    code = [code RandomSIFT(sift,n)];
end   
end

