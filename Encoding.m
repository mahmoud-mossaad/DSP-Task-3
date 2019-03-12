function [ handles ] = Encoding( handles)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
if(handles.compression == 'Lossy')
    if( strcmp(handles.Transform, 'dct' ) || strcmp(handles.Transform, 'fft' ))
       
        threshold = mean(abs(handles.transformedSignal));
        threshold = threshold * 2;
        indeces = find(abs(handles.transformedSignal)<threshold);
        handles.transformedSignal(indeces)=0;

       % handles.transformedSignal= sparse(handles.transformedSignal);


    else
        handles.cD = zeros(size(handles.cD));
        disp('encoding');
    end 
else
    handles.Transform = 'Loseless';
end

end
