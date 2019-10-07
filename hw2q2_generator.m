function [A,errorNum,errorProba] = hw2q2_generator(N,mu1,mu2,sigma1,sigma2,Prior1,Prior2)
    %%%%generate data
    N1 = N*Prior1;
    N2 = N*Prior2;
    A1 = mvnrnd(mu1,sigma1,N1);
    A1(:,3) = 1;   %%% assign class 1
    A2 = mvnrnd(mu2,sigma2,N2);
    A2(:,3) = 2;   %%% assign class 2
    A = [A1;A2];   %%% combina the sampled data set
    figure(1)
    gscatter(A(:,1),A(:,2),A(:,3),'br','x+');
    xlabel('smaple X','FontSize',16);
    ylabel('sample y','FontSize',16);
    title('homework2-gaussian sample and prediction','FontSize',16);
    hold on
    
    %%%% evaluate the parameter
    mu1 = mean(A1(:,1:2));
    mu2 = mean(A2(:,1:2));
    sigma1 = cov(A1(:,1:2));
    sigma2 = cov(A2(:,1:2));
    %%%%using MAP classfication
    errorNum =0;  
    for nn = 1:N
        s11 = -1/2* (A(nn,1:2)-mu1')*(sigma1)^(-1)*(A(nn,1:2)-mu1')'+log(Prior1)-1/2*log(det(sigma1))/pi;
        s12 = -1/2* (A(nn,1:2)-mu2')*(sigma2)^(-1)*(A(nn,1:2)-mu2')'+log(Prior2)-1/2*log(det(sigma2))/pi;
        
        if s11 > s12
            A(nn,4) = 1;
        else
            A(nn,4) = 2;
            
        end
        if A(nn,4) ~= A(nn,3)
            errorNum =errorNum+1;
        end
            
    end
 
    errorProba = errorNum/400;
   gscatter(A(:,1),A(:,2),A(:,4),'br','oo');
   legend('x for sample class1','+ for sample class2','bo for predict-class1','ro for predict-class2','FontSize',16);
end