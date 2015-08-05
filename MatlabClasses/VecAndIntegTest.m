clear;
clc;
dt = 0.01;
t = 0:dt:10;
L = length (t);

I1 = Integration('x0',-1,'dt',dt);
I2 = Integration('x0',-1,'dt',dt);
V1 = Vector('cols' , 1 ,'rows',L);
V2 = Vector('cols' , 1 ,'rows',L);

x = sin(t);
yy = - cos(t);
V1 = Push(V1,I1.x0,t(1));
V2 = Push(V2,I2.x0,t(1));
tic
for i = 2:length(t)
    y1 = I1.ForwardInteg(x(i));
    PushSingle(V1,y1,t(i));

    y2 = I2.TrapzInteg(x(i));
    PushSingle(V2,y2,t(i));
end
display(toc)
plot(yy,'DisplayName','yy');
hold all;
plot(V1.Data,'DisplayName','y1');
plot(V2.Data,'DisplayName','y2');
hold off;