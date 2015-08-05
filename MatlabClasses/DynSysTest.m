clear;
clc;
%% Intilization:
% Parameters
dt = 0.001;
t = 0:dt:10;
L = length (t);
% Dynamic system:
V = Vector('cols' , 1 ,'rows',L);
D = DynSys('x0',0,'dt',dt,'func',@foo);
% System input:
u = zeros(1,L);
u(1:floor(L/2)) = 1;
%% main for loop for dynamic system
tic
PushSingle(V,D.I.x0,t(1));
% for i = 2:length(t)
%     [Y,Ydot] = D.Simulate('u',u(i));
%     PushSingle(V,Y,t(i));
% end
[Y,Ydot] = D.Simulate('u',u,'t',t(end));
Push(V,Y,t(2:end));
toc
%% Linear system
tic
sys = tf(3,[1 3]);
[y_TF,t_TF,xx] = lsim(sys,u,t);
toc
%% Plot
plot(t_TF,y_TF,'DisplayName','yy'); hold all;
plot(V.Time, V.Data,'DisplayName','y'); hold off;
legend('tf system','DynSys');
xlabel('time (sec)')