classdef signalCore5511a < qes.hwdriver.icinterface_compatible % extends icinterface_compatible, Yulin Wu
	
	properties (Dependent = private)
        numChnls
    end
	properties (SetAccess = private)
        numChnls
		freqlimits
        powerlimits
    end
    properties (SetAccess = private, getAccess = private) % Yulin Wu
		chnlName
    end
	
	properties (GetAccess = private,Constant = true)
        driver  = 'sc5511a'
        driverh = 'sc5511a.h'
    end
    methods
		function val = get.numChnls(obj)
			val = numel(obj.chnlName);
		end
		function setFrequency(obj, f, chnl)
			devicehandle = calllib('sc5511a','sc5511a_open_device',obj.chnlName{chnl}); 
			calllib('sc5511a','sc5511a_set_freq',devicehandle,f);
			calllib('sc5511a','sc5511a_close_device',devicehandle); 
		end
		function f = getFrequency(obj, chnl)
			devicehandle = calllib('sc5511a','sc5511a_open_device',obj.chnlName{chnl}); 
			[~,~,s] = calllib('sc5511a','sc5511a_get_rf_parameters',devicehandle,{});
			f = s.rf1_freq;
			calllib('sc5511a','sc5511a_close_device',devicehandle); 
		end
		function setPower(obj, p, chnl)
			devicehandle = calllib('sc5511a','sc5511a_open_device',obj.chnlName{chnl}); 
			calllib('sc5511a','sc5511a_set_level',devicehandle,p); 
			calllib('sc5511a','sc5511a_close_device',devicehandle); 
		end
		function f = getPower(obj, chnl)
			devicehandle = calllib('sc5511a','sc5511a_open_device',obj.chnlName{chnl}); 
			[~,~,s] = calllib('sc5511a','sc5511a_get_rf_parameters',devicehandle,{});
			f = s.rf_level;
			calllib('sc5511a','sc5511a_close_device',devicehandle); 
		end
		function setOnOff(obj, onoff, chnl)
			devicehandle = calllib('sc5511a','sc5511a_open_device',obj.chnlName{chnl}); 
			calllib('sc5511a','sc5511a_set_output',devicehandle,onoff);
			calllib('sc5511a','sc5511a_close_device',devicehandle); 
		end
		function val = getOnOff(obj, chnl)
			devicehandle = calllib('sc5511a','sc5511a_open_device',obj.chnlName{chnl}); 
			[~,~,s]=calllib('sc5511a','sc5511a_get_device_status',devicehandle,{})
			val = s.operate_status.rf1_out_enable;
			calllib('sc5511a','sc5511a_close_device',devicehandle); 
		end
    end
    methods (Access = private) % Yulin Wu
        function obj = signalCore5511a()
			QS = qes.qSettings.GetInstance();
            s = QS.loadHwSettings('signalCore5511a_bknd');
			obj.chnlName = s.chnlName;
			if(~libisloaded(signalCore5511a.driver))
                driverfilename = [signalCore5511a.driver,'.dll'];
                loadlibrary(driverfilename,signalCore5511a.driverh);
            end
			for ii = 1:numel(obj.chnlName)
				devicehandle = calllib('sc5511a','sc5511a_open_device',obj.chnlName{ii}); 
				calllib('sc5511a','sc5511a_set_clock_reference',devicehandle,0,1);
				calllib('sc5511a','sc5511a_close_device',devicehandle);
			end
			
			obj.freqlimits = ...
				cell2mat(cellfun(@cell2mat,s.freq_limits(:),'UniformOutput',false));
            obj.powerlimits =...
				cell2mat(cellfun(@cell2mat,s.power_limits(:),'UniformOutput',false));
			
			obj.cmdList = {'*IDN?'};
			obj.ansList = {'SIGNALCORE,SC5511A,170410,1.0'};
        end
    end
    
    methods (Static = true)
        function obj = GetInstance() % Yulin Wu
            persistent objlst;
            if isempty(objlst) || ~isvalid(objlst)
                obj = qes.hwdriver.sync.signalCore5511a();
                objlst = obj;
            else
                obj = objlst;
            end
        end
    end
end