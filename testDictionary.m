% debug code
% test the consistency of high and low resolution image patches from the dataset

clear;
close all;

load result/patchData_4_high3;


sum(abs(lowdataTrans(1,:)-highdataTrans(1,:)))

temp=[highdata, lowdata];
[C, ia, ic] = unique(temp,'rows');
highdata1=highdata(ia,:);
lowdata1=lowdata(ia,:);
%lowdataTrans=lowdataTrans(ia,:);
%highdataTrans=highdataTrans(ia,:);

for i=1:size(highdata1)
    figure;
    subplot(1,2,1); imshow(reshape(lowdata1(i,:),21,21));
    subplot(1,2,2); imshow(reshape(highdata1(i,:),21,21));
    
    a=0;
end