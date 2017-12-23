% 1D poisson equation
clear all
clc
x=0:0.1:5;
xhg=0:0.02:1;

k=1;
u=1;
f=.4;
l=5;
hg=1;
t=0:0.1:5;
t0=20;
t1=40;
T=zeros(1,size(t,2));
Tg=zeros(1,size(t,2));
p=zeros(1,size(t,2));
o=zeros(1,size(t,2));
j=zeros(1,size(t,2));
y=zeros(1,size(t,2));
for i=1:size(t,2)
   
T(1,i)= sin(pi*x(1,i)/l)*exp((u*x(1,i)*0.5/k)-t(1,i)*((u^2*0.25/k+k*pi^2/l^2)))+((t0-t1)/(1-exp(l*u/k)))*exp(u*x(1,i)/k)+(t1-t0*exp(l*u/k))/(1-exp(l*u/k));
p(1,i)=sin(pi*x(1,i)/l)*exp((u*x(1,i)*0.5/k)-t(1,i)*((u^2*0.25/k+k*pi^2/l^2)));
o(1,i)=((t0-t1+f)/(1-exp(l*u/k)))*exp(u*x(1,i)/k);
j(1,i)=xhg(1,i)*f/u;
y(1,i)=(t1-t0*exp(l*u/k)-f)/(1-exp(l*u/k));
Tg(1,i)=p(1,i)+o(1,i)+j(1,i)+y(1,i);
end
plot(x,Tg,'r',x,T,'k')


[p' o' j' y' Tg'];
hold on

h=0.1;      %   0.5;

e=500*h;   %  20*h;

xn=0:h:h*e  ;   %0:.1:5;

s=(-k/h) * [1 -1 ; -1 1] - (u/2) * [-1 1 ; -1 1];
m=(h/2) * [1 0 ; 0 1];

dt=0.1;

F=(f*h/2)*[1;1];

A=m/dt-s;

B=m/dt;

Ag=zeros(e+1);
Bg=zeros(e+1);
Fg=zeros(e+1,1);

Agt=zeros(e+1);
Bgt=zeros(e+1);
Fgt=zeros(e+1,1);

for i=1:1:e
    Agt(i:i+1,i:i+1)=A;
    Bgt(i:i+1,i:i+1)=B;
    Fgt(i:i+1,1)=F;
    
    Ag=Ag+Agt;
    Bg=Bg+Bgt;
    Fg=Fg+Fgt;
    
    Agt=zeros(e+1);
    Bgt=zeros(e+1);
    Fgt=zeros(e+1,1);
    
end

Ag;
Bg;
Fg;

Ti=20*ones(e+1,1);

sol=inv(Ag)*(Fg+Bg*Ti);%sol=inv(Ag)*(Fg+Bg*Ti);

Ti=sol;
dt=0.2;
% 
% 
while (dt<50)

    Ti(e+1,1)=t1;
    Ti(1,1)=t0;
    
    
    F=(f*h/2)*[1;1];
    
    A=m/dt-s;
    
    B=m/dt;
    
    Ag=zeros(e+1);
    Bg=zeros(e+1);
    Fg=zeros(e+1,1);
    
    Agt=zeros(e+1);
    Bgt=zeros(e+1);
    Fgt=zeros(e+1,1);
    
    for i=1:1:e
        Agt(i:i+1,i:i+1)=A;
        Bgt(i:i+1,i:i+1)=B;
        Fgt(i:i+1,1)=F;
        
        Ag=Ag+Agt;
        Bg=Bg+Bgt;
        Fg=Fg+Fgt;
        
        Agt=zeros(e+1);
        Bgt=zeros(e+1);
        Fgt=zeros(e+1,1);
        
    end
    
    Ag(1,:)=zeros(e+1,1);
    Bg(1,:)=zeros(e+1,1);
    Fg(1,:)=0;
    
    Ag(e+1,:)=zeros(e+1,1);
    Bg(e+1,:)=zeros(e+1,1);
    Fg(e+1,1)=0;
    
    Ag(1,1)=1;
    Bg(1,1)=1;
    Fg(1,1)=0;
    
    Ag(e+1,e+1)=1;
    Bg(e+1,e+1)=1;
    Fg(e+1,1)=0;
    
    sol=inv(Ag)*(Fg+Bg*Ti); %sol=inv(Ag)*(Fg+Bg*Ti);
    Ti=sol;
    dt=dt+0.1;

end

    Ti(e+1,1)=40;
    Ti(1,1)=20;
    


[Tg' Ti ]

plot(xn,Ti,'-*')

axis([0,5,20,40])

























% k=[0.124 -0.118 0.00
% -0.118 0.248 -0.118
% 0.00 -0.118 0.124]
% 
% f=[0.15
% 0.30
% 0.15
% ]
% c=[0.0484 0.0242 0.00
% 0.0242 0.0968 0.0242
% 0.00 0.0242 0.0484]
% 
% tkn=[25
% 25.0
% 25.0]

% a=(c +.5*.1*k)
% b=(c-.5*.1*k)
% c=.1*f
% 
% soln=inv(a)*(b*tkn+c)
% a =[
% 
%     
%        0.1092    0.0183
%            0.0183    0.0546]
% 
% 
% 
% 
% 
% b =[
% 
%     
%         0.0844    0.0301
%              0.0301    0.0422
% ]
% 
% 
% 
% c =[
% 
%     
%     0.0300
%     0.0150
% 
% 
% ]
% soln=inv(a)*(b*tkn+c)

% 
% 
% k=[0.124 -0.118; -0.118 0.124];
% c=[0.0484 0.0242; 0.0242 0.0484];
% f=[0.15 0.15]';
% ca=[-1 1;-1 1];
% dt=1;
% ka=[2 1;1 2];
% A=((c*ca)/(2*dt)+(k*ka/3));
% A(1,:)=zeros(1,2);
% A(1,1)=1;
% A
% sol=inv(A)*0.5*f






% a =
% 
%     0.0546    0.0183         0
%     0.0183    0.1092    0.0183
%          0    0.0183    0.0546
% 
% 
% 
% 
% 
% b =
% 
%     0.0422    0.0301         0
%     0.0301    0.0844    0.0301
%          0    0.0301    0.0422
% 
% 
% 
% 
% c =
% 
%     0.0150
%     0.0300
%     0.0150



























