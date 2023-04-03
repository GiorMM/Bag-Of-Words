function s = BoWHKmeans(data,h_k)
%Input: data=Input data point
%      h_K=the number of classes of kmeans in each layer, from left to right, in order of the number of classes from the first layer to the last layer
%Output: s=Results at all levels of clustering


s = struct;
n = h_k(1);
[it,ct] = kmeans(data', n);
%Save clustering results
s.center = ct';%Cluster center coordinates
s.id = it; %Classification results of data
s.cn = 0;%Number of Substructures
for i = 1:1:n
    %Last layer, skip
	if max(size(h_k)) == 1
        continue;
    end
        
	x = find(s.id == i);%Find the data sequence number with category i
    %"1/3 of the data amount is less than the number of clusters, skip"
	if max(size(x))/3 < h_k(2)
        continue;
    end
    
	samples = data(:,x);%Construct cluster samples  
	t = BoWHKmeans(samples,h_k(2:end));   
	eval(['s.c',num2str(i),'=struct;']);%Construction Substructure
	s.(sprintf('c%d',i)) = t;
	s.cn = s.cn+1;
end
end