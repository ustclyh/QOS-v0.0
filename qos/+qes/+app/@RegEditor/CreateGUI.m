function CreateGUI(obj)
% create gui

% Copyright 2017 Yulin Wu, University of Science and Technology of China
% mail4ywu@gmail.com/mail4ywu@icloud.com


    BkGrndColor = [0.941   0.941   0.941];
    winSize = obj.winSize;
%     obj.guiHandles.reWin = figure('Units','characters','MenuBar','none',...
%         'ToolBar','none','NumberTitle','off','Name','QOS | Registry Editor',...
%         'Resize','off','HandleVisibility','callback','Color',BkGrndColor,...
%         'DockControls','off','Position',winSize,'CloseRequestFcn',@exitFcn);
%     function exitFcn(~,~)
%         obj.delete();
%     end


%     obj.guiHandles.reWin = figure('Units','characters','MenuBar','none',...
%         'ToolBar','none','NumberTitle','off','Name','QOS | Registry Editor',...
%         'Resize','off','HandleVisibility','callback','Color',BkGrndColor,...
%         'DockControls','off','Position',winSize,'Visible','off');
    


obj.guiHandles.reWin = figure('Units','normalized','MenuBar','none',...
        'ToolBar','none','NumberTitle','off','Name','QOS | Registry Editor',...
        'HandleVisibility','callback','Color',BkGrndColor,...
        'DockControls','off','Position',winSize,'Visible','off');


    warning('off');
    jf = get(obj.guiHandles.reWin,'JavaFrame');
    jf.setFigureIcon(javax.swing.ImageIcon(...
        im2java(qes.ui.icons.qos1_32by32())));
    warning('on');
    movegui(obj.guiHandles.reWin,'center');
%     obj.guiHandles.basepanel=uipanel(...
%         'Parent',obj.guiHandles.reWin,...
%         'Units','characters',...
%         'Position',panelpossize,...
%         'backgroundColor',BkGrndColor,...
%         'Title','',...
%         'BorderType','none',...
%         'HandleVisibility','callback',...
%         'visible','on',...
%         'Tag','parameterpanel','DeleteFcn',{@GUIDeleteCallback});

    obj.guiHandles.reWin.Units='pixels';
    mainlayout=uix.Grid('parent',obj.guiHandles.reWin,'padding',2);
    
    leftlayout=uix.Grid('parent',mainlayout);
    rightlayout=uix.Grid('parent',mainlayout,'padding',2);
    mainlayout.Widths=[250 -1];
    
    leftuplayout=uix.Grid('parent',leftlayout);
    leftdownlayout=uix.Grid('parent',leftlayout,'padding',2);
    leftlayout.Heights=[130 -1];
    
    selectlayout=uix.Grid('parent',leftuplayout,'padding',2);
    buttonlayout=uix.Grid('parent',leftuplayout,'padding',2);
    leftuplayout.Heights=[-3 -1];
    
    %selectlayout
    obj.guiHandles.SelectUserTitle = uicontrol('Parent',selectlayout,'Style','text','string','User:',...
        'FontSize',9,'FontUnits','points','HorizontalAlignment','Left','Units','characters');
    obj.guiHandles.SelectHwTitle = uicontrol('Parent',selectlayout,'Style','text','string','Hardware:',...
        'FontSize',9,'FontUnits','points','HorizontalAlignment','Left','Units','characters');
    obj.guiHandles.SelectSessionTitle = uicontrol('Parent',selectlayout,'Style','text','string','Session:',...
        'FontSize',9,'FontUnits','points','HorizontalAlignment','Left','Units','characters');
    %
    obj.guiHandles.SelectUser = uicontrol('Parent',selectlayout,'Style','popupmenu','String',obj.userList,...
        'value',1,'FontSize',9,'FontUnits','points','HorizontalAlignment','Left',...
        'ForegroundColor',[0.5,0.5,1],'BackgroundColor',[0.9,1,0.8],'Units','characters','Callback',{@SelectUserCallback},...
        'Tooltip','Select user');
    if ~isempty(obj.qs.user)
        obj.userList = obj.userList(2:end);
        set(obj.guiHandles.SelectUser,'String',obj.userList);
        idx = qes.util.find(obj.qs.user, obj.userList);
        if isempty(idx) || numel(idx) > 1
            error('BUG! this should not happen!');
        end
        set(obj.guiHandles.SelectUser,'Value',idx);
    end
    obj.guiHandles.SelectSession = uicontrol('Parent',selectlayout,'Style','popupmenu','string','_Not Set_',...
        'value',1,'FontSize',9,'FontUnits','points','HorizontalAlignment','Left',...
        'ForegroundColor',[0.5,0.5,1],'BackgroundColor',[0.9,1,0.8],'Units','characters','Callback',{@SelectSessionCallback},...
        'Tooltip','Select session.','Enable','off');
    obj.guiHandles.SelectHw = uicontrol('Parent',selectlayout,'Style','popupmenu','string','_Not Set_',...
        'value',1,'FontSize',9,'FontUnits','points','HorizontalAlignment','Left',...
        'ForegroundColor',[0.5,0.5,1],'BackgroundColor',[0.9,1,0.8],'Units','characters','Callback',{@SelectHwCallback},...
        'Tooltip','Select hardware group.','Enable','on');
    %
    obj.guiHandles.copyUser = uicontrol('Parent',selectlayout,'Style','pushbutton','string','C',...
        'FontSize',10,'FontUnits','points',...
        'Units','characters','Callback',{@CopyCallback,1},...
        'Tooltip','copy current user settings group.');
    obj.guiHandles.copySession = uicontrol('Parent',selectlayout,'Style','pushbutton','string','C',...
        'FontSize',10,'FontUnits','points',...
        'Units','characters','Callback',{@CopyCallback,2},...
        'Tooltip','copy current session.');
    obj.guiHandles.copyHwSettings = uicontrol('Parent',selectlayout,'Style','pushbutton','string','C',...
        'FontSize',10,'FontUnits','points',...
        'Units','characters','Callback',{@CopyCallback,3},...
        'Tooltip','copy current hardware settings group.');
    %
    obj.guiHandles.deleteUser = uicontrol('Parent',selectlayout,'Style','pushbutton','string','X',...
        'FontSize',10,'FontUnits','points','ForegroundColor',[1,0,0],...
        'Units','characters','Callback',{@deleteCallback,1},...
        'Tooltip','delete current user settings group.');
    obj.guiHandles.deleteSession = uicontrol('Parent',selectlayout,'Style','pushbutton','string','X',...
        'FontSize',10,'FontUnits','points','ForegroundColor',[1,0,0],...
        'Units','characters','Callback',{@deleteCallback,2},...
        'Tooltip','delete current session.');
    obj.guiHandles.deleteHwSettings = uicontrol('Parent',selectlayout,'Style','pushbutton','string','X',...
        'FontSize',10,'FontUnits','points','ForegroundColor',[1,0,0],...
        'Units','characters','Callback',{@deleteCallback,3},...
        'Tooltip','delete current hardware settings group.');
    %
    selectlayout.Widths=[60 -1 20 20];
    selectlayout.Heights=[-1 -1 -1];
    
    
    %buttonlayout
    obj.guiHandles.iniBtn = uicontrol('Parent',buttonlayout,'Style','pushbutton','string','Initialize',...
        'FontSize',10,'FontUnits','points',...
        'Units','characters','Callback',{@InitializeCallback},...
        'Tooltip','Create hardware objects.','Enable','off');
    
    obj.guiHandles.loadBtn = uicontrol('Parent',buttonlayout,'Style','pushbutton','string','Load',...
        'FontSize',10,'FontUnits','points',...
        'Units','characters','Callback',{@LoadSettingsCallback},...
        'Tooltip','Load previous setting.','Enable','on');
    
    %rightlayout
    ColumnWidth = {130,130,500};
    obj.guiHandles.regTable = uitable('Parent',rightlayout,...
         'Data',[],...
         'ColumnName',{'Key','Value','Annotation'},...
         'ColumnFormat',{'char','char'},...
         'ColumnEditable',[false,true,false],...
         'ColumnWidth',ColumnWidth,...
         'RowName',[],...
         'CellEditCallback',@saveValue,...
         'Units','characters');
     
     %leftdownlayout
     obj.treecontainer=uicontainer('Parent',leftdownlayout,'Units','normalized');
     
    if ~isempty(obj.sessionList)
        set(obj.guiHandles.SelectSession,'String',obj.sessionList,'Enable','on');
        if ~isempty(obj.qs.session)
            obj.sessionList = obj.sessionList(2:end);
            set(obj.guiHandles.SelectSession,'String',obj.sessionList);
            idx = qes.util.find(obj.qs.session,obj.sessionList);
            if isempty(idx) || numel(idx) > 1
                throw(MException('QOS_RegEditor:CorruptedDatabase',...
                    sprintf('database corrupted, selected session: %s points is an non existent session.',obj.qs.session)));
            end
            set(obj.guiHandles.SelectSession,'Value',idx,'Enable','on');
        end
    end
    
    if ~isempty(obj.hwList)
        set(obj.guiHandles.SelectHw,'String',obj.hwList);
        if ~isempty(obj.qs.hardware)
            obj.hwList = obj.hwList(2:end);
            set(obj.guiHandles.SelectHw,'String',obj.hwList);
            idx = qes.util.find(obj.qs.hardware,obj.hwList);
            if isempty(idx) || numel(idx) > 1
                throw(MException('QOS_RegEditor:CorruptedDatabase',...
                    sprintf('database corrupted, selected hardware group: %s points is an non existent hardware group.', obj.qs.hardware)));
            end
            set(obj.guiHandles.SelectHw,'Value',idx);
            set(obj.guiHandles.iniBtn,'Enable','on');
        end
    end

    if ~isempty(obj.qs.user) && ~isempty(obj.qs.session) &&...
            ~isempty(obj.qs.hardware)
    	obj.createUITree();
    end
    
    initUdp();
    obj.guiHandles.reWin.DeleteFcn = @WindowCloseCallBack;
%     
%     fpos = get(obj.guiHandles.reWin,'Position');
%     set(obj.guiHandles.reWin,'Position',fpos+1);
%     set(obj.guiHandles.reWin,'Position',fpos);
%     drawnow;
%     
    obj.tblRefreshTmr = timer('BusyMode','drop','ExecutionMode','fixedSpacing',...
            'ObjectVisibility','off','Period',obj.tblRefreshPeriond,...
            'TimerFcn',{@refreshTableData});
    % start(obj.tblRefreshTmr);
    
    function refreshTableData(~,~)
        if ~isvalid(obj.guiHandles.regTable) || isempty(obj.nodeName) || isempty(obj.nodeParent)
            return;
        end
        set(obj.guiHandles.regTable,'Data',obj.TableData(obj.nodeName,obj.nodeParent));
    end
    
    function saveValue(src,entdata)
        if strcmp(entdata.PreviousData,entdata.EditData)
            return;
        end
        tdata = get(src,'Data');
        name = tdata{entdata.Indices(1),1};
        try
            switch obj.nodeParent
                case 'session settings'
                    obj.qs.saveSSettings({obj.nodeName, name},entdata.EditData);
                case 'hardware settings'
                    obj.qs.saveHwSettings({obj.nodeName, name},entdata.EditData);
            end
        catch ME
            set(obj.guiHandles.regTable,'Data',obj.TableData(obj.nodeName,obj.nodeParent));
            qes.ui.msgbox(getReport(ME,'extended','hyperlinks','off'),'Saving failed.');
        end
    end

    function SelectUserCallback(src,ent)
        if get(src,'Value') == 1 && isempty(obj.qs.user)
            return;
        end
        user = obj.userList{get(src,'Value')};
        if strcmp(user,obj.qs.user)
            return;
        end
        if strcmp(obj.userList{1},'_Not set_')
            obj.userList(1) = [];
            set(src,'Value',get(src,'Value')-1,...
                'String',obj.userList);
        end
        obj.qs.user = user;
        if isfield(obj.guiHandles,'mtree') && ishghandle(obj.guiHandles.mtree)
            delete(obj.guiHandles.mtree);
        end
        set(obj.guiHandles.regTable,'Data',[]);
        obj.sessionList = [];
        set(obj.guiHandles.SelectSession,'Value',1,'String',{'_Not set_'},'Enable','off');
        set(obj.guiHandles.iniBtn,'Enable','off');
        fInfo = dir(fullfile(obj.qs.root,obj.qs.user));
        sessionList_ = {'_Not set_'};
        for ii = 1:numel(fInfo)
            if fInfo(ii).isdir &&...
                    ~ismember(fInfo(ii).name,{'.','..'}) &&...
                    ~qes.util.startsWith(fInfo(ii).name,'_')
                sessionList_ = [sessionList_,{fInfo(ii).name}];
            end
        end
        obj.sessionList = sessionList_;
        if ~isempty(obj.qs.session)
            obj.sessionList = obj.sessionList(2:end);
            set(obj.guiHandles.SelectSession,'String',obj.sessionList);
            idx = qes.util.find(obj.qs.session,obj.sessionList);
            if isempty(idx) || numel(idx) > 1
                error('BUG! this should not happen!');
            end
            set(obj.guiHandles.SelectSession,'Value',idx,'Enable','on');
            set(obj.guiHandles.iniBtn,'Enable','on','String','Initialize');
            obj.createUITree();
        end
    end
    function SelectSessionCallback(src,ent)
        if get(src,'Value') == 1 && isempty(obj.qs.session)
            return;
        end
        session = obj.sessionList{get(src,'Value')};
        if strcmp(session,obj.qs.session)
            return;
        end
        if strcmp(obj.sessionList{1},'_Not set_')
            obj.sessionList(1) = [];
            set(src,'Value',get(src,'Value')-1,...
                'String',obj.sessionList);
        end
        obj.qs.SS(session);
        if isfield(obj.guiHandles,'mtree') && ishghandle(obj.guiHandles.mtree)
            delete(obj.guiHandles.mtree);
        end
        set(obj.guiHandles.regTable,'Data',[]);
        obj.createUITree();
    end
    function SelectHwCallback(src,ent)
        if get(src,'Value') == 1 && isempty(obj.qs.hardware)
            return;
        end
        hw = obj.hwList{get(src,'Value')};
        if strcmp(hw,obj.qs.hardware)
            return;
        end
        if strcmp(obj.hwList{1},'_Not set_')
            obj.hwList(1) = [];
            set(src,'Value',get(src,'Value')-1,...
                'String',obj.hwList);
        end
        obj.qs.SHW(hw);
        if isfield(obj.guiHandles,'mtree') && ishghandle(obj.guiHandles.mtree)
            delete(obj.guiHandles.mtree);
        end
        set(obj.guiHandles.regTable,'Data',[]);
        obj.createUITree();
        set(obj.guiHandles.iniBtn,'Enable','on','String','Initialize');
    end
    function InitializeCallback(src,ent)
        set(src,'Enable','off','String','Initializing...');
        drawnow;
        try
            obj.qs.CreateHw();
        catch ME
            qes.ui.msgbox(getReport(ME,'extended','hyperlinks','off'));
        end
        set(src,'String','Initialization Done');
    end

    function WindowCloseCallBack(src, ent)
        deleteUdpHandle();
    end
    function initUdp()
        obj.udpHandle = udp('127.0.0.1','LocalPort', 4000); 
        obj.udpHandle.InputBufferSize = 1024; 
        obj.udpHandle.ByteOrder = 'littleEndian'; 
        set(obj.udpHandle,'DatagramTerminateMode','off'); 
        obj.udpHandle.ReadAsyncMode = 'continuous';
        obj.udpHandle.DatagramReceivedFcn = @UdpDataReceiveCallBack;
        obj.udpHandle.EnablePortSharing = 'on';
        try
            fopen(obj.udpHandle);
        catch
            warning('Qos_RegEditor:UdpHandle: %s\n', 'Unable to open port 4000 at 127.0.0.1');
        end
    end
    function deleteUdpHandle()
        fclose(obj.udpHandle);
        delete(obj.udpHandle);
    end
    function UdpDataReceiveCallBack(udpHandle, event)
        data = fread(udpHandle, udpHandle.BytesAvailable);
        dataStr = sprintf('%s', char(data));
        [pathName, fileName, ext] = fileparts(dataStr);
        if strcmp(ext, '.mat')
            fileName = [fileName, ext];
            % fprintf('%s\n', pathName);
            % fprintf('%s\n', fileName);
            fullPath = fullfile(pathName, fileName);
            if exist(fullPath, 'file')
                question = sprintf('Load setting from file: %s?', fullPath);
                button = questdlg(question, 'QOS | Registry Editor | Load Setting');
                if strcmp(button, 'Yes')
                    if isempty(obj.qs.user)
                        qes.ui.msgbox('Select a user before loading settings');
                        return;
                    end
                    LoadSetting(pathName, fileName);
                end
            end
        end
    end
    function LoadSettingsCallback(src, ent)
        if isempty(obj.qs.user)
            qes.ui.msgbox('Select a user before loading settings');
            return;
        end
        [fileName, pathName] = uigetfile('*.mat', 'QOS | Registry Editor | Pick a file'); % fileName is 0 if the dialog is cancelled.
        LoadSetting(pathName, fileName);
    end
    function LoadSetting(pathName, fileName)
        fullPathName = fullfile(pathName, fileName);
        pyJson = py.importlib.import_module('json');
        settingCategory = {'hw_settings', 'session_settings'};
        prefix = {'hw_', 's_'};
        try
            if fileName ~= 0
                data = load(fullPathName);
                config = [];
                dataFields = fieldnames(data);
                for ii = 1 : numel(dataFields)
                    if regexpi(dataFields{ii}, 'hw_?settings')
                        config.hw_settings = data.(dataFields{ii});
                    elseif regexpi(dataFields{ii}, 'session_?settings')
                        config.session_settings = data.(dataFields{ii});
                    end
                end
                if isfield(data, 'Config')
                    config = data.Config;
                end
                if ~isempty(config)
                    if ~isfield(config, 'hw_settings') || ~isfield(config, 'session_settings')
                        % qes.ui.msgbox('Neither hardware settings nor session settings are found.');
                        throw(MException('Qos_RegEditor:MissingField', 'Neither hardware settings nor session settings are found.'));
                    else
                        tag = regexprep(fileName(1:end-4), '(\[|\])', '_');
                        for settingIdx = 1 : numel(settingCategory)
                            category = settingCategory{settingIdx};
                            if isfield(config, category)
                                loadedSetting = config.(category);
                                name = [prefix{settingIdx}, tag];
                                if settingIdx == 1
                                    categoryPath = fullfile(obj.qs.root, 'hardware');
                                else
                                    categoryPath = fullfile(obj.qs.root, obj.qs.user);
                                end
                                if isempty(loadedSetting)
                                    warning('%s of %s is empty\n', category, fullPathName);
                                    continue;
                                end
                                if settingIdx == 2
                                    if ~isfield(loadedSetting, 'selected')
                                        loadedSetting.selected = fieldnames(loadedSetting);
                                    end
                                    if ~isfield(loadedSetting, 'data_path') || ...
                                      (isfield(loadedSetting, 'data_path') && ~exist(loadedSetting.data_path, 'dir'))
                                        dataPath = uigetdir('.', 'QOS | Registry Editor | Select data file path.');
                                        if dataPath ~= 0
                                            loadedSetting.data_path = dataPath;
                                        else
                                            throw(MException('Qos_RegEditor:InvalidDataPath', 'No valid data path.'));
                                        end
                                    end
                                end
                                if ~isfield(loadedSetting, 'selected')
                                    % config.hw_settings.selected = {};
                                    % fprintf('%s\n', category);
                                    throw(MException('Qos_RegEditor:MissingField', 'No selected keys are found.'));
                                end
                                if ~exist(categoryPath, 'dir')
                                    mkdir(categoryPath);
                                end
                                loadedSettingPath = fullfile(categoryPath, name);
                                if ~exist(loadedSettingPath, 'dir')
                                    mkdir(loadedSettingPath);
                                end
                                loadedField = fieldnames(loadedSetting);
                                for ii = 1 : length(loadedField)
                                    entry = loadedSetting.(loadedField{ii});
                                    entryPath = fullfile(loadedSettingPath, loadedField{ii});
                                    if isstruct(entry)
                                        entryField = fieldnames(entry);
                                        if ~exist(entryPath, 'dir')
                                            mkdir(entryPath);
                                        else
                                            delete(fullfile(entryPath, '*.key'));
                                        end
                                        for k = 1 : length(entryField)
                                            fieldName = entryField{k};
                                            if strcmp(fieldName, 'SETTINGS_PATH_')
                                                continue;
                                            end
                                            fieldValue = entry.(fieldName);
                                            isJson = false;
                                            switch class(fieldValue)
                                                case 'double'
                                                    fieldString = arrayfun(@qes.util.num2strCompact, fieldValue, 'UniformOutput', 0);
                                                    line = sprintf('%s,', fieldString{:});
                                                    fileName = fullfile(entryPath, [fieldName, '=', line(1:end-1), '.key']);
                                                case 'char'
                                                    fileName = fullfile(entryPath, [fieldName, '@', fieldValue, '.key']);
                                                case 'logical'
                                                    if fieldValue
                                                        value = 'true';
                                                    else
                                                        value = 'false';
                                                    end
                                                    fileName = fullfile(entryPath, [fieldName, '=', value, '.key']);
                                                case {'struct', 'cell'}
                                                    if iscell(fieldValue)
                                                        s = struct();
                                                        s.(fieldName) = fieldValue;
                                                    else
                                                        s = fieldValue;
                                                    end
                                                    fileName = fullfile(entryPath, [fieldName, '.key']);
                                                    jsonStr = jsonencode(s);
                                                    args = pyargs('obj', pyJson.loads(jsonStr), 'indent', int32(4));
                                                    prettyJson = pyJson.dumps(args);
                                                    fp = fopen(fileName, 'w');
                                                    fwrite(fp, char(prettyJson));
                                                    fclose(fp);
                                                    isJson = true;
                                                otherwise
                                                    fprintf('%s\n', class(fieldValue));
                                                    fileName = fullfile(entryPath, [fieldName, '.key']);
                                            end
                                            if ~isJson
                                                try
                                                    fclose(fopen(fileName, 'w'));
                                                catch
                                                    fprintf('fail: %s\n', fileName);
                                                end
                                            end
                                            % fprintf('%s, %s\n', fileName, class(fieldValue));
                                        end
                                    else
                                        fileName = fullfile(loadedSettingPath, [loadedField{ii}, '.key']);
                                        % fprintf('%s\n', fileName);
                                        fp = fopen(fileName, 'w');
                                        s = struct();
                                        s.(loadedField{ii}) = entry;
                                        jsonStr = jsonencode(s);
                                        args = pyargs('obj', pyJson.loads(jsonStr), 'indent', int32(4));
                                        prettyJson = pyJson.dumps(args);
                                        fwrite(fp, char(prettyJson));
                                        fclose(fp);
                                    end
                                end
                                if settingIdx == 1
                                    categoryName = 'hwList';
                                    categoryObj = obj.guiHandles.SelectHw;
                                else
                                    categoryName = 'sessionList';
                                    categoryObj = obj.guiHandles.SelectSession;
                                end
                                if ~ismember(obj.(categoryName), name)
                                    obj.(categoryName){end+1} = name;
                                    set(categoryObj,'String', obj.(categoryName));
                                    set(categoryObj, 'Value', length(obj.(categoryName)));
                                else
                                    pos = find(ismember(obj.(categoryName), name));
                                    set(categoryObj, 'Value', pos);
                                end
                                if settingIdx == 1
                                    obj.qs.SHW(name);
                                    if strcmp(get(obj.guiHandles.iniBtn,'Enable'), 'off')
                                        set(obj.guiHandles.iniBtn,'Enable','on','String','Initialize');
                                    end
                                else
                                    obj.qs.SS(name);
                                end
                                if isfield(obj.guiHandles,'mtree') && ishghandle(obj.guiHandles.mtree)
                                    delete(obj.guiHandles.mtree);
                                end
                                set(obj.guiHandles.regTable,'Data',[]);
                                obj.createUITree();
                            end
                        end
                    end
                else
                    throw(MException('Qos_RegEditor:MissingField', 'Config field or setting fields are not found.'));
                end
            end
        catch ME
            qes.ui.msgbox(getReport(ME,'extended','hyperlinks','off'));
        end
    end
    function deleteCallback(src,ent,typ)
        % todo...
    end
    function copyCallback(src,ent,typ)
        % todo...
    end

    if obj.qs.hwCreated
		set(obj.guiHandles.iniBtn,'String','Initialization Done','Enable','off');
    end
    
    set(obj.guiHandles.reWin,'Visible','on');
end