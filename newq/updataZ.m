function Z = updataZ(X,C,D)
%%%%%%%%%%%%%%%
% update the representation of subspace
% Xs data matrix d*ns
% Ys label       1*ns
% Xt data matrix d*nt
% D  subspace    d*dD*C

% Z representative dD*n*C


dD = size(D,2);
n =size(X,2);
Z = zeros(dD,n,C);

for i = 1:C
    Z(:,:,i) = D(:,:,i)'*X;
end

