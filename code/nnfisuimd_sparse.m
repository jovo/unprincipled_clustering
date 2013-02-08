function centers=nnfisuimd_sparse(X,nc,cc);
%centers=nnfisui(X,nc,cc);
%nn farthest insertion subspace initialization

no=sum(X.^2);
[dim N]=size(X);
rid=ceil(N*rand);
buf=5;
for k=1:nc
    x=X(:,rid);
    sX=X-diag(x)*ones(dim,N);
    dd=sum(sX.^2);
    [td tdi]=sort(dd);
    [uu ss vv]=svds(X(:,tdi(1:cc+buf)));    
    centers{k}=uu(:,1:cc);    
    md(:,k)=no-sum((centers{k}'*X).^2);
    tmd=min(md,[],2);
    tmd=tmd/sum(tmd);
    
    rid=samplefromd(tmd);
end


end



function id=samplefromd(d);
%samples from density d
u=cumsum(d);
tu=u-rand;
tu(find(tu<0))=inf;
[ju id]=min(tu);

end






