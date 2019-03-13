function [ handles ] = Encoding( handles)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
if(strcmp(handles.compression,'Lossy'))
    if( strcmp(handles.Transform, 'dct' ) || strcmp(handles.Transform, 'fft' ))
    
      %{
  ffty1=ffty;
for index = 1:1:length(Sig)
    if (abs(ffty(index))<threshold)&(abs(ffty(index))>-threshold)
        ffty1(index)=0;
    end
end
        %}
        
        threshold = mean(abs(handles.transformedSignal));
        threshold = threshold * 2;
        indeces = find(abs(handles.transformedSignal)<threshold);
        handles.transformedSignal(indeces)=0;
        disp('transformed and compressed');
        handles.transformedSignal= rle(handles.transformedSignal);


    else
        handles.cD = zeros(size(handles.cD));
        threshold =  0.78 * mean(abs(handles.cA));
        indeces = find(abs(handles.cA)<threshold);
        handles.cA(indeces)=0;
        disp('transformed dwt and compressed');        
    end 
end


end
