function X = GenLatentSubspacePositions(n,params)

r=params.rank;
d=params.DimAmbient;
k=params.nSubspaces;
c=params.shift;

% generate X
U={};
X=[];
for i=1:k
    U{i}=rand(d,r);
    U{i}=U{i}/norm(U{i});
    offset=c*rand(d,1)*ones(1,n/k);
    Y{i}=U{i}*rand(r,n/k)+offset;
    Y{i}=Y{i}/max(1.5*abs(Y{i}(:)));
    X=[X Y{i}];
end
X=X';