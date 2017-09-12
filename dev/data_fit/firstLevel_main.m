clear all
clc

%% ------------------------------------------------------------------------
% define input files
%seasonal coeficients
f1='gh-seasonalCoefficients.csv';
%quadratic function fitted to shade sample
f2='fitQuad.csv';


c=csvread(f1);
fit_quad=csvread(f2);

nsun=size(c,1);
ncrit=size(fit_quad,2)/nsun;
ndof=2;

c_opt=zeros(6,nsun,ncrit);
modcheat=1;

for i=1:size(fit_quad,2)
    if mod(i,nsun)==0
        c_opt(:,modcheat,ceil(i/nsun))=fit_quad(:,i);
    else
        c_opt(:,mod(i,nsun),ceil(i/nsun))=fit_quad(:,i);
    end
end



%% --------------------------------------------------------------------------

act_opt=zeros(nsun,ndof);
fcrit_opt=zeros(nsun,ncrit);
obj_opt=[];


X0=[35,0.5];
lb = [0,0];
ub = [70,1];
A_bal = [];
b_bal = [];
Aeq_bal = [];
beq_bal = [];

tic
ticBytes(gcp);
parfor i=1:nsun

    fun=@(x)c(i,1)*fcrit(c_opt(:,i,1),x(1),x(2))+ c(i,2)*fcrit(c_opt(:,i,2),x(1),x(2))+c(i,3)*fcrit(c_opt(:,i,3),x(1),x(2));
    %ezsurf(c(i,1)*fcrit(c_opt(:,i,1),x,y)+ c(i,2)*fcrit(c_opt(:,i,2),x,y)+c(i,3)*fcrit(c_opt(:,i,3),x,y),[0,70],[0,1]);


    x = fmincon(fun,X0,A_bal,b_bal,Aeq_bal,beq_bal,lb,ub);


    act_opt(i,:)=x(1,:);
    fcrit_opt(i,:)=[fcrit(c_opt(:,i,1),x(1),x(2)), fcrit(c_opt(:,i,2),x(1),x(2)), fcrit(c_opt(:,i,3),x(1),x(2))];
    obj_opt(i)=c(i,1)*fcrit(c_opt(:,i,1),x(1),x(2))+ c(i,2)*fcrit(c_opt(:,i,2),x(1),x(2))+c(i,3)*fcrit(c_opt(:,i,3),x(1),x(2));
end
tocBytes(gcp);
toc
%%
csvwrite('outMatlab.csv',act_opt);
