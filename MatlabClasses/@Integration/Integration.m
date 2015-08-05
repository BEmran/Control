classdef Integration  < handle
    % Done By : Bara Emran
    % Date    : 4th Aug 2015
    % Version : 0.2
    % Caculate the Integration using forward eqution
    % Ex : I = Integration('x0',x0,'dt',dt)
    %      x = I.ForwardInteg(dx)
    %      x = I.TrapzInteg(dx)
    
    properties
        x0 = [];    % initial values
        dt = [];    % time step
    end
    
    methods
        function obj = Integration(varargin)
            % Initilaizing default values;
            x0_ = 0;
            dt_ = 1;
            
            % Read values for given options
            for i = 1:nargin
                if strcmpi('x0',varargin{i})    % check for x0
                    x = varargin{i+1};
                    if (isnumeric(x) && isvector(x)) % check if numeric & vector
                        x0_ = x;
                    else
                        error('Error. \nx0 input must be a numeric and vector, not a %s.',class(x) )
                    end
                elseif strcmpi('dt',varargin{i})    % check for dt
                    x = varargin{i+1};  
                    if isnumeric(x)                 % check if numeric
                        dt_ = x;
                    else
                        error('Error. \ndt input must be a numeric, not a %s.',class(x))
                    end
                end %if
            end %for
            
            % Assign values in the object
            obj.x0 = x0_(:)';
            obj.dt = dt_;
        end %function
        
        function set_x0(obj,x0_)
            if (isnumeric(x0_) && isvector(x0_))
                obj.x0 = x0_;
            else
                error('Error. \nx0 input must be a numeric and vector, not a %s.',class(x) )
            end
        end %set_x0 function
        
        function set_dt(obj,dt_)
            if (isnumeric(dt_))
                obj.dt = dt_;
            else
                error('Error. \ndt input must be a numeric, not a %s.',class(x) )
            end
        end %set_dt function
        
        function x1 = ForwardInteg(obj,dx)
            x1      = dx(:) * obj.dt + obj.x0(:);   % Calculate the integration
            obj.x0  = x1';                          % Change to row and Store  
            
        end  % ForwardInteg function
        
        function x1 = TrapzInteg(obj,dx)
            persistent dx0;  
            if isempty(dx0)
                dx0 = 0;
            end
            
            x1      = 0.5 * (dx(:) + dx0)* obj.dt...
                        + obj.x0(:);    % Calculate the integ            
            obj.x0  = x1';              % Change to row and Store                    
            dx0 = dx;                   % store dx for next round
        end  % TrapzInteg function
        
    end
end

