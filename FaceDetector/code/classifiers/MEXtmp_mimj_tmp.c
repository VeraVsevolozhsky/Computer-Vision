
#include "mex.h"

void DxtimesytimesDx(double *z,double *x, double *y, int n)
{
  int i,j,count = 0;
  
  for (i = 0; i < n; i++) {
    for (j = 0; j < n; j++) {
      *(z+count) = (*(x+i)) * (*(x+j)) * (*(y+count));
      count++;
    }
  }
}


/* The gateway routine */
void mexFunction(int nlhs, mxArray *plhs[],
                 int nrhs, const mxArray *prhs[])
{
  double *y, *z;
  double *x;
  int status,mrows,ncols;
  
  /*  Check for proper number of arguments. */
  /* NOTE: You do not need an else statement when using
     mexErrMsgTxt within an if statement. It will never
     get to the else statement if mexErrMsgTxt is executed.
     (mexErrMsgTxt breaks you out of the MEX-file.) 
  */
  if (nrhs != 2) 
    mexErrMsgTxt("Two inputs required.");
  if (nlhs != 1) 
    mexErrMsgTxt("One output required.");
  
  /* Check to make sure the first input argument is a scalar. */
/*  if (!mxIsDouble(prhs[0]) || mxIsComplex(prhs[0]) ||
      (mxGetM(prhs[1]) != 1)) {
    mexErrMsgTxt("Input x must be a vecor.");
  }
*/
  /* Get the scalar input x. */
  x = mxGetPr(prhs[0]);
  
  /* Create a pointer to the input matrix y. */
  y = mxGetPr(prhs[1]);
  
  /* Get the dimensions of the matrix input y. */
  mrows = mxGetM(prhs[1]);
  ncols = mxGetN(prhs[1]);
    if (mrows!=ncols) {
    mexErrMsgTxt("Input y must be a square matrix.");
  }
  /* Set the output pointer to the output matrix. */
/*output is second input*/
  plhs[0] = mxCreateDoubleMatrix(mrows,ncols, mxREAL);
  
  /* Create a C pointer to a copy of the output matrix. */
  z = mxGetPr(plhs[0]);
  
  /* Call the C subroutine. */
  DxtimesytimesDx(z,x,y,mrows);
}
