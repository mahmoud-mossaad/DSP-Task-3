function [ handles ] = Decoding( handles)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
if(handles.compression == 'Lossy')
    handles.uncompressedSignal = rle( handles.transformedSignal );
else
    disp('Loseless');
end


end

