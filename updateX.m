function [X Y] = updateX(Xs,Ys,Xt,Yt,Dcs,Dct,ratio)
ratio=ratio/100;
C = length(unique(Ys));
errs = diag(Dcs(1:end,Ys));
errt = diag(Dct(1:end,Yt));
X=[];Y=[];
for i = 1:C
    
    Xsc = Xs(:,Ys==i);
%     esc = errs(Ys==i);
%     [~,indexs] = sort(esc);
%     DetNum=ceil((1-ratio)*sum(Ys==i));
%     Xsc = Xsc(:,indexs(1:DetNum));
%    
    
    Xtc = Xt(:,Yt==i);
    etc = errt(Yt==i);
    [~,indext] = sort(etc);
    DetNum=ceil(ratio*sum(Yt==i));
    Xtc = Xtc(:,indext(1:DetNum));
    
    X=[X Xsc Xtc];
    Y=[Y;i*ones(size([Xsc Xtc],2),1)];
    
end