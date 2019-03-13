function [ handles ] = Transformation(handles)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


%dlmwrite('Signal.txt',handles.signal);
switch(handles.Transform)
    case 'dct'
        handles.transformedSignal= dct(handles.signal);
        disp('dct Transformed');
    case 'fft'
        handles.transformedSignal= fft(handles.signal);
        disp('fft Transformed');
    case 'sym4'
        [handles.cA, handles.cD] = dwt(handles.signal,'sym4');
        % handles.transformedSignal =[handles.cA, handles.cD]
        
        disp('sym4 Transformed');
    case 'db4'
        [handles.cA, handles.cD] = dwt(handles.signal,'db4');
    
        % handles.transformedSignal =[handles.cA, handles.cD]
        disp('db4 Transformed');
    
end 
end

