clear, clc
syms x1 x2 x3 a11 a12 a13 a21 a22 a23 a31 a32 a33
syms lam u1 u2 u3
x=transpose([x1; x2; x3]);
u=transpose([u1; u2; u3]);
a=[a11 a12 a13; a21 a22 a23; a31 a32 a33];

f=sum((x-u).^2) + lam*sum(sum((a-transpose(x)*x).^2));

xu=[x, u];

g=gradient(f,xu);

pretty(simplify(simplify(g/2)))

%%

clear, clc
% n = 3
% d = 1
syms x11 x12 x21 x22 x31 x32 a11 a12 a13 a21 a22 a23 a31 a32 a33
syms lam u11 u12 u21 u22 u31 u32 
x=[x11, x12; x21, x22; x31, x32];  % X in R^{3x3}
u=[u11, u12; u21, u22; u31, u32];
a=[a11 a12 a13; a21 a22 a23; a31 a32 a33];

f=sum(sum((x-u).^2)) + lam*sum(sum((a-x*transpose(x)).^2));

xu=[x; u];

g=gradient(f,xu);

pretty(simplify(simplify(g/2)))


%%
clc
K=2;
mu0 = [0.8, 0.4]/2;
mu1 = [0.2, 0.5]/2;

pi = -.5;
sigma = 0.04;

n=100;
d=2;
X0 = sigma*randn(n/2,d)+repmat(mu0',1,n/2)';
X1 = sigma*randn(n/2,d)+repmat(mu1',1,n/2)';
X  = [X0; X1];  % in R^(n x d)

P=X*X';


figure(1), clf, hold on
plot(X0(:,1),X0(:,2),'ro')
plot(X1(:,1),X1(:,2),'bx')
theta = linspace(-8*pi,8*pi,200);
plot(sin(theta),cos(theta),'k')
axis([0 1 0 1])
legend('0','1')

figure(2), clf, 
subplot(121), imagesc(X*X'), colormap('gray'),  axis('square'), %n/2+1:end

if any(P(:)<0) || any(P(:)>1), 
    display('some P are impossible'), 
else display('all P are good')
end

A=P>rand(n,n);
subplot(122), spy(A)


[U, D] = eigs(double(A),2);

figure(3), clf, hold on
plot(U(1:n/2,1),U(1:n/2,2),'ro')
plot(U(n/2+1:end,1),U(n/2+1:end,2),'bx')
