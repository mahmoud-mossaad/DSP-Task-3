function [ handles ] = Decoding( handles)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
if(handles.compression == 'Lossy')
     if(strcmp(handles.Transform, 'dct' ) || strcmp(handles.Transform, 'fft' ))
        %handles.uncompressedSignal = rle(handles.transformedSignal);
        %handles.uncompressedSignal = full(handles.transformedSignal);

     end
else
    disp('Loseless');
end


end

