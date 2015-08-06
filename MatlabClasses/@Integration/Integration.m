classdef Integration  < handle
    % Done By : Bara Emran
    % Date    : 30th May 2015
    % Version : 0.1
    % Caculate the Integration using forward eqution
    % Ex : I = Integration('x0',x0,'dt',dt)
    %      x = I.FInteg(dx)
    
    properties
        x0 = []     % initial values
        dt = []     % time step
    end
    
    methods
        function obj = Integration(varargin)
            % Initilaizing default values;
            x0_ = 0;
            dt_ = 1;
            
            % Read values for given options
            for i = 1:nargin
                if strcmpi('x0',varargin{i})
                    x0_ = varargin{i+1};
                elseif strcmpi('dt',varargin{i})
                    dt_ = varargin{i+1};
                end %if
            end %for
            
            % Assign values in the object
            obj.x0 = x0_(:)';
            obj.dt = dt_;
            
        end %function
            
        function set_x0(obj,x0_)
            obj.x0 = x0_;           
        end %function
        
        function set_dt(obj,dt_)
            obj.dt = dt_;           
        end %function
        
        function x1 = FInteg(obj,dx)
            x1      = dx(:) * obj.dt + obj.x0(:);   % Calculate the integration
            x1      = x1';                          % change to row
            obj.x0  = x1;                           % Store new values as intial for next step
        end  %function
        
    end
end

