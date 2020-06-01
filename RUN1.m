clear all;
C=1.54*1000*1000;
d=0.0228;
M=4000;
rwnd=1000;
N=1;
pmax(1)=0.1;
qmin=5;
qmax=15;
K=sqrt(3/2);
p(1)=0.1;
qave(1)=10;
w=0.04;
NUM=2000;
if qave(1)<=qmin
        p(1)=0;
elseif qave(1)>qmax
            p(1)=1;
else
            p(1)=(qave(1)-qmin)/(qmax-qmin)*pmax(1);
end

for i=1:NUM
    if (p(i)~=0)
        q(i)=max((K*N/sqrt(p(i))-C*d/M),0);
    else
        q(i)=rwnd*N-C*d/M;
    end
    qave(i+1)=(1-w)*qave(i)+w*q(i);
    pmax(i+1)=pmax(i)+(0.9-pmax(1))/NUM;
    
    if qave(i+1)<=qmin
        p(i+1)=0;
    elseif qave(i+1)>qmax
            p(i+1)=1;
    else
            p(i+1)=(qave(i+1)-qmin)/(qmax-qmin)*pmax(i);
    end
end
q(NUM+1)=q(NUM);
plot(pmax,qave,'b.')
grid on
%axis([-pi pi -1 1])
xlabel('Exponential averaging weight pmax')
ylabel('Average Queue Size')
title('Bifurcation diagram with pmax as parameter ')
%text(1,-1/3,'{\itNote the odd symmetry.}')
