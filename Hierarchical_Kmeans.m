function [class_id,cluster_center] = Hierarchical_Kmeans(data, h_k)
%输入：data = 输入数据点
%      h_k = 各层kmeans的类数，从左到右顺序为从第一层到最后一层的类数
%输出：class_id = 数据点的聚类结果
%      cluster_center = 聚类中心

%计时
t = 0;
tic;

[it,ct] = kmeans(data', h_k(1));
%保存聚类结果
class_id = it; 
cluster_center = ct';

%记录提前完成的聚类数和聚类中心
fcount = 0;
fcenter = [];

n = max(size(h_k));
for i = 2:1:n 
    kcount = 0;
    ct = [];
    for j = 1:1:max(class_id)
        x = find(class_id == j);%找到上次聚类结果为j的数据的序号
        if max(size(x))/2<h_k(i)%样本数的一半比目标分类数少，提前退出
            fcount = fcount+1;
            fcenter = [fcenter cluster_center(:,j)];
            class_id(x) = -1*fcount;
            continue;
        end
                    
        %构造聚类样本
        samples = data(:,x);
        
        %当前层进行聚类
        [it1,ct1] = kmeans(samples', h_k(i));
        class_id(x) = kcount+it1;%更新数据的分类结果
        kcount = kcount+max(it1);
        %记录kmeans的聚类中心
        ct = [ct ct1'];
    end
    cluster_center = ct;
end

%将提前退出的聚类结果附上
if fcount > 0
    x = find(class_id < 0);
    class_id(x) = max(class_id) - class_id(x);
    cluster_center = [cluster_center fcenter];
end

t  = t+toc;
['层次K-means总耗时: ',num2str(t),'s']

end

