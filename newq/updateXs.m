function [X Y index] = updateX(Xs,Ys,Xt,Yt,Dcs,Dct,time,index)

sel_num=ceil(1)
C = length(unique(Ys));
errs = diag(Dcs(1:end,Ys));
errt = diag(Dct(1:end,Yt));
X=[];Y=[];
unselect = find(index==0);
Xt = Xt(:,unselect);
Yt = Yt(unselect);
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