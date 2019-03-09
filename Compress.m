function varargout = Compress(varargin)
% COMPRESS MATLAB code for Compress.fig
%      COMPRESS, by itself, creates a new COMPRESS or raises the existing
%      singleton*.
%
%      H = COMPRESS returns the handle to a new COMPRESS or the handle to
%      the existing singleton*.
%
%      COMPRESS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in COMPRESS.M with the given input arguments.
%
%      COMPRESS('Property','Value',...) creates a new COMPRESS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Compress_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Compress_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Compress

% Last Modified by GUIDE v2.5 03-Mar-2019 05:24:16

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Compress_OpeningFcn, ...
                   'gui_OutputFcn',  @Compress_OutputFcn, ...
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


% --- Executes just before Compress is made visible.
function Compress_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Compress (see VARARGIN)

% Choose default command line output for Compress
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Compress wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Compress_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in dst.
function dst_Callback(hObject, eventdata, handles)
% hObject    handle to dst (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

guidata(hObject, handles)


% --- Executes on button press in dct.
function dct_Callback(hObject, eventdata, handles)
% hObject    handle to dct (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
dctSignal=dct(handles.signal);  %Discrete Cosin Transform of ECG   

axes(handles.Bcompress);
stem(handles.xAxis,dctSignal);
%axis([0 3000 -2 2]) ;
axis([0 max(handles.xAxis) -3 3]); %-3 and 3 are beter for this signal 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%{
counterB_DCT=0;
for index=1:1:END
    if (dcty(index)~=0)
        counterB_DCT=counterB_DCT+1;
    end
end
%}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Compression %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dctyCompressed=dctSignal;

for index = 1:1: handles.lengthSignal
    if (dctSignal(index)<.22)&(dctSignal(index)>-0.22)
        dctyCompressed(index)=0;
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%{ 
counterA_DCT=0;
for index1=1:1:END
    if (dcty1(index1)~=0)
        counterA_DCT=counterA_DCT+1;     
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%CounterA:Data Not ZERO after Compression
%CounterB:Data Not ZERO befor Compression
%CounterA-CounterB :Data set to Zero in COmpression Process

compressionPercentage=( (counterB_DCT-counterA_DCT)/counterB_DCT)*100;
set(handles.compressionPercentage, 'String', CompRatio_DCT);
%}
axes(handles.Acompress);
stem(handles.xAxis, dctyCompressed);
axis([0 max(handles.xAxis) -3 3]);

dctSignalAfterComp=idct(dctyCompressed); %inverse dct

axes(handles.inverse);
plot(handles.xAxis, dctSignalAfterComp);
axis([0 max(handles.xAxis) min(handles.signal) max(handles.signal)]);

error_DCT=handles.signal-dctSignalAfterComp;

%PRD_DCT=sqrt(sum(error_DCT.^2)/sum(y.^2))*100 %msh moqtn3a

axes(handles.error);
plot(handles.xAxis,error_DCT);
axis([0 max(handles.xAxis) min(error_DCT) max(error_DCT)]);

guidata(hObject, handles)

% --- Executes on button press in fft.
function fft_Callback(hObject, eventdata, handles)
% hObject    handle to fft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
guidata(hObject, handles)


% --- Executes on button press in browse.
function browse_Callback(hObject, eventdata, handles)
% hObject    handle to browse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%check if a file is selected

    
[filename directory_name] = uigetfile('*.dat', 'Select a file');
fullname = fullfile(directory_name, filename);
data = load(fullname);

   
%{
    if isequal(filename,0)
       disp('User selected Cancel');
    else
      %choose a file and file data  
        disp(['User selected ', fullfile(pathname,filename)]);
        handles.fullpathname = strcat(pathname, filename);
        set(handles.address, 'String',handles.fullpathname); %showing fullpathname
        %handles.info = audioinfo(handles.fullpathname);
                disp(handles.fullpathname);% read audio file and save sampling freq in Fs and signal in ySignal
% read audio file and save sampling freq in Fs and signal in ySignal
        


;%The ECG data MAT file
        handles.lengthSignal=length(sig);
        handles.xAxis=sig(:,1);     %Time   
        handles.signal=sig(:,2);     %ECG data #1
       % z=sig(1:end,3);      %ECG data #2
        xAxis = handles.xAxis;
        y = handles.signal;
        TS=xAxis(2)-xAxis(1) ; Freq=1/TS;
        axes(handles.original);
        plot(xAxis,y);
axis([0 max(handles.xAxis) min(handles.signal) max(handles.signal)]);
end
%}
guidata(hObject, handles)
