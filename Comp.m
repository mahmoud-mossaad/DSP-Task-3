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

% Last Modified by GUIDE v2.5 10-Mar-2019 20:12:10

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
handles.Transform = 'dct';
handles.compression = 'Lossy';
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


% --- Executes on button press in sym4.
function sym4_Callback(hObject, eventdata, handles)
% hObject    handle to sym4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of sym4


% --- Executes on button press in db4.
function db4_Callback(~, eventdata, handles)
% hObject    handle to db4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% Hint: get(hObject,'Value') returns toggle state of db4





% --- Executes on button press in browse.
function browse_Callback(hObject, eventdata, handles)
% hObject    handle to browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(handles.browse, 'value') == 1   
    [FileName,FilePath]= uigetfile('*.*');
    if any(regexp(FileName , '.mp3$')) | any(regexp(FileName, '.wav$'))
        if any(regexp(FileName, '.mp3$'))
            set(handles.SigType, 'string', 'mp3 File');
        else
            set(handles.SigType, 'string', 'wav file');
        end
        ExPath = fullfile(FilePath, FileName);
        var = importdata(ExPath);
        handles.signal = var.data(:,1); %handles.signal is the signal we're gonna compress.
        axes(handles.axes1);
        %plot(var.data);
    else if any(regexp(FileName, '.mat$')) | any(regexp(FileName, '.MAT$'))
            set(handles.SigType, 'string', 'mat File');
            ExPath = fullfile(FilePath, FileName);
            var = importdata(ExPath);
            handles.signal = var(1,:); %handles.signal is the signal we're gonna compress.
            %plot(var(1,:))
        else if any(regexp(FileName, '.dat$'))
                set(handles.SigType, 'string', 'dat File');
                fid=fopen(FileName,'r');
                time=10;
                f=fread(fid,2*360*time,'ubit12');
                Orig_Sig=f(1:2:length(f));
                handles.signal = Orig_Sig; %handles.signal is the signal we're gonna compress.
                %plot(Orig_Sig);
            else
                set(handles.SigType, 'string', 'Not A Signal');
            end
        end
    end
    axes(handles.axes2);
    plot(handles.signal);
    signal = handles.signal;
    handles.signal = single(handles.signal);
    save('signal.mat','signal');

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
guidata(hObject, handles)



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
guidata(hObject, handles)


% --- Executes on button press in fft.
function fft_Callback(hObject, eventdata, handles)
% hObject    handle to fft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of fft


% --- Executes on key press with focus on db4 and none of its controls.
function db4_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to db4 (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1
contents = cellstr(get(hObject,'String')) ;
popChoice= contents(get(handles.popupmenu1,'Value'));
disp(popChoice);

if(strcmp(popChoice, 'Lossy'))
    handles.compression = 'Lossy';
    disp('lossy');
end 
if (strcmp(popChoice,'Loseless'))
    handles.compression = 'Loseless';
    disp('loseless');

end
guidata(hObject, handles)


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
guidata(hObject, handles)


% --- Executes when selected object is changed in buttonGroup.
function buttonGroup_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in buttonGroup 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
handles.Transform = get(eventdata.NewValue,'Tag');

guidata(hObject, handles)

    
% --- Executes on button press in save.
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = Transformation(handles);
disp(handles.compression);
handles = Encoding(handles);
if(strcmp(handles.Transform, 'dct' ) || strcmp(handles.Transform, 'fft' ))
    transformedSignal = handles.transformedSignal;
    save('compressedSignal.mat','transformedSignal')
else 
    if(strcmp(handles.compression,'Lossy'))
        transformedSignal= [handles.cA];
        save('compressedSignal.mat','transformedSignal')
    else
        transformedSignal = [ handles.cA ; handles.cD];
        transformedSignal = rle(transformedSignal);
        save('compressedSignal.mat','transformedSignal')
    end
    
end



guidata(hObject, handles)


% --- Executes on button press in decompress.
function decompress_Callback(hObject, eventdata, handles)
% hObject    handle to decompress (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load('compressedSignal.mat');
handles.uncompressedSignal = transformedSignal;
handles = Decoding(handles);
switch(handles.Transform);
    case 'dct'
        handles.uncompressedSignal = idct(handles.uncompressedSignal);
    case 'fft'
        handles.uncompressedSignal = ifft(handles.uncompressedSignal);
        handles.uncompressedSignal = real(handles.uncompressedSignal);
    case 'sym4'
        
        handles.uncompressedSignal = idwt(handles.cA, handles.cD,'sym4');
    case 'db4'
        handles.uncompressedSignal = idwt(handles.cA, handles.cD,'db4');
end
axes(handles.axes1);
plot( handles.uncompressedSignal );
compressed = dir('compressedSignal.mat');
signal= dir('signal.mat');

CR = signal.bytes / compressed.bytes; 
set(handles.CR, 'String', CR);
guidata(hObject, handles)
