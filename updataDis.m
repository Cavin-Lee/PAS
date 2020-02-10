function Dct = updataDis(X,D,Z)
%%%%%%%%%%%%%%%
% update the representation of subspace
% X  data matrix d*ns
% D  subspace    d*dD*C
% Z representative dD*n*C


dD = size(D,2);
C = size(D,3);
Dct = [];
for i = 1:C
    Dct_c = sqrt(sum((X - D(:,:,i)*Z(:,:,i)).^2,1))';
    Dct = [Dct,Dct_c];
    clear Dct_c
end
