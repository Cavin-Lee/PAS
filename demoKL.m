% Test image datasets (ImageCLEF or Office-Home) using resnet50 features

img_dataset = 'office-home';  % 'image-clef' or 'office-home'
addpath('KLIEP')
if strcmp(img_dataset,'image-clef')
    str_domains = {'c', 'i', 'p'};
    addpath('E:\TLdata\imageCLEF_resnet50');  % You need to change this path
elseif strcmp(img_dataset,'office-home')
    str_domains = {'Art', 'Clipart', 'Product', 'RealWorld'};
    addpath('E:\TLdata\Office-Home_resnet50');    % You need to change this path
end

list_acc = [];
list_p=[];
ac=[];
pc=[];
gamma=1:1:50;q=1;
%for q=1:length(gamma)
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
            D = updataBasis(Xs',Ys,1);
            C = length(unique(Ys));
            
            Z = updataZ(Xt',C,D);
            Dct = updataDis(Xt',D,Z);
            [~,y_pred] = min(Dct,[],2);
           
            
            tmp(:,1)=diag(Dct(:,y_pred'));
            [wh_x_de]=KLIEP(Xt',Xs');

            tmp(:,2)=wh_x_de';
            result(q)={tmp};
            clear tmp
            q=q+1;
        end
    end
    
%end
save('result.mat','result')