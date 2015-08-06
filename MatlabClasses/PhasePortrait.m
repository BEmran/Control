clear
clc
%%
dt = 0.1;
time = 0:dt:30;
inc = 0.5;
phi = -2*pi : inc : 2*pi;
vel = -1   : inc: 1;
[s1,s2] = meshgrid(phi,vel);
l = length(s1(:));
L = length(time);
%%
X    = zeros (L,2);
Xdot = zeros (L,2);
figure(1)
hold on;
c = [0.8, 0.8, 0.8 ;...
     0.4, 0.4, 0.4];
for j = 1 : l
    X(1,:) = [s1(j),s2(j)];
    plot(X(1,1),X(1,2),'*')
    for i = 2 : length(time)
        
        Xdot(i,:)   = sp(X(i-1,:),0,0);
        X(i,:)      = TrapzInteg(Xdot(i,:),Xdot(i-1,:),X(i-1,:),dt);
        
        %xStart  = X(i-1,1);
        %yStart  = X(i-1,2);
        %xEnd    = Xdot(i,1);
        %yEnd    = Xdot(i,2);
        %line([xStart;yStart],[xEnd;yEnd],'Color',c(j,:));
        %pause(0.05);
    end
    plot(X(end,1),X(end,2),'*')
    plot (X(:,1),X(:,2))
    pause(0.2);
end
hold off;
