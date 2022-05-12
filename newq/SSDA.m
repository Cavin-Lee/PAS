function [acc p]= SSDA(Xs,Xt,Ys,Yt,dD,iter)

if nargin<5
    dD=4;
end
C = length(unique(Ys));
dim = size(Xs,1);

if size(Xs,1)>size(Xt,1)
	n = size(Xt,2);
    tmp=zeros(size(Xs,1)-size(Xt,1),n);
	Xt = [Xt;tmp];
end
if size(Xt,1)>size(Xs,1)
	n = size(Xt,2);
	H = eye(n)-1/(n)*ones(n,n);
	[A,~] =  eigs(Xt*H*Xt',size(Xs,1),'LM');
    Xt = A'*Xt;
end



X = Xs;
Y = Ys;


for i=1:iter
    D = updataBasis(X,Y,dD);
    Zt = updataZ(Xt,C,D);
    Dct = updataDis(Xt,D,Zt);
    Zs = updataZ(Xs,C,D);
    Dcs = updataDis(Xs,D,Zs);  
    [~,y_pred] = min(Dct,[],2);
    [X Y] = updateXt(Xs,Ys,Xt,y_pred,Dcs,Dct,i);
    p(i)=mean(y_pred==Yt);
end
  D = updataBasis(X,Y,dD);
    Zt = updataZ(Xt,C,D);
    Dct = updataDis(Xt,D,Zt); 
    [~,y_pred] = min(Dct,[],2);
p(i+1)=mean(y_pred==Yt);
for i = 1:length(unique(Yt))
acc(i)=mean(y_pred(Yt==i)==Yt(Yt==i));
end