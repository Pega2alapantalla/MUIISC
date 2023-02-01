DEFDBL A-Z
k=4
x=0.1
SCREEN 12
WINDOW (0,0)-(4,1)
dt=0.0001

lazo:
xn=k*x*(1-x)
x=xn

k= k-dt
PSET (k,x),14
GOTO lazo
END
