function hist = Measure(s,h_k,features)
%Input: s=structure of hierarchical clustering
%       Features=image feature points, each point being a column vector within them
%       h_K=number of clusters at each level of hierarchical clustering
%Output: hist=dictionary statistical histogram of the image

hist = zeros(1,prod(h_k));
for j = 1:1:size(features,2)
    t = s;
	xcord = 0;%The x coordinate of the histogram where the feature point is located
	layer = 1;%Number of layer
	errors = sum((t.center-features(:,j)).^2);
	tag = find(errors == min(errors));
	if layer == max(size(h_k))%Reaching the last layer
        xcord = xcord + tag;
	else%In the middle layer
        xcord = xcord+(tag-1)*prod(h_k(layer+1:end));
	end
	%Search Down
	while t.cn > 0
        t = t.(sprintf('c%d',tag));%Point to the cluster center of the next layer
        layer = layer+1;
        errors = sum((t.center-features(:,j)).^2);
        tag = find(errors == min(errors));           
        if layer == max(size(h_k))%Reaching the last layer
            xcord = xcord + tag;
        else%In the middle layer
            xcord = xcord+(tag-1)*prod(h_k(layer+1:end));
        end
    end
	hist(xcord) = hist(xcord)+1;
end