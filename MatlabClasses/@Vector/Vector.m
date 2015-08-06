classdef Vector < handle
    % Done By : Bara Emran
    % Date    : 30th May 2015
    % Version : 0.1
    % Vector Class
    % Ex: V = Vector('cols' , 1 ,'rows',10);
    
    properties
        Data  = [];     % Stored Data 
        Time  = [];     % corresponding Time
        Count = [];     % Counter
        Rows  = [];     % Number of Rows
        Cols  = [];     % Number of Cols
        cData = [];     % Current Data
    end
    
    methods
        function obj = Vector(varargin)
            % Initilaizing default values;
            obj.Rows = 1;
            obj.Cols = 1;

            % Read values for given options            
            for i = 1:nargin
                if strcmpi('Cols',varargin{i})
                    obj.Cols = varargin{i+1};
                elseif strcmpi('Rows',varargin{i})
                    obj.Rows = varargin{i+1};
                end %if
            end %for
            
            % Assign values in the object
            obj.Data = zeros(obj.Rows,obj.Cols);
            obj.cData = obj.Data(1,:);
            obj.Time = zeros(obj.Rows,1);
            obj.Count = 0;
            
        end %function

        function obj = Push(obj,NewData,NewTime)
            C = [];
            r = size(NewData,1);                    % Size of row
            C(1) = obj.Count;                       % Find current counter
            obj.Data(C+1: C+r, :  ) = NewData;      % Store the new Data
            obj.Time(C+1: C+r, 1  ) = NewTime;      % Store its corresponding Time
            obj.Count = C + r ;                     % Update counter
            obj.cData = NewData;
        end %function
        
    end
    
end

