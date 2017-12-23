function jedi_problem1
l=input('give pendulum length');
g=9.81;
a=[0 -1;-g/l 0];
[eig_vec,eig_val]=eig(a);
time_l=0; %input('give lower limit of time');
time_step=0.1; %input('give time step');
time_u=10; %input('give upper limit of time');
time=time_l:time_step:time_u;
c1=2; %input('give c1 value');
c2=6; %input('give c2 value');
theta=c1*sin(sqrt(g)*time)+c2*cos(sqrt(g)*time);
plot(time,theta)
%plotv([-0.7 1;2 1])