
classdef DynSys < handle
    % Done By : Bara Emran
    % Date    : 5th Aug 2015
    % Version : 0.2
    % Define Dynamic system and simulate the results
    % Ex:
    %   D        = DynSys('x0',0,'dt',dt,'func',@func);
    %   [X,Xdot] = D.Simulate('u',u,'t',EndT);
    
    properties
        %X    = []   % System state
        %Xdot = []   % System sate derivative
        Func    = []                % Function Handle
        n       = []                % Number of states
        I       = Integration();    % Integration object
        cState  = []
    end
    
    methods
        function obj = DynSys(varargin)
            % Initilaizing default values;
            x0_     = 0;
            Func_   = @(x,u,t) 0;
            
            % Read values for given options           
            obj.I = Integration(varargin{:});   %initilize I object
            
            for i = 1:2:nargin
                if strcmpi('func',varargin{i})
                    Func_ = varargin{i+1};
                end %if
            end %for
            
            % Assign values in the object
            obj.n       = length(obj.I.x0);
            set_Func(obj,Func_);
            obj.cState  = x0_;
        end %function
     
        function set_Func(obj,func)
            if (isa(func,'function_handle'))
                obj.Func = @(x,u,t) func(x,u,t);
            else
                error('Error. \nfunc input must be a function_handle, not a %s.',class(x) )               
            end
        end %function
        
        function [X,Xdot] = Simulate(obj,varargin)
            
            % Initilaizing default values;
            time    = obj.I.dt;   % Simulation time
            
            for i = 1:2:nargin -1
                if     strcmpi('u',varargin{i})
                    u = varargin{i+1};
                elseif strcmpi('t',varargin{i})
                    time = varargin{i+1};
                elseif strcmpi('x0',varargin{i})
                    obj.I.x0    = [varargin{i+1}]';
                    obj.n       = length(obj.I.x0);
                end %if
            end %for
            
            L       = time/obj.I.dt;      % Number of steps
            
            if ~exist('u','var')
                u = zeros(1,L);         % Zeros as input value
            end
            X       = zeros(L,obj.n);       % Define State vector
            Xdot    = zeros(L,obj.n);       % Define State dot vector
            u = u(:);
            for i = 1 : L
                cTime   = i*obj.I.dt;
                Xdot_   = obj.Func(obj.I.x0,u(i,:),cTime);    % find Xdot
                %X_      = ForwardInteg(obj.I, Xdot_   );        % integrate Xdot
                X_      = TrapzInteg(obj.I, Xdot_   );
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


