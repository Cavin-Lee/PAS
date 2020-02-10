function D = updataBasis(Xs,Ys,dD)
%%%%%%%%%%%%%%%
% update the basis of subspace
% Xs data matrix d*ns
% Ys label       1*ns
% Xt data matrix d*nt
% U partition    C*nt
if nargin <3
	dD =20;
end
d = size(Xs,1);
C = length(unique(Ys));
D = zeros(d,dD,C);
for i = 1:C
    tmp = Xs(:,Ys==i);
    [B,~,~] = svd(tmp);
    D(:,:,i)=B(:,1:dD);
    clear tmp B;
end

    