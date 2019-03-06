%importing .dat file
fid=fopen('signal.dat','rt');
A = fread(fid,'*float32');
fclose(fid);
%wavelet transformation
[cA,cD] = dwt(A,'sym4'); % cA is approx. coff. vector while cD is the detailed coff. vector
%ddencmp to determine the default global threshold and denoise the signal
[thr,sorh,keepapp] = ddencmp('den','wv',A);
%compress
xd = wdencmp('gbl',A,'sym4',2,thr,sorh,keepapp);
%wavelet transform inverse
x= idwt( cA,cD,'sym4' );
%plotting
% As noticed the compressed signal xd disappeared and is of the same size
% as the original signal A
% the original signal A and the trasnformed back signal x are similar in
% size and shape but there contents aren't all the same
% the contents of x and xd are different but that of xd is the same value
% of threshold which i can't understand
subplot(2,2,1)
plot(A)
subplot(2,2,2)
plot(x)
subplot(2,2,3)
plot(xd)

