function [ handles ] = Decoding( handles)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
if(strcmp(handles.compression,'Lossy'))
     if(strcmp(handles.Transform, 'dct' ) || strcmp(handles.Transform, 'fft' ))
        disp('Lossy DCT');
        handles.uncompressedSignal = rle(handles.transformedSignal);
        %handles.uncompressedSignal = full(handles.transformedSignal);
     else 
         handles.cD = zeros(size(handles.uncompressedSignal));
         handles.cA = handles.uncompressedSignal;
     end
else
     if(strcmp(handles.Transform, 'sym4' ) || strcmp(handles.Transform, 'db4' ))
         disp('2asm');
        handles.uncompressedSignal = rle(handles.uncompressedSignal);
        handles.uncompressedSignal = handles.uncompressedSignal';
        handles.cA = handles.uncompressedSignal(1:length(handles.uncompressedSignal)/2,:);
        handles.cD = handles.uncompressedSignal((length(handles.uncompressedSignal)/2)+1:end,:);
 
     end 
end



end

