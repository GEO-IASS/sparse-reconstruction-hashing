%%
clear all;
clc;
path(path,'dataIO');
%%
load data/sift_training.mat;   %SIFT1M 
load data/sift_test.mat;
Xtraining= single(Xtraining(1:120000,:));
Xtest = single(Xtest(1:2000,:));

%load data/cifar_10yunchao.mat  %cifar10 
%load data/cifar-10-batches-mat/test_batch.mat %计算S矩阵用
% Xtraining= single(cifar10(1:59000,1:end-1));
% Xtest = single(cifar10(59001:60000,1:end-1));
% XtestLabels=labels(9001:end,:);
% Scifar=getS(XtestLabels);

%  load data/MNIST_gnd_release.mat;
%  Xtraining=MNIST_trndata;
%  Xtest=MNIST_tstdata;
%cifar

%center the data
MM=mean(Xtraining, 1);
Xtraining=Xtraining-repmat(MM,length(Xtraining),1);
Xtest=Xtest-repmat(MM,size(Xtest,1),1);
%%
figure;
scatter(Xtraining(:,1), Xtraining(:,2), 3, 'b');
hold on;
scatter(Xtest(:,1), Xtest(:,2), 3, 'r');

% define ground-truth neighbors (this is only used for the evaluation):
Nneighbors=0.01*length(Xtraining);
DtrueTestTraining = distMat(Xtest,Xtraining); % size = [Ntest x Ntraining]
%测试样本与训练样本之间的距离
[Dball, I] = sort(DtrueTestTraining,2); %按行排列，每一行表示测试样本数据点与训练样本数据点的距离
KNN_info.knn_p2=I(:,1:Nneighbors); %保存测试数据点的1000个近邻索引 10000*1000
KNN_info.dis_p2=Dball(:,1:Nneighbors); %保存测试数据点的1000个近邻的欧式距离 10000*1000
save('.\data\Data_sift1M','Xtraining','Xtest','KNN_info');
%save('.\data\Data_cifar','Xtraining','Xtest','KNN_info');
%save('.\data\S_cifar','Scifar');
% save('.\data\Data_MNIST','Xtraining','Xtest','KNN_info');
%save('.\data\Data_MNISTest','Xtraining','Xtest','KNN_info');