%qmax=3*qmin
clear all;
C=1.54*1000*1000;
d=0.0228;
M=4000;
rwnd=1000;
N=1;
pmax=0.1;
qmin(1)=1;
qmax(1)=3;
K=sqrt(3/2);
p(1)=0.1;
qave(1)=10;
w=0.2;
NUM=1000;
if qave(1)<=qmin(1)
        p(1)=0;
elseif qave(1)>=qmax(1)
            p(1)=1;
else
            p(1)=(qave(1)-qmin(1))/(qmax(1)-qmin(1))*pmax;
end

for i=1:NUM
    if (p(i)~=0)
        q(i)=max((K*N/sqrt(p(i))-C*d/M),0);
    else
        q(i)=rwnd*N-C*d/M;
    end
    
    qave(i+1)=(1-w)*qave(i)+w*q(i);
    %if (qmin(i)<qave(i+1))&(qave(i+1)<qmax)
    qmin(i+1)=qmin(i)+(12-qmin(1))/NUM;
    qmax(i+1)=3*qmin(i);
    
    if qave(i+1)<=qmin(i)
        p(i+1)=0;
    elseif qave(i+1)>=qmax(i)
            p(i+1)=1;
    else
            p(i+1)=(qave(i+1)-qmin(i))/(qmax(i)-qmin(i))*pmax;
    end
end

plot(qmin,qave,'b.')
grid on
xlabel('minimum queue length qmin')
ylabel('Average Queue Size')
title('Bifurcation diagram with qmin as parameter ')

