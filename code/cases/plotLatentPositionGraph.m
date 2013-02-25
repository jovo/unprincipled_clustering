function plotLatentPositionGraph(A,X,Xhat, nFig)


[n,d]=size(X);
X0=X(1:n/2,:);
X1=X(n/2+1:end,:);

figure(nFig), clf, hold on

% latent positions
subplot(221), hold on
plot(X0(:,1),X0(:,2),'ro')
plot(X1(:,1),X1(:,2),'bx')
theta = linspace(-8*pi,8*pi,200);
plot(sin(theta),cos(theta),'k')
axis([0 1 0 1])
legend('0','1')

% embeddings embeddings
subplot(222), hold on
plot(Xhat(1:n/2,1),Xhat(1:n/2,2),'ro')
plot(Xhat(n/2+1:end,1),Xhat(n/2+1:end,2),'bx')


% P matrix and A matrix
P=X*X';
subplot(223), imagesc(P), colormap('bone'), axis('square'), %n/2+1:end
if any(P(:)<0) || any(P(:)>1),
    display('some P are impossible'),
else display('all P are good')
end
subplot(224), spy(A,1)

% subplot(122), hold on
% plot(Q(1:n/2,1),Q(1:n/2,2),'ro')
% plot(Q(n/2+1:end,1),Q(n/2+1:end,2),'bx')





