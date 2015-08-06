function Xdot = sp (x,u,t)
r = size(x,1);

m = 1;
b = 0;
g = 9.8;
l = 1;

Xdot    = zeros(r,2);
Xdot(:,1) = x(:,2);
%Xdot(:,2) = 1 / m / l^2 * ( - m * g * l * sin(x(:,1)) - b * x(:,2) + u );
Xdot(:,2) = - g / l * sin(x(:,1));

%Xdot(:,2) = - 6 * x(:,1) - 5 * x(:,2);

%Xdot(1,1) = x(2);
%Xdot(1,2) = -2 * x(1) - 4 * x(2) + 4 * u ;
end