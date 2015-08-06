classdef SimplePendulum < handle
    % Done By : Bara Emran
    % Date    : 5th Aug 2015
    % Version : 0.1
    % Define simple pendulum dynamic system and simulate the results
    % Ex:
    
    properties
        %X    = []      % System state
        %Xdot = []      % System sate derivative
        m = [];         % Pendulum mass
        b = [];         % Damping/friction coefficient 
        l = [];         % Pendulum length
        g = 9.8;        % Gravitiy acceleration
        cState = []
    end
    
    methods
        function obj = SimplePendulum(varargin)
            % Initilaizing default values;
            m_ = 1;         % Pendulum mass
            b_ = 1;         % Damping friction
            l_ = 1;         % Pendulum length
            
            % Read given options
            for i = 1:nargin
                if strcmpi('m',varargin{i})
                    m_ = [varargin{i+1}]';
                elseif strcmpi('b',varargin{i})
                    b_ = varargin{i+1};
                elseif strcmpi('l',varargin{i})
                    l_ = varargin{i+1};
                end %if
            end %for
            
            % Assign values in the object
            set_m (obj,m_)
            set_l (obj,l_)
            set_b (obj,b_)
        end %function
        
        function set_m (obj,m_)
            if isnumeric(m_)
                obj.m = m_;
            else
                error('Error. \nmass (m) must be a numeric, not a %s.',class(n))
            end
        end
        
        function set_l (obj,l_)
            if isnumeric(l_)
                obj.l = l_;
            else
                error('Error. \nlength (l) must be a numeric, not a %s.',class(n))
            end
        end
          
        function set_b (obj,b_)
            if isnumeric(b_)
                obj.b = b_;
            else
                error('Error. \nfriction coefficient (b) must be a numeric, not a %s.',class(n))
            end
        end
          
        function [X,Xdot] = NonLinearPlant (x,u,t)
            % xdot2 = x(2);
            % xdot2 = 1/m/l^2 * ( -m*g*l*sin(th) - b*x(2) + u );
            Xdot    = zeros(1,2);
            Xdot(1,1) = x(2);
            Xdot(1,2) = 1 / obj.m / obj.l^2 * ( - obj.m * obj.g * obj.l * sin (x(1)) - obj.b * x(2) + u );
        end
    end
end