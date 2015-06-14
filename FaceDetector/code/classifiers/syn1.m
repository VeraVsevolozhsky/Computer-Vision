mu1 = rand(50,1);
sigma1 = diag(rand(50,1)/4);
mu2 = rand(50,1);
sigma2 = diag(rand(50,1)/4);

X1 = [mvnrnd(mu1, sigma1, 10)', mvnrnd(mu2, sigma2, 10)'];
X2 = [mvnrnd(mu1, sigma1, 10)', mvnrnd(mu2, sigma2, 10)'];
y1 = [ones(10,1);-ones(10,1)];
y2 = [ones(10,1);-ones(10,1)];

Modelnn = CLSnn(X1,y1);
nnerr = mean(y2~=CLSnnC(X2,Modelnn))
Modelsvm = CLSlibsvm(X1,y1);
svmerr = mean(y2~=CLSlibsvmC(X2,Modelsvm))
Modelmmlr = CLSmmlr(X1,y1);
mmlrerr = mean(y2~=CLSmmlrC(X2,Modelmmlr))
