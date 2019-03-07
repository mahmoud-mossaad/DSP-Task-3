function varargout = Comp(varargin)
% COMP MATLAB code for Comp.fig
%      COMP, by itself, creates a new COMP or raises the existing
%      singleton*.
%
%      H = COMP returns the handle to a new COMP or the handle to
%      the existing singleton*.
%
%      COMP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in COMP.M with the given input arguments.
%
%      COMP('Property','Value',...) creates a new COMP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Comp_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Comp_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Comp

% Last Modified by GUIDE v2.5 04-Mar-2019 22:20:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Comp_OpeningFcn, ...
                   'gui_OutputFcn',  @Comp_OutputFcn, ...
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


% --- Executes just before Comp is made visible.
function Comp_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Comp (see VARARGIN)

% Choose default command line output for Comp
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Comp wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Comp_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2


% --- Executes on button press in dwt.
function dwt_Callback(hObject, eventdata, handles)
% hObject    handle to dwt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of dwt


% --- Executes on button press in dct.
function dct_Callback(hObject, eventdata, handles)
% hObject    handle to dct (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of dct


% --- Executes on button press in save.
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in browse.
function browse_Callback(hObject, eventdata, handles)
% hObject    handle to browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(handles.browse, 'value') == 1   
    [FileName,FilePath]= uigetfile('*.*');
    FileName
    if any(regexp(FileName , '.mp3$')) | any(regexp(FileName, '.wav$'))
        if any(regexp(FileName, '.mp3$'))
            set(handles.SigType, 'string', 'mp3 File');
        else
            set(handles.SigType, 'string', 'wav file');
        end
        ExPath = fullfile(FilePath, FileName);
        var = importdata(ExPath);
        handles.signal = var.data; %handles.signal is the signal we're gonna compress.
        plot(var.data)
    else if any(regexp(FileName, '.mat$'))
            set(handles.SigType, 'string', 'mat File');
            ExPath = fullfile(FilePath, FileName);
            var = importdata(ExPath);
            handles.signal = var(1,:); %handles.signal is the signal we're gonna compress.
            plot(var(1,:))
        else if any(regexp(FileName, '.dat$'))
                set(handles.SigType, 'string', 'dat File');
                fid=fopen(FileName,'r');
                time=10;
                f=fread(fid,2*360*time,'ubit12');
                Orig_Sig=f(1:2:length(f));
                handles.signal = Orig_Sig; %handles.signal is the signal we're gonna compress.
                plot(Orig_Sig)
            else
                set(handles.SigType, 'string', 'Not A Signal');
            end
        end
    end
end
guidata(hObject, handles);






function CompRatio_Callback(hObject, eventdata, handles)
% hObject    handle to CompRatio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of CompRatio as text
%        str2double(get(hObject,'String')) returns contents of CompRatio as a double


% --- Executes during object creation, after setting all properties.
function CompRatio_CreateFcn(hObject, eventdata, handles)
% hObject    handle to CompRatio (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function SigType_Callback(hObject, eventdata, handles)
% hObject    handle to SigType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SigType as text
%        str2double(get(hObject,'String')) returns contents of SigType as a double


% --- Executes during object creation, after setting all properties.
function SigType_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SigType (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
