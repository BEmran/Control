clear
clc
%%
dt = 0.01;
t = 0 : dt: 10;
L = length(t);
u = zeros(1,L);
u(1:500) = 1;
%%
X    = zeros (L,1); 
Xdot = zeros (L,1);
figure(1)

for i = 2: L
    Xdot(i)   = foo(X(i-1),u(i),0);
    X(i)      = TrapzInteg(Xdot(i),Xdot(i-1),X(i-1),dt);   
end
Sys = tf(3,[1,3]);
[yy,tt,xx] = lsim(Sys,u,t);
plot(tt,yy,'b',t,X,'-r')
