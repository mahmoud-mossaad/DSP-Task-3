function [ handles ] = Transformation(handles)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
dlmwrite('Signal.txt',handles.signal);
switch(handles.Transform)
    case 'dct'
        handles.transformedSignal= dct(handles.signal);
    case 'fft'
        handles.transformedSignal= fft(handles.signal);
    case 'sym4'
        [handles.cA, handles.cD] = dwt(handles.signal,'sym4');
        disp('sym4');
    case 'db4'
        [handles.cA, handles.cD] = dwt(handles.signal,'db4');
        disp('db4');
    
end 
end

