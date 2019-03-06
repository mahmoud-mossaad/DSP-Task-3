% a trail of a short length matrix trying to figure out the " index exceeds
% matrix dimensions " error caused by mswcmp error
A=[1 2 4];
[cA,cD] = dwt(A,'sym4');
[xc, decCMP, THRESH] = mswcmp ( 'cmp', A, 'bal_sn',5 );
x= idwt( cA,cD,'sym4' );
subplot(2,2,1)
plot(A)
subplot(2,2,2)
plot(x)
subplot(2,2,3)
plot(xc)
