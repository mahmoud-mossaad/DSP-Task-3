function [ handles ] = Encoding( handles)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
handles.zeroCounter = 0;
if(handles.compression == 'Lossy')
    disp('in if condition');
   % maxRangeZeroed=0.22; %multiply it with 200% just for Range
   % minRangeZeroed = -0.22;
    if(handles.Transform =='fft')
        for index = 1:1:length(handles.transformedSignal)
            if (abs(handles.transformedSignal(index))<15)&&(abs(handles.transformedSignal(index))> -15)
                handles.transformedSignal(index)=0;
                handles.zeroCounter = handles.zeroCounter +1;
            end
        end
    else 
       for index = 1:1:length(handles.transformedSignal)
            if (handles.transformedSignal(index)<0.20)&&(handles.transformedSignal(index)>-0.20)
                handles.transformedSignal(index)=0;
                handles.zeroCounter = handles.zeroCounter +1;

            end
       end
    end
    handles.transformedSignal= rle(handles.transformedSignal);
else
    handles.Transform = 'loseless';
end

end
