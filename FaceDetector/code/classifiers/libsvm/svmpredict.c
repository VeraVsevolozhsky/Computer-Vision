#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "svm.h"

#include "mex.h"
#include "svm_model_matlab.h"

#define CMD_LEN 2048

void read_sparse_instance(const mxArray *prhs, int index, struct svm_node *x)
{
	int i, j, low, high;
	int *ir, *jc;
	double *samples;

	ir = mxGetIr(prhs);
	jc = mxGetJc(prhs);
	samples = mxGetPr(prhs);

	/* each column is one instance */
	j = 0;
	low = jc[index], high = jc[index+1];
	for(i=low;i<high;i++)
	{
		x[j].index = ir[i] + 1;
		x[j].value = samples[i];
		j++;
 	}
	x[j].index = -1;
}

static void fake_answer(mxArray *plhs[])
{
	plhs[0] = mxCreateDoubleMatrix(0, 0, mxREAL);
	plhs[1] = mxCreateDoubleMatrix(0, 0, mxREAL);
	plhs[2] = mxCreateDoubleMatrix(0, 0, mxREAL);

}

void predict(mxArray *plhs[], const mxArray *prhs[], struct svm_model *model, const int predict_probability)
{
	int label_vector_row_num, label_vector_col_num;
	int feature_number, testing_instance_number;
	int instance_index;
	double *ptr_instance, *ptr_label, *ptr_predict_label, *ptr, *ptr_predict_decval;
	struct svm_node *x;
	mxArray *pplhs[1]; /* transposed instance sparse matrix */

	int correct = 0;
	int total = 0;
	double error = 0;
	double sumv = 0, sumy = 0, sumvv = 0, sumyy = 0, sumvy = 0;

	int svm_type=svm_get_svm_type(model);
	int nr_class=svm_get_nr_class(model);
	double *prob_estimates=NULL;

	/* prhs[1] = testing instance matrix */
	feature_number = mxGetN(prhs[1]);
	testing_instance_number = mxGetM(prhs[1]);
	label_vector_row_num = mxGetM(prhs[0]);
	label_vector_col_num = mxGetN(prhs[0]);

	if(label_vector_row_num!=testing_instance_number)
	{
		mexPrintf("# of labels (# of column in prhs[0] does not match # of instances (# of rows in prhs[1]).\n");
		fake_answer(plhs);
		return;
	}
	if(label_vector_col_num!=1)
	{
		mexPrintf("label (prhs[0]) should be a vector (# of column is 1).\n");
		fake_answer(plhs);
		return;
	}

	ptr_instance = mxGetPr(prhs[1]);
	ptr_label    = mxGetPr(prhs[0]);
	
	/* transpose instance matrix */
	if(mxIsSparse(prhs[1]))
	{
		mxArray *pprhs[1];
		pprhs[0] = mxDuplicateArray(prhs[1]);
		if (mexCallMATLAB(1, pplhs, 1, pprhs, "transpose")) {
			mexPrintf("Error: cannot transpose testing instance matrix\n");
			fake_answer(plhs);
			return;
		}
	}

	if(predict_probability)
	{
		if (svm_type==NU_SVR || svm_type==EPSILON_SVR)
			mexPrintf("Prob. model for test data: target value = predicted value + z,\nz: Laplace distribution e^(-|z|/sigma)/(2sigma),sigma=%g\n",svm_get_svr_probability(model));
		else
			prob_estimates = (double *) malloc(nr_class*sizeof(double));
	}

	if(predict_probability && (svm_type==C_SVC || svm_type==NU_SVC))
		plhs[0] = mxCreateDoubleMatrix(testing_instance_number, 1+nr_class, mxREAL);
	else
		plhs[0] = mxCreateDoubleMatrix(testing_instance_number, 1, mxREAL);

	plhs[2] = mxCreateDoubleMatrix(testing_instance_number, 1, mxREAL);

	ptr_predict_label = mxGetPr(plhs[0]);
	ptr_predict_decval = mxGetPr(plhs[2]);
	
	x = (struct svm_node*)malloc((feature_number+1)*sizeof(struct svm_node) );
	for(instance_index=0;instance_index<testing_instance_number;instance_index++)
	{
		int i;
		double maxdecvalue;
		double target,v;

		target = ptr_label[instance_index];

		if(mxIsSparse(prhs[1])) /* prhs[1]^T is still sparse */
			read_sparse_instance(pplhs[0], instance_index, x);
		else
		{
			for(i=0;i<feature_number;i++)
			{
				x[i].index = i+1;
				x[i].value = ptr_instance[testing_instance_number*i+instance_index];
			}
			x[feature_number].index = -1;
		}

		if(predict_probability && (svm_type==C_SVC || svm_type==NU_SVC))
		{
			v = svm_predict_probability(model, x, prob_estimates);
			ptr_predict_label[instance_index] = v;
			for(i=1;i<=nr_class;i++)
				ptr_predict_label[instance_index + i * testing_instance_number] = prob_estimates[i-1];
		}
		else
		{
		        v = svm_predict(model,x,&maxdecvalue);
			ptr_predict_label[instance_index] = v;
			ptr_predict_decval[instance_index] = maxdecvalue;

		}

		if(v == target)
			++correct;
		error += (v-target)*(v-target);
		sumv += v;
		sumy += target;
		sumvv += v*v;
		sumyy += target*target;
		sumvy += v*target;
		++total;
	}
	mexPrintf("Accuracy = %g%% (%d/%d) (classification)\n",
		(double)correct/total*100,correct,total);
	mexPrintf("Mean squared error = %g (regression)\n",error/total);
	mexPrintf("Squared correlation coefficient = %g (regression)\n",
		((total*sumvy-sumv*sumy)*(total*sumvy-sumv*sumy))/
		((total*sumvv-sumv*sumv)*(total*sumyy-sumy*sumy))
		);

	/* return accuracy, mean squared error, squared correlation coefficient */
	plhs[1] = mxCreateDoubleMatrix(3, 1, mxREAL);
	ptr = mxGetPr(plhs[1]);
	ptr[0] = (double)correct/total*100;
	ptr[1] = error/total;
	ptr[2] = ((total*sumvy-sumv*sumy)*(total*sumvy-sumv*sumy))/
				((total*sumvv-sumv*sumv)*(total*sumyy-sumy*sumy));

	free(x);
	if(predict_probability)
		free(prob_estimates);
}

void exit_with_help()
{
	mexPrintf(
	"Usage: [predict_label, accuracy] = svmpredict(testing_label_vector, testing_instance_matrix, model, 'libsvm_options')\n"
	"libsvm_options:\n"
	"-b probability_estimates: whether to predict probability estimates, 0 or 1 (default 0); one-class SVM not supported yet\n"
	);
}

void mexFunction( int nlhs, mxArray *plhs[],
		 int nrhs, const mxArray *prhs[] )
{
	int prob_estimate_flag = 0;
	struct svm_model *model;

	if(nrhs > 4 || nrhs < 3)
	{
		exit_with_help();
		fake_answer(plhs);
		return;
	}

	if(mxIsStruct(prhs[2]))
	{
		const char *error_msg;

		/* parse options */
		if(nrhs==4)
		{
			int i, argc = 1;
			char cmd[CMD_LEN], *argv[CMD_LEN/2];

			/*  put options in argv[] */
			mxGetString(prhs[3], cmd,  mxGetN(prhs[3]) + 1);
			if((argv[argc] = strtok(cmd, " ")) != NULL)
				while((argv[++argc] = strtok(NULL, " ")) != NULL)
					;

			for(i=1;i<argc;i++)
			{
				if(argv[i][0] != '-') break;
				if(++i>=argc)
				{
					exit_with_help();
					fake_answer(plhs);
					return;
				}
				switch(argv[i-1][1])
				{
					case 'b':
						prob_estimate_flag = atoi(argv[i]);
						break;
					default:
						mexPrintf("unknown option\n");
						exit_with_help();
						fake_answer(plhs);
						return;
				}
			}
		}

		model = (struct svm_model *) malloc(sizeof(struct svm_model));
		error_msg = matlab_matrix_to_model(model, prhs[2]);
		if(error_msg)
		{
			mexPrintf("Error: can't read model: %s\n", error_msg);
			svm_destroy_model(model);
			fake_answer(plhs);
			return;
		}

		if(prob_estimate_flag)
			if(svm_check_probability_model(model)==0)
			{
				mexPrintf("Model does not support probabiliy estimates\n");
				fake_answer(plhs);
				svm_destroy_model(model);
				return;
			}

		predict(plhs, prhs, model, prob_estimate_flag);
		/* destroy model */
		svm_destroy_model(model);
	}
	else
	{
		mexPrintf("model file should be a struct array\n");
		fake_answer(plhs);
	}

	return;
}
