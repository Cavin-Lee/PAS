function [acc p]= SSDA(Xs,Xt,Ys,Yt,dD,iter)

if nargin<5
    dD=4;
end
C = length(unique(Ys));
dim = size(Xs,1);

X = Xs;
Y = Ys;
for i=1:iter
    D = updataBasis(X,Y,dD);
    Zt = updataZ(Xt,C,D);
    Dct = updataDis(Xt,D,Zt);
    Zs = updataZ(Xs,C,D);
    Dcs = updataDis(Xs,D,Zs);  
    [~,y_pred] = min(Dct,[],2);
    [X Y] = updateX(Xs,Ys,Xt,y_pred,Dcs,Dct,i);
    p(i)=mean(y_pred==Yt);
end

acc=mean(y_pred==Yt);