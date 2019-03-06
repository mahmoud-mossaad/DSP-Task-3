% using the same .mat file with the wdencmp function
load  X_100.mat
[cA,cD] = dwt(sig,'sym4');
%getting threshold
[thr,sorh,keepapp] = ddencmp('den','wv',sig);
%compressing
xd = wdencmp('gbl',sig,'sym4',2,thr,sorh,keepapp);
%transform inverse
a= idwt( cA,cD,'sym4' );
subplot(2,2,1)
plot(sig)
subplot(2,2,2)
plot(a)
subplot(2,2,3)
plot(xd)
% threshold has a value unlike the wavelet1 file
%dimensions of the transversed back signal isn't the same as that of the
%original or compressed signal
%the transversed back signal plotting has a missing part
