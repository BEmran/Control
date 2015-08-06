function Xdot = sp (x,u,t)
m = 10;
b = 1;
g = 9.8;
l = 1;

Xdot    = zeros(1,2);
Xdot(1,1) = x(2);
Xdot(1,2) = 1 / m / l^2 * ( - m * g * l * sin (x(1)) - b * x(2) + u );

%Xdot(1,1) = x(2);
%Xdot(1,2) = -2 * x(1) - 4 * x(2) + 4 * u ;
end