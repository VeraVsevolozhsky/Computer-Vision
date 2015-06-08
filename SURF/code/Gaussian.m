function g=Gaussian(x,y,sig)
g=1.0/(2.0*pi*sig*sig) * exp(-(x*x+y*y)/(2.0*sig*sig));