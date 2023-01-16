function varargout = evofftGUI(varargin)
% evofftGUI MATLAB code for evofftGUI.fig
%      evofftGUI, by itself, creates a new evofftGUI or raises the existing
%      singleton*.
%
%      H = evofftGUI returns the handle to a new evofftGUI or the handle to
%      the existing singleton*.
%
%      evofftGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in evofftGUI.M with the given input arguments.
%
%      evofftGUI('Property','Value',...) creates a new evofftGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before evofftGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to evofftGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help evofftGUI

% Last Modified by GUIDE v2.5 29-May-2021 22:36:49

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @evofftGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @evofftGUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before evofftGUI is made visible.
function evofftGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to evofftGUI (see VARARGIN)
set(0,'Units','normalized') % set units as normalized
set(gcf,'units','norm') % set location
h=get(gcf,'Children');  % get all content
h1=findobj(h,'FontUnits','norm');  % find all font units as points
set(h1,'FontUnits','points','FontSize',11.5);  % set as norm
h2=findobj(h,'FontUnits','points');  % find all font units as points
set(h2,'FontUnits','points','FontSize',11.5);  % set as norm
handles.MonZoom = varargin{1}.MonZoom;
handles.sortdata = varargin{1}.sortdata;
handles.val1 = varargin{1}.val1;
% language
lang_choice = varargin{1}.lang_choice;
handles.lang_choice = lang_choice;
lang_id = varargin{1}.lang_id;
lang_var = varargin{1}.lang_var;
handles.lang_id = lang_id;
handles.lang_var = lang_var;
handles.main_unit_selection = varargin{1}.main_unit_selection;


if handles.lang_choice == 0
    set(gcf,'Name','Acycle: Evolutionary Spectral Analysis')
else
    [~, menu108] = ismember('menu108',lang_id);
    set(gcf,'Name',['Acycle: ',lang_var{menu108}])
end
% language
if handles.lang_choice > 0
    [~, main49] = ismember('main49',handles.lang_id);
    set(handles.text5,'String',lang_var{main49})
    
    [~, evofft01] = ismember('evofft01',handles.lang_id);
    set(handles.uipanel1,'Title',lang_var{evofft01})
    
    [~, evofft02] = ismember('evofft02',handles.lang_id);
    set(handles.uipanel2,'Title',lang_var{evofft02})
    
    [~, evofft03] = ismember('evofft03',handles.lang_id);
    set(handles.text6,'String',lang_var{evofft03})
    
    [~, evofft04] = ismember('evofft04',handles.lang_id);
    set(handles.evofft_Nyquist_radiobutton,'String',lang_var{evofft04})
    
    [~, spectral14] = ismember('spectral14',handles.lang_id);
    set(handles.radiobutton2,'String',lang_var{spectral14})
    
    [~, main32] = ismember('main32',handles.lang_id);
    set(handles.uipanel5,'Title',lang_var{main32})
    
    [~, main33] = ismember('main33',handles.lang_id);
    set(handles.pushbutton8,'String',lang_var{main33})
    set(handles.evofft_tips_win_pushbutton,'String',lang_var{main33})
    
    [~, main34] = ismember('main34',handles.lang_id);
    set(handles.text7,'String',lang_var{main34})
    
    [~, main07] = ismember('main07',handles.lang_id);
    set(handles.uipanel3,'Title',lang_var{main07})
    
    [~, evofft05] = ismember('evofft05',handles.lang_id);
    set(handles.checkbox8,'String',lang_var{evofft05})
    
    [~, evofft06] = ismember('evofft06',handles.lang_id);
    set(handles.checkbox7,'String',lang_var{evofft06})
    
    [~, evofft07] = ismember('evofft07',handles.lang_id);
    set(handles.uipanel6,'Title',lang_var{evofft07})
    
    [~, evofft08] = ismember('evofft08',handles.lang_id);
    set(handles.rotation,'String',lang_var{evofft08})
    
    [~, evofft09] = ismember('evofft09',handles.lang_id);
    set(handles.checkbox2,'String',lang_var{evofft09})
    
    [~, main10] = ismember('main10',handles.lang_id);
    set(handles.checkbox3,'String',lang_var{main10})
    
    [~, evofft10] = ismember('evofft10',handles.lang_id);
    set(handles.checkbox4,'String',lang_var{evofft10})
    
    [~, evofft11] = ismember('evofft11',handles.lang_id);
    set(handles.checkbox5,'String',lang_var{evofft11})
        
    [~, main43] = ismember('main43',handles.lang_id);
    set(handles.checkbox6,'String',['x ',lang_var{main43}])
    
    [~, main50] = ismember('main50',handles.lang_id);
    set(handles.uipanel10,'Title',lang_var{main50})
    
    [~, evofft12] = ismember('evofft12',handles.lang_id);
    set(handles.text8,'String',lang_var{evofft12})
    
    [~, main01] = ismember('main01',handles.lang_id);
    set(handles.checkbox9,'String',lang_var{main01})
    
    [~, main00] = ismember('main00',handles.lang_id);
    set(handles.evofft_ok_pushbutton,'String',lang_var{main00})
end


if ismac
    set(gcf,'position',[0.45,0.4,0.4,0.35]* handles.MonZoom) % set position
elseif ispc
    set(gcf,'position',[0.45,0.4,0.4,0.35]* handles.MonZoom) % set position
end
set(handles.text5,'position',[0.018,0.856,0.2,0.06])
set(handles.popupmenu2,'position',[0.26,0.856,0.68,0.06])
set(handles.uipanel1,'position',[0.034,0.037,0.906,0.793])
set(handles.uipanel2,'position',[0.029,0.553,0.454,0.42])
set(handles.uipanel5,'position',[0.496,0.559,0.239,0.419])
set(handles.uipanel3,'position',[0.738,0.559,0.257,0.419])

set(handles.checkbox2,'position',[0.293,0.45,0.36,0.1])
set(handles.checkbox3,'position',[0.293,0.35,0.36,0.1])
set(handles.checkbox5,'position',[0.293,0.25,0.36,0.1])
set(handles.checkbox4,'position',[0.293,0.15,0.36,0.1])
set(handles.checkbox6,'position',[0.293,0.05,0.2,0.1])
set(handles.checkbox7,'position',[0.029,0.35,0.25,0.08])
set(handles.checkbox7,'Value',0)
set(handles.checkbox8,'position',[0.029,0.45,0.25,0.08])
set(handles.checkbox8,'Value',1)
set(handles.popupmenu4,'position',[0.46,0.03,0.18,0.11])

set(handles.uipanel6,'position',[0.029,0.05,0.251,0.28])
set(handles.uipanel10,'position',[0.637,0.08,0.251,0.42])
set(handles.popupmenu3,'position',[0.02,0.5,0.95,0.36])
set(handles.text8,'position',[0.0637,0.22,0.371,0.173])
set(handles.edit9,'position',[0.412,0.2,0.4,0.25])
set(handles.checkbox9,'position',[0.888,0.4,0.11,0.08])
set(handles.evofft_ok_pushbutton,'position',[0.888,0.08,0.11,0.22])
set(handles.text6,'position',[0.138,0.714,0.316,0.238])
set(handles.edit7,'position',[0.651,0.698,0.309,0.27])
set(handles.evofft_Nyquist_radiobutton,'position',[0.111,0.381,0.687,0.365])
set(handles.evofft_nyquist_text,'position',[0.629,0.397,0.281,0.223])
set(handles.radiobutton2,'position',[0.111,0.1,0.549,0.388])
set(handles.evofft_fmax_edit,'position',[0.645,0.127,0.309,0.27])
set(handles.edit_step,'position',[0.103,0.54,0.4,0.38])
set(handles.pushbutton8,'position',[0.538,0.556,0.41,0.349])
set(handles.edit8,'position',[0.103,0.143,0.397,0.381])
set(handles.text7,'position',[0.577,0.206,0.346,0.206])
set(handles.evofft_win_text,'position',[0.131,0.55,0.738,0.375])
set(handles.evofft_tips_win_pushbutton,'position',[0.095,0.075,0.774,0.35])
set(handles.radiobutton_2d,'position',[0.048,0.524,0.56,0.365])
set(handles.radiobutton_3d,'position',[0.512,0.524,0.476,0.365])
set(handles.rotation,'position',[0.06,0.127,0.881,0.365])

% Choose default command line output for evofftGUI
handles.output = hObject;

data_s = varargin{1}.current_data;
handles.unit = varargin{1}.unit;
handles.unit_type = varargin{1}.unit_type;
handles.current_data = data_s;
handles.data_name = varargin{1}.data_name;
handles.path_temp = varargin{1}.path_temp;
handles.listbox_acmain = varargin{1}.listbox_acmain; % save path
handles.edit_acfigmain_dir = varargin{1}.edit_acfigmain_dir;
[dat_dir,handles.filename,exten] = fileparts(handles.data_name);

handles.plot_2d = 1;
handles.plot_log = 0;
handles.freq_log = 0;
handles.normal = 1;
handles.flipy = 1;
handles.color = 'parula'; % default
handles.colorgrid = [];

xmin = min(data_s(:,1));
xmax = max(data_s(:,1));
mean1 = median(diff(data_s(:,1)));
handles.mean = mean1;
handles.step = handles.mean;
handles.nyquist = 1/(2*handles.mean);     % prepare nyquist
handles.window = 0.2*(xmax-xmin);
handles.rotate = 0;
handles.method = 'Fast Fourier transform (LAH)';
handles.lenthx = xmax-xmin;
handles.time_0pad = 1;
handles.padtype = 1;
% if number of calculations is larger than 500;
% then, a large step is recommended. This way, the ncal is ~500.
ncal = (xmax-xmin - handles.window)/mean1;
if ncal > 500
    handles.step = abs(xmax - xmin - handles.window)/500;
end
%
set(handles.evofft_nyquist_text, 'String', num2str(handles.nyquist));
set(handles.evofft_fmax_edit, 'String', num2str(handles.nyquist));
set(handles.evofft_win_text, 'String', num2str(handles.window));
set(handles.edit7, 'String', '0');
set(handles.edit8, 'String', handles.unit);
set(handles.edit_step, 'String', num2str(handles.step),'Value',1);
set(handles.evofft_Nyquist_radiobutton, 'Value',0,'Enable','Off');
set(handles.radiobutton2, 'Value',1,'Enable','Off');
set(handles.popupmenu2, 'Value',1);
set(handles.evofft_Nyquist_radiobutton, 'Value',1);
set(handles.radiobutton_2d, 'Value',1);
set(handles.radiobutton_3d, 'Value',0);
set(handles.rotation, 'Value',0);
set(handles.checkbox2, 'Value',1);
set(handles.checkbox3, 'Value',1);
set(handles.checkbox4, 'Value',0);
set(handles.checkbox5, 'Value',0);
set(handles.checkbox6, 'Value',1);
set(handles.popupmenu3, 'Value',1);
set(handles.edit9, 'String', '');
set(handles.checkbox9, 'Value',0);


diffx = diff(data_s(:,1));
if max(diffx) - min(diffx) > 10*eps('single')
    
    if handles.lang_choice == 0
        hwarn = warndlg('Not equally spaced data. Interpolated using mean sampling rate!');
    else
        [~, evofft14] = ismember('evofft14',handles.lang_id);
        hwarn = warndlg(lang_var{evofft14});
    end
    interpolate_rate = mean(diffx);
    handles.current_data = interpolate(data_s,interpolate_rate);
    %set(0,'Units','normalized') % set units as normalized
    set(gcf,'units','norm') % set location
    set(gcf,'position',[0.15,0.6,0.15,0.08]* handles.MonZoom)
    figure(hwarn);
end
% Update handles structure
guidata(hObject, handles);
% UIWAIT makes evofftGUI wait for user response (see UIRESUME)
% uiwait(handles.evofftGUI_figure);


% --- Outputs from this function are returned to the command line.
function varargout = evofftGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
handles.output = 0;
varargout{1} = handles.output;

guidata(hObject, handles);

% --------------------------------------------------------------------
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to menuFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.normal = get(handles.checkbox2,'Value');
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function checkbox2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --------------------------------------------------------------------
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to menuFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.flipy = (get(hObject,'Value'));

MTMred = get(handles.checkbox7,'Value');
plotseries = get(handles.checkbox8,'Value');

try figure(handles.evofftfig)
    
    if and(MTMred == 1, plotseries == 1)
        subplot(4,4,[5 9 13])
        if handles.flipy == 1;
            set(gca,'Ydir','reverse')
        else
            set(gca,'Ydir','normal')
        end
        subplot(4,4,[6,7,8,10,11,12,14,15,16])
        if handles.flipy == 1;
            set(gca,'Ydir','reverse')
        else
            set(gca,'Ydir','normal')
        end
        
    elseif and(MTMred == 1, plotseries == 0)
        subplot(4,1,[2 3 4])
        if handles.flipy == 1;
            set(gca,'Ydir','reverse')
        else
            set(gca,'Ydir','normal')
        end
    elseif and(MTMred == 0, plotseries == 1)
        subplot(1,4,1)
        if handles.flipy == 1;
            set(gca,'Ydir','reverse')
        else
            set(gca,'Ydir','normal')
        end
        subplot(1,4,[2 3 4])
        if handles.flipy == 1;
            set(gca,'Ydir','reverse')
        else
            set(gca,'Ydir','normal')
        end
    else
        if handles.flipy == 1;
            set(gca,'Ydir','reverse')
        else
            set(gca,'Ydir','normal')
        end
    end
    
catch
end
guidata(hObject, handles);

% --------------------------------------------------------------------
function checkbox4_Callback(hObject, eventdata, handles)
% hObject    handle to menuFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.plot_log = (get(hObject,'Value'));
guidata(hObject, handles);

% --------------------------------------------------------------------
function checkbox5_Callback(hObject, eventdata, handles)
% hObject    handle to menuFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.freq_log = (get(hObject,'Value'));
try
    set(handles.edit7,'String',num2str(handles.fmingrid))
    fmin = handles.fmingrid;
catch
end
MTMred = get(handles.checkbox7,'Value');
plotseries = get(handles.checkbox8,'Value');

try figure(handles.evofftfig)
    fmax = str2double(get(handles.evofft_fmax_edit,'String'));
    if and(MTMred == 1, plotseries == 1)
        subplot(4,4,[2 3 4])
        xlim([fmin fmax])
        if handles.freq_log == 1;
            set(gca, 'XScale', 'log')
        else
            set(gca, 'XScale', 'linear')
        end
        subplot(4,4,[6,7,8,10,11,12,14,15,16])
        xlim([fmin fmax])
        if handles.freq_log == 1;
            set(gca, 'XScale', 'log')
        else
            set(gca, 'XScale', 'linear')
        end
        
    elseif and(MTMred == 1, plotseries == 0)
        subplot(4,1,1)
        xlim([fmin fmax])
        if handles.freq_log == 1;
            set(gca, 'XScale', 'log')
        else
            set(gca, 'XScale', 'linear')
        end
        subplot(4,1,[2 3 4])
        xlim([fmin fmax])
        if handles.freq_log == 1;
            set(gca, 'XScale', 'log')
        else
            set(gca, 'XScale', 'linear')
        end
    elseif and(MTMred == 0, plotseries == 1)
        subplot(1,4,[2 3 4])
        %xlim([fmin fmax])
        if handles.freq_log == 1;
            set(gca, 'XScale', 'log')
        else
            set(gca, 'XScale', 'linear')
        end
    else
        if handles.freq_log == 1;
            set(gca, 'XScale', 'log')
        else
            set(gca, 'XScale', 'linear')
        end
    end
    
catch
end

guidata(hObject, handles);

% --------------------------------------------------------------------
function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to menuFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

try
    colorgrid = str2double(get(handles.edit9,'String'));
    if colorgrid > 0
        handles.colorgrid = colorgrid;
        %disp('set grid')
    else
        handles.colorgrid = [];
    end
catch
    msgbox('Grid # should be a positive integer','Error')
end
disp(handles.colorgrid);
try figure(handles.evofftfig)
    %colormap(jet)
    if isempty(handles.colorgrid)
        % no grid
        setcolor = handles.color;
        %disp('no set grid')
    else
        setcolor = [handles.color,'(',round(num2str(handles.colorgrid)),')'];
        %disp('1 set grid')
    end
    try colormap(setcolor)
        %disp('set grid ok')
    catch
        colormap default
    end
catch
end

guidata(hObject, handles);

% --------------------------------------------------------------------
function popupmenu3_Callback(hObject, eventdata, handles)
% hObject    handle to menuFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
str = get(hObject, 'String');
val = get(hObject,'Value');
% Set current data to the selected data set.
handles.color = str{val};
if val == 1;
    set(handles.edit9,'String','')
    handles.colorgrid = [];
end

try figure(handles.evofftfig)
    %colormap(jet)
    if isempty(handles.colorgrid)
        % no grid
        setcolor = handles.color;
    else
        setcolor = [handles.color,'(',round(num2str(handles.colorgrid)),')'];
    end
    try colormap(setcolor)
    catch
        colormap default
    end
catch
end
guidata(hObject, handles);

function evofft_win_text_Callback(hObject, eventdata, handles)
% hObject    handle to evofft_win_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of evofft_win_text as text
%        str2double(get(hObject,'String')) returns contents of evofft_win_text as a double
handles.window = str2double(get(hObject,'String'));

% if number of calculations is larger than 500;
% then, a large step is recommended. This way, the ncal is ~500.
ncal = (handles.lenthx - handles.window)/handles.mean;
if ncal > 500
    handles.step = abs(handles.lenthx - handles.window)/500;
end
set(handles.edit_step, 'String', num2str(handles.step),'Value',1);

guidata(hObject,handles)


function edit_step_Callback(hObject, eventdata, handles)
% hObject    handle to edit_step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_step as text
%        str2double(get(hObject,'String')) returns contents of edit_step as a double
content = get(hObject,'String');
handles.step = str2double(content);

% if number of calculations is larger than 500;
% then, a large step is recommended. This way, the ncal is ~500.
ncal = (handles.lenthx - handles.window)/handles.step;
if ncal > 500
    warndlg('Step is too small. Close this warning box and revise, OR come back after a cup of coffee ...')
end

guidata(hObject, handles);

% --------------------------------------------------------------------
function menuFile_Callback(hObject, eventdata, handles)
% hObject    handle to menuFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function munuPlot_Callback(hObject, eventdata, handles)
% hObject    handle to munuPlot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function menuEvofft_Callback(hObject, eventdata, handles)
% hObject    handle to menuEvofft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes during object creation, after setting all properties.
function evofft_win_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function evofft_fmax_edit_Callback(hObject, eventdata, handles)
% hObject    handle to evofft_fmax_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of evofft_fmax_edit as text
%        str2double(get(hObject,'String')) returns contents of evofft_fmax_edit as a double
fmax = str2double(get(handles.evofft_fmax_edit,'String'));
if isnan(fmax)
    handles.evofft_fmax = handles.nyquist;
else
    handles.evofft_fmax = fmax;
end

set(handles.evofft_Nyquist_radiobutton, 'Value', 0);
set(handles.radiobutton2, 'Value', 1);

MTMred = get(handles.checkbox7,'Value');
plotseries = get(handles.checkbox8,'Value');

try figure(handles.evofftfig)
    fmin = str2double(get(handles.edit7,'String'));
    if and(MTMred == 1, plotseries == 1)
        subplot(4,4,[2 3 4])
        xlim([fmin fmax])
        subplot(4,4,[6,7,8,10,11,12,14,15,16])
        xlim([fmin fmax])
    elseif and(MTMred == 1, plotseries == 0)
        subplot(4,1,1)
        xlim([fmin fmax])
        subplot(4,1,[2 3 4])
        xlim([fmin fmax])
    elseif and(MTMred == 0, plotseries == 1)
        subplot(1,4,[2 3 4])
        xlim([fmin fmax])
    else
        xlim([fmin fmax])
    end
    
catch
end

guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function evofft_fmax_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to evofft_fmax_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when selected object is changed in uipanel2.
function uipanel2_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uipanel2 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
evofft_fmax = get(eventdata.NewValue, 'Tag');
if strcmp(evofft_fmax,'Use Nyquist')
    handles.evofft_fmax = handles.nyquist;
    set(handles.evofft_nyquist_text, 'String', num2str(handles.nyquist));
elseif strcmp(evofft_fmax,'Use Input')
    handles.evofft_fmax = handles.evofft_fmax_edit;
    set(handles.evofft_nyquist_text, 'String', num2str(handles.nyquist));
else
   % warndlg('Input maximum frequency for plot','Tips: window length')
end
guidata(hObject,handles)

% --- Executes on button press in evofft_Nyquist_radiobutton.
function evofft_Nyquist_radiobutton_Callback(hObject, eventdata, handles)
% hObject    handle to evofft_Nyquist_radiobutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Hint: get(hObject,'Value') returns toggle state of radiobutton2
val = get(handles.radiobutton2,'Value');
if val > 0
    set(handles.evofft_Nyquist_radiobutton,'Value',0)
    set(handles.radiobutton2, 'Value', 1);
    handles.evofft_fmax = str2double(get(handles.evofft_fmax_edit, 'String'));
else 
    set(handles.evofft_Nyquist_radiobutton,'Value',0)
    handles.evofft_fmax = handles.nyquist;
end

% --- Executes on button press in evofft_tips_win_pushbutton.
function evofft_tips_win_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to evofft_tips_win_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
lang_var = handles.lang_var;

[~, evofft16] = ismember('evofft16',handles.lang_id);
[~, evofft15] = ismember('evofft15',handles.lang_id);

warndlg(lang_var{evofft16},lang_var{evofft15})



% --- Executes during object creation, after setting all properties.
function evofft_nyquist_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to evofft_nyquist_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
guidata(hObject, handles);

function evofft_nyquist_text_Callback(hObject, eventdata, handles)
evofft_nyquist_text = get(hObject, 'String');
handles.evofft_nyquist_text = evofft_nyquist_text; % This overwrites the object's handle!
guidata(hObject, handles);

% --- Executes on button press in evofft_ok_pushbutton.
function evofft_ok_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to evofft_ok_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% handles = findobj('Tag','AutoC_main_figure');
data =  handles.current_data;
dataraw = data;
window = handles.window;
step = str2double(get(handles.edit_step,'String'));
fmax_select = get(handles.evofft_Nyquist_radiobutton,'Value');
freq_log = get(handles.checkbox5,'Value');
method = handles.method;
MTMred = get(handles.checkbox7,'Value');
plotseries = get(handles.checkbox8,'Value');
fmin = str2double(get(handles.edit7,'String'));
unit = get(handles.edit8,'String');
filename =  handles.filename;
[~,dat_name,ext] = fileparts(filename);
norm = handles.normal;
if fmax_select == 1
    fmax = handles.nyquist;
else
    fmax = str2double(get(handles.evofft_fmax_edit,'String'));
end
    
if handles.time_0pad == 1
    % restore time/depth
    data = zeropad2(data,window,handles.padtype);
else
    data(:,2) = data(:,2) - mean(data(:,2));
end
% Evofft Plot
if strcmp(method,'Periodogram')
    [s,x_grid,y_grid]=evoperiodogram(data,window,step,fmin,handles.nyquist,norm);
elseif strcmp(method,'Lomb-Scargle periodogram')
    [s,x_grid,y_grid]=evoplomb(data,window,step,fmin,handles.nyquist,norm);
elseif strcmp(method,'Multi-taper method')
    [s,x_grid,y_grid] = evopmtm(data,window,step,fmin,handles.nyquist,norm);
elseif strcmp(method,'Fast Fourier transform (MatLab)')
    fmin = str2double(get(handles.edit7,'String'));
    [s,x_grid,y_grid]=evofftML(data,window,step,fmin,handles.nyquist,norm);
elseif strcmp(method,'Fast Fourier transform (LAH)')
    dt = data(2,1)-data(1,1);
    %[s,x_grid,y_grid]=evofftLAH(data,window,step,dt,fmin,fmax,norm);
    [s,x_grid,y_grid]=evofft(data,window,step,dt,fmin,handles.nyquist,norm);
end
fmingrid = x_grid(2) - x_grid(1);
handles.fmingrid = fmingrid;

assignin('base','s',s);
assignin('base','x',x_grid);
assignin('base','y',y_grid);
evofftfig = figure;
set(gcf,'Color', 'white')

if handles.plot_2d == 1
    if and(MTMred == 1, plotseries ==0)
        % show MTM red noise, no data series is shown
        dt = median(diff(data(:,1)));
        nfft = length(data(:,1));
        [~, ~,~,redconfML96]=redconfML(data(:,2),dt,2,5*nfft,2,0.25,fmax,0);
        
        subplot(4,1,1)
        if handles.plot_log == 1
            % log power
            semilogy(redconfML96(:,1),redconfML96(:,2),'k')
            hold on;
            semilogy(redconfML96(:,1),redconfML96(:,3),'m-.');
            semilogy(redconfML96(:,1),redconfML96(:,5),'r--','LineWidth',2);
            semilogy(redconfML96(:,1),redconfML96(:,6),'b-.');
        else
            plot(redconfML96(:,1),redconfML96(:,2),'k')
            hold on; 
            plot(redconfML96(:,1),redconfML96(:,3),'m-.');
            plot(redconfML96(:,1),redconfML96(:,5),'r--','LineWidth',2);
            plot(redconfML96(:,1),redconfML96(:,6),'b-.');
            ylabel('Power')
            legend('Power','Robust AR(1) median','Robust AR(1) 95%','Robust AR(1) 99%')
        end
        xlim([fmin fmax])
        if freq_log == 1;
            xlim([fmingrid fmax])
            set(gca, 'XScale', 'log')
        end
        
        subplot(4,1,[2 3 4])
        if handles.plot_log == 0;
            pcolor(x_grid,y_grid,s)
        else
            s = log10(s);
            pcolor(x_grid(2:end),y_grid,s(:,2:end))
        end
        shading interp
        xlim([fmin fmax])
        xlabel(['Frequency (cycles/',unit,')'])
        if handles.flipy == 1;
            set(gca,'Ydir','reverse')
        end
        if freq_log == 1;
            xlim([fmingrid fmax])
            set(gca, 'XScale', 'log')
        end
        
    elseif and(MTMred == 1, plotseries == 1)
        % working
        dt = median(diff(dataraw(:,1)));
        nfft = length(dataraw(:,1));
        [~, ~,~,redconfML96]=redconfML(data(:,2),dt,2,5*nfft,2,0.25,fmax,0);
        subplot(4,4,[2 3 4])
        if handles.plot_log == 1
            % log power
            semilogy(redconfML96(:,1),redconfML96(:,2),'k')
            hold on; 
            semilogy(redconfML96(:,1),redconfML96(:,3),'m-.');
            semilogy(redconfML96(:,1),redconfML96(:,5),'r--','LineWidth',2);
            semilogy(redconfML96(:,1),redconfML96(:,6),'b-.');
        elseif handles.plot_log == 0
            plot(redconfML96(:,1),redconfML96(:,2),'k')
            hold on; 
            plot(redconfML96(:,1),redconfML96(:,3),'m-.');
            plot(redconfML96(:,1),redconfML96(:,5),'r--','LineWidth',2);
            plot(redconfML96(:,1),redconfML96(:,6),'b-.');
            ylabel('Power')
            legend('Power','Robust AR(1) median','Robust AR(1) 95%','Robust AR(1) 99%')
        end
        xlim([fmin fmax])
        if freq_log == 1;
            xlim([fmingrid fmax])
            set(gca, 'XScale', 'log')
        end
        
        subplot(4,4,[5 9 13])
        plot(dataraw(:,2),dataraw(:,1), 'k')
        ylim([dataraw(1,1) dataraw(end,1)])
        xlim([min(dataraw(:,2)) max(dataraw(:,2))])
        if handles.flipy == 1;
            set(gca,'Ydir','reverse')
        end
        
        subplot(4,4,[6,7,8,10,11,12,14,15,16])
        if handles.plot_log == 0;
            pcolor(x_grid,y_grid,s)
        else
            s = log10(s);
            pcolor(x_grid,y_grid,s)
            %pcolor(x_grid(2:end),y_grid,s(:,2:end))
        end
        shading interp
        ylim([dataraw(1,1) dataraw(end,1)])
        xlim([fmin fmax])
        xlabel(['Frequency (cycles/',unit,')'])
        if handles.flipy == 1;
            set(gca,'Ydir','reverse')
        end
        if freq_log == 1;
            xlim([fmingrid fmax])
            set(gca, 'XScale', 'log')
        end
        
    elseif and(MTMred == 0, plotseries == 1)
        % done...
        subplot(1,4,1)
        plot(dataraw(:,2),dataraw(:,1), 'k')
        ylim([dataraw(1,1) dataraw(end,1)])
        xlim([min(dataraw(:,2)) max(dataraw(:,2))])
        if handles.flipy == 1;
            set(gca,'Ydir','reverse')
        end
        if handles.unit_type == 0;
            ylabel(['Unit (',handles.unit,')'])
        elseif handles.unit_type == 1;
            ylabel(['Depth (',handles.unit,')'])
        else
            ylabel(['Time (',handles.unit,')'])
        end
        
        subplot(1,4,[2 3 4])
        if handles.plot_log == 0;
            pcolor(x_grid,y_grid,s)
        else
            s = log10(s);
            pcolor(x_grid(2:end),y_grid,s(:,2:end))
        end
        shading interp
        xlabel(['Frequency (cycles/',unit,')'])
        xlim([fmin fmax])
        ylim([dataraw(1,1) dataraw(end,1)])
        if handles.flipy == 1;
            set(gca,'Ydir','reverse')
        end
        if freq_log == 1;
            xlim([fmingrid fmax])
            set(gca, 'XScale', 'log')
        end
        
    elseif and(MTMred == 0, plotseries == 0)
        % done
        if handles.plot_log == 0;
            pcolor(x_grid,y_grid,s)
        else
            s = log10(s);
            pcolor(x_grid(2:end),y_grid,s(:,2:end))
        end
        shading interp
        xlabel(['Frequency (cycles/',unit,')'])
        xlim([fmin fmax])
        if handles.flipy == 1;
            set(gca,'Ydir','reverse')
        end
        if freq_log == 1;
            xlim([fmingrid fmax])
            set(gca, 'XScale', 'log')
        end
    end
    
    if plotseries == 0
        if handles.unit_type == 0;
            ylabel(['Unit (',handles.unit,')'])
        elseif handles.unit_type == 1;
            ylabel(['Depth (',handles.unit,')'])
        else
            ylabel(['Time (',handles.unit,')'])
        end
    else
        if MTMred == 0
            subplot(1,4,[2 3 4])
            set(gca,'YTickLabel',[]);
        else
            subplot(4,4,[6,7,8,10,11,12,14,15,16])
            set(gca,'YTickLabel',[]);
        end
    end
    
    % set
    if MTMred == 0
        title([method,'; window',' = ',num2str(window),' ',unit,'; step = ',num2str(step),' ', unit])
    else
        if plotseries == 0
            subplot(4,1,1)
            title([method,'; window',' = ',num2str(window),' ',unit,'; step = ',num2str(step),' ', unit])
        else
            subplot(4,4,[2 3 4])
            title([method,'; window',' = ',num2str(window),' ',unit,'; step = ',num2str(step),' ', unit])
        end
        set(gca,'XTickLabel',[]);
    end

    
else
    % 3D
    if handles.plot_log == 1;
        s = log10(s); 
        handles.rotate = get(handles.rotation,'Value');
        surf(x_grid(2:end),y_grid,s(:,2:end))
    else
        handles.rotate = get(handles.rotation,'Value');
        surf(x_grid,y_grid,s)
    end
    shading interp
    xlabel(['Frequency (cycles/',unit,')'])
    xlim([fmin fmax])
    if handles.flipy == 1;
        set(gca,'Ydir','reverse')
    end
    if freq_log == 1;
        xlim([fmingrid fmax])
        set(gca, 'XScale', 'log')
    end
end

    %colormap(jet)
    if isempty(handles.colorgrid)
        % no grid
        setcolor = handles.color;
    else
        setcolor = [handles.color,'(',round(num2str(handles.colorgrid)),')'];
    end
    
    try colormap(setcolor)
    catch
        colormap default
    end
    shading interp
    set(gcf,'Name',[dat_name,ext,': Running Periodogram'])
    

    if handles.plot_2d == 1
        set(gca,'XMinorTick','on','YMinorTick','on')
        set(gca, 'TickDir', 'out')
    else
       set(gca, 'TickDir', 'out')
       if handles.rotate == 0
            view(10,70);
        else
            for i = 1: 370
                view(i,70); 
                pause(0.05); 
            end
       end
    end
handles.evofftfig = evofftfig;
%
if get(handles.checkbox9,'value')
    CDac_pwd
    filename = handles.filename;
    name1 = [filename,'-evofft-s','.txt'];
    name2 = [filename,'-evofft-freq','.txt'];
    name3 = [filename,'-evofft-time','.txt'];
    dlmwrite(name1, s, 'delimiter', ' ', 'precision', 9); 
    dlmwrite(name2, x_grid', 'delimiter', ' ', 'precision', 9); 
    dlmwrite(name3, y_grid', 'delimiter', ' ', 'precision', 9); 
    d = dir; %get files
    set(handles.listbox_acmain,'String',{d.name},'Value',1) %set string
    refreshcolor;
    cd(pre_dirML); % return to matlab view folder
end
guidata(hObject, handles);

% --------------------------------------------------------------------
function menuOpen_Callback(hObject, eventdata, handles)
% hObject    handle to menuOpen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in evofft_get_pushbutton.
function evofft_get_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to evofft_get_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in evofft_open_pushbutton.
function evofft_open_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to evofft_open_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
uiopen;

handles.current_data = data;
handles.step = handles.current_data(2,1)-handles.current_data(1,1);
handles.nyquist = abs(1/(2*handles.step));
handles.evofft_fmax = handles.nyquist;
set(handles.evofft_nyquist_text, 'String', num2str(handles.nyquist));

existdata = evalin('base','who');
if ismember('unit',existdata)
    handles.unit = evalin('base','unit');
else
    handles.unit = 'unit';
end

if ismember('filename',existdata)
    handles.filename = evalin('base','filename');
else
    handles.filename = 'filename';
end

guidata(hObject, handles);


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

lang_var = handles.lang_var;

[~, dd46] = ismember('dd46',handles.lang_id);
[~, dd45] = ismember('dd45',handles.lang_id);

warndlg(lang_var{dd45},lang_var{dd46})


% --- Executes during object creation, after setting all properties.
function edit_step_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_step (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobutton_2d.
function radiobutton_2d_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_2d (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_2d
val = get(handles.radiobutton_2d,'Value');
if val == 1
    set (handles.radiobutton_3d, 'Value', 0);
    set (handles.rotation, 'Value', 0);
    handles.plot_2d = 1;
    set (handles.checkbox7, 'Enable', 'on');
    set (handles.checkbox8, 'Enable', 'on');
else
    set (handles.radiobutton_3d, 'Value', 1);
    set (handles.rotation, 'Value', 1);
    handles.plot_2d = 0;
    set (handles.checkbox7, 'Enable', 'off');
    set (handles.checkbox8, 'Enable', 'off');
end
guidata(hObject, handles);

% --- Executes on button press in radiobutton_3d.
function radiobutton_3d_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_3d (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton_3d
val = get(handles.radiobutton_3d,'Value');
if val == 1
    set (handles.radiobutton_2d, 'Value', 0);
    set (handles.checkbox7, 'Enable', 'off');
    set (handles.checkbox8, 'Enable', 'off');
    handles.plot_2d = 0;
    set (handles.rotation, 'Value', 1);
else
    set (handles.radiobutton_2d, 'Value', 1);
    handles.plot_2d = 1;
    set (handles.checkbox7, 'Enable', 'on');
    set (handles.checkbox8, 'Enable', 'on');
    set (handles.rotation, 'Value', 0);
end
guidata(hObject, handles);

% --- Executes on key press with focus on evofft_Nyquist_radiobutton and none of its controls.
function evofft_Nyquist_radiobutton_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to evofft_Nyquist_radiobutton (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in listbox2.
function listbox2_Callback(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox2
handles.index_selected  = get(hObject,'Value');
guidata(hObject,handles)

% --- Executes during object creation, after setting all properties.
function listbox2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton16.
function pushbutton16_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes on button press in rotation.
function rotation_Callback(hObject, eventdata, handles)
% hObject    handle to rotation (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of rotation


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2
contents = cellstr(get(hObject,'String'));
handles.method = contents{get(hObject,'Value')};
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double
fmin = str2double(get(handles.edit7,'String'));
MTMred = get(handles.checkbox7,'Value');
plotseries = get(handles.checkbox8,'Value');
try figure(handles.evofftfig)
    fmax = str2double(get(handles.evofft_fmax_edit,'String'));
    if and(MTMred == 1, plotseries == 1)
        subplot(4,4,[2 3 4])
        xlim([fmin fmax])
        subplot(4,4,[6,7,8,10,11,12,14,15,16])
        xlim([fmin fmax])
    elseif and(MTMred == 1, plotseries == 0)
        subplot(4,1,1)
        xlim([fmin fmax])
        subplot(4,1,[2 3 4])
        xlim([fmin fmax])
    elseif and(MTMred == 0, plotseries == 1)
        subplot(1,4,[2 3 4])
        xlim([fmin fmax])
    else
        xlim([fmin fmax])
    end
catch
end

guidata(hObject,handles)


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox6.
function checkbox6_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox6

handles.time_0pad = get(hObject,'Value');
guidata(hObject, handles);


% --- Executes on button press in checkbox7.
function checkbox7_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox7


% --- Executes on button press in checkbox8.
function checkbox8_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox8


% --- Executes on selection change in popupmenu4.
function popupmenu4_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu4
contents = cellstr(get(hObject,'String'));
val = contents{get(hObject,'Value')};
if strcmp(val,'zero')
    %disp('zero')
    handles.padtype = 1;
elseif strcmp(val,'mirror')
    %disp('mirror')
    handles.padtype = 2;
elseif strcmp(val,'mean')
    %disp('mean')
    handles.padtype = 3;
elseif strcmp(val,'random')
    %disp('random')
    handles.padtype = 4;
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function popupmenu4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in checkbox9.
function checkbox9_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox9
