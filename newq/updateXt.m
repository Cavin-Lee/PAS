function [X Y] = updateXt(Xs,Ys,Xt,Yt,Dcs,Dct,ratio)
ratio=ratio/100;
C = length(unique(Ys));
errs = diag(Dcs(1:end,Ys));
errt = diag(Dct(1:end,Yt));
X=[];Y=[];
[~,index] = sort(errt);
DetNum=ceil(ratio*length(Yt));

X=[Xs Xt(:,index(1:DetNum))];
Y=[Ys;Yt(index(1:DetNum))];
