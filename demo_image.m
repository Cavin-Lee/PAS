% Test image datasets (ImageCLEF or Office-Home) using resnet50 features

img_dataset = 'office-home';  % 'image-clef' or 'office-home'

if strcmp(img_dataset,'image-clef')
    str_domains = {'c', 'i', 'p'};
    addpath('D:\TLdata\imageCLEF_resnet50');  % You need to change this path
elseif strcmp(img_dataset,'office-home')
    str_domains = {'Art', 'Clipart', 'Product', 'RealWorld'};
    addpath('C:\Users\leewe\Desktop\Subspae\data\Office-Home_resnet50');    % You need to change this path
end

list_acc = [];
list_p=[];
ac=[];
pc=[];
gamma=1:1:50;
for q=1:length(gamma)
    for i = 1 : 4
        for j = 1 : 4
            if i == j
                continue;
            end
            src = str_domains{i};
            tgt = str_domains{j};
            fprintf('%s - %s\n',src, tgt);
            
            data = load([src '_' src '.csv']);
            fts = data(1:end,1:end-1);
  
            Xs = zscore(fts, 1);%% step3
            
            Ys = data(1:end,end) + 1;
            
            data = load([src '_' tgt '.csv']);
            fts = data(1:end,1:end-1);
            
            Xt = zscore(fts, 1);%% step3
            Yt = data(1:end,end) + 1;
            d=gamma(q);
            ratio=100;
            [Acc1 p]= SSDA(Xs',Xt',Ys,Yt,d,ratio);
            
            
            list_acc = [list_acc;[Acc1]];
            list_p = [list_p;[p]];
    
            
        end
    end
    ac=[ac list_acc];
    pc=[pc {list_p}];
    list_acc=[];
    list_p=[];
    disp(ac)
    save('result_imagehome.mat','ac','pc')
end