%using a .mat file as a trial to figure out the index exceeding matrix
%dimensions thing
load  X_100.mat  
[cA,cD] = dwt(sig,'sym4');
[xc, decCMP, THRESH] = mswcmp ( 'cmp', sig, 'N0_perf', 95 );
a= idwt( cA,cD,'sym4' );
subplot(2,2,1)
plot(sig)
subplot(2,2,2)
plot(a)
subplot(2,2,3)
plot(xc)