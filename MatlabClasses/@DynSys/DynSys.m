classdef DynSys < Integration & handle
    % Done By : Bara Emran
    % Date    : 30th May 2015
    % Version : 0.1
    % Define Dynamic system and simulate the results
    % Ex:
    %   D        = DynSys('x0',0,'dt',dt,'func',@func);
    %   [X,Xdot] = D.Simulate('u',u,'t',EndT);
    
    properties      
        %X    = []   % System state 
        %Xdot = []   % System sate derivative
        Func = []   % Function Handle;
        n    = []   % Number of states
        cState = []
    end
    
    methods
        function obj = DynSys(varargin)
            % Initilaizing default values;
            x0_     = 0;
            dt_     = 1;            
            %Func_   = x+u;
            
            % Read values for given options
            for i = 1:nargin
                if strcmpi('x0',varargin{i})
                    x0_ = [varargin{i+1}]';
                elseif strcmpi('dt',varargin{i})
                    dt_ = varargin{i+1};
                elseif strcmpi('func',varargin{i})
                    
                    Func_ = @(x,u,t)varargin{i+1}(x,u,t);
                end %if
            end %for
            
            % Assign values in the object
            obj.x0      = x0_;
            obj.n       = length(obj.x0);         
            obj.dt      = dt_;            
            obj.Func    = Func_;         
            obj.cState  = x0_;
        end %function
        
        function y = ff(obj)
            y =  obj.Func([1,1],1,1);
        end
        function set_Func(obj,func)
            obj.Func = @(x,u,t) func(x,u,t);          
        end %function
        
        function [X,Xdot] = Simulate(obj,varargin)
            
           % Initilaizing default values;
            u       = 0;        % Input value
            time    = obj.dt;   % Simulation time
            
            for i = 1:2:nargin -1 
                if     strcmpi('u',varargin{i})
                    u = varargin{i+1};
                elseif strcmpi('t',varargin{i})
                    time = varargin{i+1};
                elseif strcmpi('x0',varargin{i})
                    obj.x0 = [varargin{i+1}]';
                    obj.n  = length(obj.x0);
                end %if
            end %for

            L       = time/obj.dt;      % Number of steps
            
            if ~exist('u','var')
                u = zeros(1,L);         % Zeros as nput value
            end
            X       = zeros(L,obj.n);       % Define State vector
            Xdot    = zeros(L,obj.n);       % Define State dot vector
            
            for i = 1 : L
                cTime   = i*obj.dt;
                Xdot_   = obj.Func(obj.x0,u(i,:),cTime);  % find Xdot
                X_      = obj.FInteg(Xdot_            );  % integrate Xdot
                % Store the new Values
                Xdot(i,:)   = Xdot_;
                X(i,:)      = X_;              
            end %for                    
            obj.cState  = X_;
        end %function
        
        function [X,Xdot] = SimulateVec(obj,X,Xdot,varargin)
            
           % Initilaizing default values;
            u       = 0;        % Input value
            time    = obj.dt;   % Simulation time
            cTime   = 0;        % Current time;
            for i = 1:2:min(nargin,5)
                if     strcmpi('u',varargin{i})
                    u = varargin{i+1};
                elseif strcmpi('t',varargin{i})
                    time = varargin{i+1};
                elseif strcmpi('x0',varargin{i})
                    obj.x0 = [varargin{i+1}]';
                    obj.n  = length(obj.x0);
                elseif strcmpi('cTime',varargin{i})
                    cTime = varargin{i+1};
                end %if
            end %for

            L       = time/obj.dt;      % Number of steps
            
            if ~exist('u','var')
                u = zeros(1,L);         % Zeros as nput value
            end
            
            %X       = Vector('cols' , obj.n ,'rows',L + 1); % Define State vector
            %Xdot    = Vector('cols' , obj.n ,'rows',L + 1); % Define State dot vector
            %Push(X   , obj.x0        ,0)                    % initilaize intial vaules
            %Push(Xdot, zeros(1,obj.n),0)                    % zeros as first values
            
            for i = 1 : L
                Xdot_   = obj.Func(obj.x0,u(i,:),cTime);  % find Xdot 
                X_      = obj.FInteg(Xdot_      );  % integrate Xdot
                % push the new Values
                Push(X   , X_    ,i*obj.dt + cTime);              
                Push(Xdot, Xdot_ ,i*obj.dt + cTime);               
            end %for                    
            obj.cState  = X_;
        end %function
        function [X,Xdot] = SimulateShort(obj,u,time)

            L       = time/obj.dt;          % Number of steps
            X       = zeros(L,obj.n);       % Define State vector
            Xdot    = zeros(L,obj.n);       % Define State dot vector
            for i = 1 : L
                cTime   = i*obj.dt;
                Xdot_   = obj.Func(obj.x0,u(i,:),cTime);  % find Xdot
                X_      = obj.FInteg(Xdot_            );  % integrate Xdot
                % Store the new Values
                Xdot(i,:)   = Xdot_;
                X(i,:)      = X_;              
            end %for                    
            obj.cState  = X_;
        end %function
    end
    
end


