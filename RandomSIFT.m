function out = RandomSIFT( sift, n )
%Randomly select n points from the SIFT data points of each image
%Sift is all data points of an image
%N is the number of samples

%c is the number of SIFT descriptors of the image
[r,c] = size(sift);

%If the number of samples is greater than the number of features of the image points
%Then all feature points of the image are taken
if(n > c)
    n = c;
end

%Take n random integers between [1, c]
s = randperm(c,n);
out = [];
for i = s
    out = [out, sift(:, i)];
end

end

