function pressure_drop_2013dec
format long
k=[1 -1;-1 1];

mf=0.0822; %input('Mass flow rate value : ');
rho=1.583; %input('Density Value : ');
f=714.25; %input('fin frequency : ');
t=0.0002; %input('fin thickness value : ');
h=0.0093; %input('fin hight value : ');
deq=0.002125714; %input('Equalent diameter value : ');
l=1;


n=input('number of elements');
gs=zeros(n+1,n+1);
mfm=zeros(n+1,1);

for i=1:n
    gs(i,i+1)=k(1,2);
    gs(i+1,i)=gs(i,i+1);
    gs(i,i)=2;
    
end
gs(1,1)=1;
gs(n+1,n+1)=1;
gs(1,2:n)=0;


mfm(1,1)=mf;
mfm(n+1,1)=-mf;

%pr_drop=zeros(2,1);
R=(f*l*mf)/((1/f-2*t)^2*h^2*2*rho*deq);
pr_drop=R*inv(gs)*mfm

end
