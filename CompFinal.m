
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Isfahan University
%Mehdi Nasri
%june 2003
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
beep,beep,clear,clc,close all
disp('DSP Project ');
str=datestr(now,'dd-mmm-yyyy HH:MM:SS',0);
disp(str);
disp('Executing program .... ');
count=3000;
load X_100.MAT ;%The ECG data MAT file
END=length(sig);
x=sig(1:end,1);     %Time   
y=sig(1:end,2);     %ECG data #1
z=sig(1:end,3);      %ECG data #2
dlmwrite('OriginalSignal.txt',y);

count=4000;
y2=y ;%temp variable
temp=y;
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
TS=x(2)-x(1),Freq=1/TS,
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%DCT Compression
%
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
disp('DCT Compression');
scrsz = get(0,'ScreenSize');
figure('MenuBar','none','Name','DCT Compression '...
    ,'NumberTitle','off','Position',[1 1 800 600])
subplot(5,1,1),plot(x(1:count),y(1:count)),axis([0 12 4 6.5]) ,title('DCT Compression');       %Plot base ECG signal 
dcty=dct(y);       %Discrete Cosin Transform of ECG   
dlmwrite('DCT_SIGNAL.txt',dcty);

subplot(5,1,2),stem(dcty)  ,  axis([0 3000 -2 2]) ;    %Plot DCT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
counterB_DCT=0;
for index=1:1:END
    if (dcty(index)~=0)
        counterB_DCT=counterB_DCT+1;
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Compression %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dcty1=dcty;

for index = 1:1:END
    if (dcty(index)<.22)&(dcty(index)>-0.22)
        dcty1(index)=0;
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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

%CompRatio_DCT=( (counterB_DCT-counterA_DCT)/counterB_DCT)*100
subplot(5,1,3),stem(dcty1), axis([0 3000 -2 2]);  

aftercomp_DCT=idct(dcty1);
dlmwrite('DCTCompressionSignal.txt',dcty1);
dlmwrite('AfterDCTCompressionSignal.txt',aftercomp_DCT);


subplot(5,1,4),plot(x(1:count),aftercomp_DCT(1:count)),axis([0 12 4 6.5]),

error_DCT=y-aftercomp_DCT;

PRD_DCT=sqrt(sum(error_DCT.^2)/sum(y.^2))*100
subplot(5,1,5),plot(error_DCT),pause(5)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%FFT Comperession 
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
disp('FFT Compression .');
figure('MenuBar','none','Name','FFT Compression '...
    ,'NumberTitle','off','Position',[1 1 800 600])
subplot(5,1,1),plot(x(1:count),y(1:count)),axis([0 12 4 6.5]),title('FFT Compression');        %Plot base ECG signal 
ffty=fft(y);     %FFT Transform of ECG   
dlmwrite('fourierTransformedSignal.txt',ffty);

subplot(5,1,2),stem(abs(ffty))  ,   %Plot Absolute of FFT
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
counterB_FFT=0;
for index=1:1:END
    if (ffty(index)~=0)
        counterB_FFT=counterB_FFT+1;
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ffty1=ffty;
for index = 1:1:END
    if (abs(ffty(index))<25)&(abs(ffty(index))>-25)
        ffty1(index)=0;
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
counterA_FFT=0;
for index1=1:1:END
    if (ffty1(index1)~=0)
        counterA_FFT=counterA_FFT+1;     
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dlmwrite('FFTCompressionSignal.txt',ffty1);

%CounterA:Data Not ZERO after Compression
%CounterB:Data Not ZERO befor Compression
%CounterA-CounterB :Data set to Zero in COmpression Process

CompRatio_FFT=((counterB_FFT-counterA_FFT)/counterB_FFT)*100
subplot(5,1,3),stem(ffty1);   

aftercomp_FFT=ifft(ffty1);
dlmwrite('AfterFFTCompressionSignal.txt',aftercomp_FFT);


subplot(5,1,4),plot(x(1:count),abs(aftercomp_FFT(1:count))),axis([0 12 4 6.5]),

error_FFT=y-aftercomp_FFT;

PRD_FFT=sqrt(abs(sum(error_FFT.^2)/sum(y.^2)))*100
subplot(5,1,5),plot(abs(error_FFT)),axis([0 1000 -0.5 0.5]),pause(5)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%DST Compression
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
disp('DST Compression .')
figure('MenuBar','none','Name','DST Compression '...
    ,'NumberTitle','off','Position',[1 1 800 600]),beep
subplot(5,1,1),plot(x(1:count),y(1:count)),axis([0 12 4 6.5]),title('DST Compression');         %Plot base ECG signal 
dsty=dst(y);       %Discrete Sin Transform of ECG   
subplot(5,1,2),stem(dsty)  ,%  axis([0 3000 -2 2]);    %Plot DST
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
counterB_DST=0;
for index=1:1:END
    if (dsty(index)~=0)
        counterB_DST=counterB_DST+1;
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dsty1=dsty;
for index = 1:1:END
    if (dsty(index)<15)&(dsty(index)>-15)
        dsty1(index)=0;
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
counterA_DST=0;
for index1=1:1:END
    if (dsty1(index1)~=0)
        counterA_DST=counterA_DST+1;     
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%CounterA:Data Not ZERO after Compression
%CounterB:Data Not ZERO befor Compression
%CounterA-CounterB :Data set to Zero in COmpression Process

CompRatio_DST=((counterB_DST-counterA_DST)/counterB_DST)*100
subplot(5,1,3),stem(dsty1);% axis([0 3000 -2 2]);  

aftercomp_DST=idst(dsty1);

subplot(5,1,4),plot(x(1:count),aftercomp_DST(1:count)),axis([0 12 4 6.5]),

error_DST=y-aftercomp_DST;

PRD_DST=sqrt(sum(error_DST.^2)/sum(y.^2))*100
subplot(5,1,5),plot(error_DST),axis([0 1000 -0.5 0.5]),pause(5)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% figure,stem(x(1:400),y(1:400)),axis([0 1.1 4.4 6.2]),grid
% figure,stem(x,y)
% figure,plot(x(1:count),z(1:count)),grid
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%');
disp('DCT2 Compression.....');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% R finding...
for i=1:1:100
    [c n]=max(temp);
    if (c>5.2)
    R(i,1)=c;
    R(i,2)=n;
    end
    for j=-10:1:10
    if (n>10)
        temp((n+j),1)=0;
    else
        temp((n+round(j/2)+5),1)=0;
    end
   end
end
clear temp;
M=R(1:end,2);
m=sort(M,1);
n=[m x(m) y(m)];%n is the matrix of [index of R's ,Time of R's ,Length of R's]
% figure,stem(n(1:end,2),n(1:end,3)),grid,axis([0 30 4.4 6.2])
[Number_Pulse q]=size(n);Number_Pulse

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%calculating Average ...

for(i=1:1:length(n)-1)
    t(i)=n(i+1)-n(i);
end
N=round(mean(t));
T=N*TS
disp('Number of Samples Between 2 Pulse: '),disp(N)
r=n(1:end,3);
R=round(mean(r))
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
t(Number_Pulse)=END-sum(t);
MAX=max(t);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Me :A Matrix that contains individual pulses in each row

%Pulse Sepration...

  for i=1:1:Number_Pulse
          for j=1:1:t(i)
              if i~=1 
                Me(i,j)=y(j+sum(t(1:i-1)));
              else
                Me(i,j)=y(j);
              end
      
          end
  end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Normalization...
%P :A Matrix that contains length Normalized  pulses in each row
for i=1:1:Number_Pulse
    K=resample(Me(i,1:t(i)),N,t(i));
    P(i,1:length(K))=K;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Initialization...
for i=1:1:Number_Pulse
    for j=1:1:N
        Pulse(i,j)=0;
        Pulse2(i,j)=0;
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Normalization...
%pulse :A Matrix that contains both length and Amplitude  Normalized  pulses in each row
for i=1:1:Number_Pulse
    Pulse(i,1:end)=P(i,1:end)/n(i,3);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Compression.....
figure('MenuBar','none','Name','DCT2 Compression #1'...
    ,'NumberTitle','off','Position',[1 1 800 600]),beep,
subplot(2,1,1),imshow(Pulse),title('DCT2 Compression'),colorbar,title('Before Compression');
JB = dct2(Pulse);
JN=JB;
%figure,imshow(JB),colorbar;
for i=1:1:Number_Pulse
    for j=1:1:N
        if ( (JN(i,j)<0.045) & (JN(i,j)>-0.045) ) JN(i,j)=0;
        end
    end
end
iJ = idct2(JN);
 subplot(2,1,2),imshow(iJ),colorbar,title('After Compression'),pause(5)
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 CountDCT2=0;
 for i=1:1:Number_Pulse
     for j=1:1:N
         if (JN(i,j)==0) CountDCT2=CountDCT2+1;
         end
     end
 end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#####
%Pulse Reconstruction....

for i=1:1:Number_Pulse
    Pulse2(i,1:end)=iJ(i,1:end)*n(i,3);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:1:Number_Pulse
    K2=resample(Pulse2(i,1:end),t(i),N);
    P2(i,1:length(K2))=K2;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for (i=1:1:Number_Pulse)
    for (j=1:1:t(i))
        if(i~=1)  Rec_Pulse(j+sum(t(1:i-1)))=P2(i,j) ;
         else  Rec_Pulse(j)=P2(i,j) ;
         end
            
    end
end
Rec_Pulse=Rec_Pulse';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure('MenuBar','none','Name','DCT2 Compression #2'...
    ,'NumberTitle','off','Position',[1 1 800 600])
subplot(3,1,1),plot(y),axis([0 10000 4 6.5]),title('DCT2 Compression '),
subplot(3,1,2),plot(Rec_Pulse),axis([0 10000 4 6.5])
% for i=1:1:END
% error_DCT2(i,1)=y(i)-Rec_Pulse(i);
% end
error_DCT2=y-Rec_Pulse;
CompRatio=(CountDCT2/END)*100

PRD_DCT2=sqrt(sum(error_DCT2.^2)/sum(y.^2))*100

subplot(3,1,3),plot(error_DCT2),axis([0 10000 -0.5 0.5]),

disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
% close all
% figure,plot(x(1:count),y(1:count)),grid
% figure,plot(x(1:count),z(1:count)),grid
% %R finding...
% for i=1:1:100
%     [c i]=max(y);
%     R(i,1)=c,R(i,2)=i;
%     

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%pause(10),
disp('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%')
disp('End of program ....')
str=datestr(now,'dd-mmm-yyyy HH:MM:SS',0);
disp(str);
%pause(10);close all,beep,pause(1),beep;pause(1),beep;