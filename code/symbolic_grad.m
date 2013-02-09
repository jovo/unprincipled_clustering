% d=1 symbolic
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
% d=2 symbolic
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



