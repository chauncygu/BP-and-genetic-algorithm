clc ;
clear all;

load data 

k=rand(1,4000);
[m,n]=sort(k);

%训练数据和预测数据
input_train=input(1:1500,:)';
output_train=output(1:1500)';
input_test=input(1501:2000,:)';
output_test=output(1501:2000)';

%数据归一化
[inputn,inputps]=mapminmax(input_train);
[outputn,outputps]=mapminmax(output_train);

%神经网络构建
net=newff(inputn,outputn,5);

%神经网络参数
net.trainParam.epochs=200;
net.trainParam.lr=0.1;
net.trainParam.goal=0.0000004;

%开始训练网络
net=train(net,inputn,outputn);

%测试样本归一化
inputn_test=mapminmax('apply',input_test,inputps);

an=sim(net,inputn_test);

BPoutput=mapminmax('reverse',an,outputps);

% save data net inputps outputps

figure(1);
plot(BPoutput,':og');
hold on;
plot(output_test,'-*');
legend('预测输出','期望输出','fontsize', 12);
title('BP神经网络预测输出','fontsize',12);
xlabel('样本','fontsize',12);
ylabel('输出','fontsize',12);






