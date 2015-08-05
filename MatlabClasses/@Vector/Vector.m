classdef Vector < handle
    % Done By : Bara Emran
    % Date    : 5th Aug 2015
    % Version : 0.2
    % Vector Class
    % Ex: V = Vector('cols' , 1 ,'rows',10);
    
    properties
        Data  = [];     % Stored Data
        Time  = [];     % Corresponding Time
        Count = [];     % Counter
        Rows  = [];     % Number of Rows
        Cols  = [];     % Number of Cols
        cData = [];     % Current Data
    end
    
    methods
        function obj = Vector(varargin)
            % Initilaizing default values;
            Rows_ = 1;
            Cols_ = 1;
            
            % Read values for given options
            for i = 1:nargin
                if strcmpi('Cols',varargin{i})
                    Cols_ = varargin{i+1};

                elseif strcmpi('Rows',varargin{i})
                    Rows_ = varargin{i+1};
                end %if
            end %for
            
            % Assign values in the object
            set_Rows(obj,Rows_);
            set_Cols(obj,Cols_);
            obj.Data    = zeros(obj.Rows,obj.Cols);
            obj.cData   = obj.Data(1,:);
            obj.Time    = zeros(obj.Rows,1);
            obj.Count   = 0;
            
        end %function
        
        function set_Cols (obj,c)
            if isnumeric(c)
                obj.Cols = floor(c);
            else
                error('Error. \nCols input must be a numeric, not a %s.',class(c))
            end
        end
         
        function set_Rows (obj,r)
            if isnumeric(r)
                obj.Rows = floor(r);
            else
                error('Error. \nRows input must be a numeric, not a %s.',class(r))
            end
        end
        
        function PushSingle(obj,NewD,NewT)
                c = obj.Count + 1;           % Find current counter
                obj.Data(c, : ) = NewD;      % Store the new Data
                obj.Time(c    ) = NewT;      % Store its corresponding Time
                obj.Count = c ;              % Update counter
        end %function
        
        function Push(obj,NewData,NewTime)
            [r,c] = size(NewData);                      % Size of the NewData
            if(c == obj.Cols)
                %count = [];
                count = obj.Count;                          % Find current counter
                obj.Data(count+1:count+r, : ) = NewData;   % Store the new Data
                obj.Time(count+1:count+r, 1 ) = NewTime;   % Store its corresponding Time
                obj.Count = count + r ;                     % Update counter
                obj.cData = NewData;
            else
                error('Error. \nPushed Data must have %d number of cols, not %d.',Obj.Cols,c)               
            end
        end %function
        
    end
    
end

