clear
clc
%%
dt = 0.1;
time = 0:dt:30;
inc = 0.1;
phi = -1*pi : inc : 1*pi;
vel = -0.1   : inc : 0.1  ;
phi = pi-1;
vel = 0.5 ;
[s1,s2] = meshgrid(phi,vel);
l = length(s1(:));
L = length(time);
%%
X    = zeros (L,2);
Xdot = zeros (L,2);
figure(1)
Xd = sp ([s1(:),s2(:)],0,0);
quiver(s1(:),s2(:),Xd(:,1),Xd(:,2));

hold on;
c = [0.8, 0.8, 0.8 ;...
    0.4, 0.4, 0.4];

for j = 1%floor(rand(1,10)*l)
    X(1,:) = [s1(j),s2(j)];
    plot(X(1,1),X(1,2),'*r')
    for i = 2 : length(time)
        Xdot(i,:)   = sp(X(i-1,:),0,0);
        X(i,:)      = TrapzInteg(Xdot(i,:),Xdot(i-1,:),X(i-1,:),dt);
        
        %xStart  = S(1);
        %yStart  = S(2);
        %xEnd    = Xdd(1)*0.01;
        %yEnd    = Xdd(2)*0.01;
        %line([xStart;yStart],[xEnd;yEnd]);
        %pause(0.1);
    end
    plot(X(end,1),X(end,2),'b*')
    plot (X(:,1),X(:,2),'linewidth',2)
    quiver(X(1:end-1,1),X(1:end-1,2),Xdot(2:end,1),Xdot(2:end,2),'linewidth',2);
    pause(0.2);
end
hold off;
