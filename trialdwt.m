load /home/habiba/Downloads/DSP/X_100.MAT ;
dec = mdwtdec('r',sig,2 ,'db2');
[xc, decCMP, THRESH] = mswcmp ('cmp', dec , 'rem_n0');
