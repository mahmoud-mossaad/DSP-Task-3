function [ handles ] = Transformation(handles)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
switch(handles.Transform)
    case 'dct'
        handles.transformedSignal= dct(handles.signal)
    case 'fft'
        handles.transformedSignal= fft(handles.signal)
    
end 
end

