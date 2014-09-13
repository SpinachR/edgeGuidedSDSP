% compute RMSE for images in the results
clc; clear; 

p = pwd;
addpath(fullfile(p, 'funcs'));

scale=4;
boarder=10;
offset=1;

names=cell(4);
names{1}='cones';
names{2}='teddy';
names{3}='tsukuba';
names{4}='venus';

para.K=[0.01 0.02];
para.win=fspecial('gaussian', 11, 1.5);

for i=1:4
    if (i==1 || i==2)
        scaleFact = 4;
    elseif (i==3)
        scaleFact = 16;
    elseif (i==4)
        scaleFact = 8;
    end

    inputFile=names{i};
    gtFile=['inputs/', inputFile, '_clean.png'];
    outputFile=['outputs/v2/s', num2str(scale), '/', inputFile, '2_', num2str(scale), '.png'];

    gt=double(imread(gtFile))/scaleFact;
    output=double(imread(outputFile))/scaleFact;
    % offset shift, don't know why, but there it is...
    output(1+offset:end,1+offset:end)=output(1:end-offset, 1:end-offset);
    
    para.l=max(max(gt))-min(min(gt));

    %crop the original for downsampling
    sz = size(gt);
    sz = sz - mod(sz, scale);
    gt = gt(1:sz(1), 1:sz(2));

    rmseV=calc_rmse(output(boarder+1:end-boarder,boarder+1:end-boarder),...
        gt(boarder+1:end-boarder,boarder+1:end-boarder));

    ssimV=ssim(output(boarder+1:end-boarder,boarder+1:end-boarder),...
       gt(boarder+1:end-boarder,boarder+1:end-boarder),para.K,para.win,para.l);
   
   fprintf([inputFile,': RMSE= ', num2str(rmseV),'\n']);
   fprintf([inputFile,': SSIM= ', num2str(ssimV),'\n']);

end
