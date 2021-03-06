function [graph] = maldistribution_4_stream(mfh1,mfh2)
% green terms represent comments
% this programme solves for any number of heat exchangers say n
% streams...The out put of this programme is the outlet temperature
% This program works of finate element analysis
% it employs sub domain method of assembling the stifness matrix to give
% global_stifnes_matrix*temperature_vector=boundry_condition vector (K*T=C) 
n=4%input('speccify the number of streams:');
l=3;

e=input('specify the number of elements:');

disp('specify the m.cp value of counter flowing stream with a -ve value in counter flow')

s=zeros(n,2*n);          % initialising the coeffecient matrix generated from the differential equations 

hc=[0 110 42 28;
   110 0 131 18;
   42 131 0 46;
   28 18 46 0] ; %zeros(n,n); 

% this matrix is used to initialise the UA coeffecient terms that will be further used to generate the terms of diff eqn
%[]

mf=[mfh1 -1100 mfh2 -684]' ; %zeros(n,1);           % this matrix initialises the m.cp values of all the streams mfh1,mfh2 530,378

r12=abs(mf(1,1)/mf(2,1));
r13=abs(mf(1,1)/mf(3,1));
r14=abs(mf(1,1)/mf(4,1));
r23=abs(mf(2,1)/mf(3,1));
r24=abs(mf(2,1)/mf(4,1));
r34=abs(mf(3,1)/mf(4,1));

ntu1=(0+ 110+ 42+ 28)*3/abs(mf(1,1)) ;
ntu2=(110+ 0+ 131+ 18)*3/abs(mf(2,1)) ;
ntu3=(42+ 131+ 0+ 46)*3/abs(mf(3,1)) ;
ntu4=(28+ 18+ 46+ 0)*3/abs(mf(4,1));

% plot(x,mf)
boundry_constant=[76 7 43 15]'; %zeros(n,1);     % This matrix initialisrs the boundry conditions specified in the problem 76,43
% for theta tci=7 thi=76

for c=1:1:n            % loop to control the rows of diff eqn matrix
    for p=1:1:n        % loop to control the columns of diff eqn matrix
        if p==c 
            s(c,p)=-mf(c,1)+l*(sum(hc(c,:))/(2*e));         % The ii term contains the sum of all terms
            s(c,p+n)=mf(c,1)+l*(sum(hc(c,:))/(2*e));        % The coeff matrix is symetric about middle verticle line
        else
            s(c,p)=-l*hc(c,p)/(2*e);
            s(c,p+n)=-l*hc(c,p)/(2*e);             % Mirroring terms about mid line
        end
    end
end


s;   % finally generated coeff matrix of the differential equations 

k=0; % counter to asssemble the coeffecient matrices
for r=1:n                                        % this loop maks the problem flow independent 
    g3=zeros(1,n*(e+1));
    if mf(r,1)>0                                      % depending on the m.cp value programme decides what type of flow is taking place
        g3(1,r)=1;
        g3_final(r,:)=g3;
    end
    if mf(r,1)<0
        g3(1,n*(e+1)-n+r)=1;
        g3_final(r,:)=g3;                         % Based on the type decided the rows are appended to form a final boundry condition matrix
    
    end
    
end
g3_final;
    
    

if e==1                      % for one element
    global_stifnes=[s;g3_final];
    constant=[zeros((n*e),1);boundry_constant];
    solution=inv(global_stifnes)*constant;
end

if e>1                         % for more than one elements

    for i=2:1:e
        sg=[zeros(n,n*(i-1)) s zeros(n,(n*(e-1)-n*(i-1)))];         % These 3 for loops account for assembeling of coeff matrix
        for j=1:1:n
            temp=sg(j,:);
                for l=k+1:1:k+n
                    gs_f(k+1,:)=temp;
                end
            k=k+1;
        end
    end
    g1=[s,zeros(n,n*(e-1))];
    global_stifnes=[g1;gs_f;g3_final];              % Assembeling the global stifnes matrix
    constant=[zeros((n*e),1);boundry_constant];
    solution=inv(global_stifnes)*constant;
end

theta12=zeros((n*e)+n,1);
theta13=zeros((n*e)+n,1);
theta14=zeros((n*e)+n,1);
theta23=zeros((n*e)+n,1);
theta24=zeros((n*e)+n,1);
theta34=zeros((n*e)+n,1);

for ii=1:(n*e)+n
    theta12(ii,1)=(solution(ii,1)-boundry_constant(2,1))/(boundry_constant(1,1)-boundry_constant(2,1));
    theta13(ii,1)=(solution(ii,1)-boundry_constant(3,1))/(boundry_constant(1,1)-boundry_constant(3,1));
    theta14(ii,1)=(solution(ii,1)-boundry_constant(4,1))/(boundry_constant(1,1)-boundry_constant(4,1));
    theta23(ii,1)=(solution(ii,1)-boundry_constant(3,1))/(boundry_constant(2,1)-boundry_constant(3,1));
    theta24(ii,1)=(solution(ii,1)-boundry_constant(4,1))/(boundry_constant(2,1)-boundry_constant(4,1));
    theta34(ii,1)=(solution(ii,1)-boundry_constant(4,1))/(boundry_constant(3,1)-boundry_constant(4,1));
end

for y=n-1:-1:0                                % loop to extract in let and outlet temperatures
    t_in(y+1,1)=solution(y+1,:);
    theta12_in(y+1,1)=theta12(y+1,:);
    theta13_in(y+1,1)=theta12(y+1,:);
    theta14_in(y+1,1)=theta12(y+1,:);
    theta23_in(y+1,1)=theta12(y+1,:);
    theta24_in(y+1,1)=theta12(y+1,:);
    theta34_in(y+1,1)=theta12(y+1,:);
    t_out_1(y+1,1)=solution((size(solution,1)-y),:);
    theta12_out_1(y+1,1)=theta12((size(theta12,1)-y),:);
    theta13_out_1(y+1,1)=theta13((size(theta12,1)-y),:);
    theta14_out_1(y+1,1)=theta14((size(theta12,1)-y),:);
    theta23_out_1(y+1,1)=theta12((size(theta12,1)-y),:);
    theta24_out_1(y+1,1)=theta24((size(theta12,1)-y),:);
    theta34_out_1(y+1,1)=theta34((size(theta12,1)-y),:);
end

for t=1:1:n                   % loop to organise output temperatures
    t_out(t,1)=t_out_1(n+1-t,:);
    theta12_out(t,1)=theta12_out_1(n+1-t,:);
    theta13_out(t,1)=theta13_out_1(n+1-t,:);
    theta14_out(t,1)=theta14_out_1(n+1-t,:);
    theta23_out(t,1)=theta23_out_1(n+1-t,:);
    theta24_out(t,1)=theta24_out_1(n+1-t,:);
    theta34_out(t,1)=theta34_out_1(n+1-t,:);
end
solution;
t_in     ;                             % final inlet temperatures
t_out     ;                            % final outlet temperatures
theta12_out;
theta13_out;
theta14_out;
theta23_out;
theta24_out;
theta34_out;
t_1=1;



for i=1:n:size(solution,1)
    t1(t_1,:)=solution(i,:);
    t2(t_1,:)=solution(i+1,:);
    t3(t_1,:)=solution(i+2,:);
    t4(t_1,:)=solution(i+3,:);
    %theta12_sol(t_1,:)=theta12(i,:)


    t_1=t_1+1;
    
end





effectivenessHot1=(530/378)*((t_in(1,1)-t_out(1,1))/(t_in(1,1)-t_in(2,1)))
effectivenessHot1_theta12=(530/378)*((theta12_in(1,1)-theta12_out(1,1))/(theta12_in(1,1)-theta12_in(2,1)))


%TempRatio=bch1/bch2

effectivenessHot2=(530/378)*((t_in(3,1)-t_out(3,1))/(t_in(1,1)-t_in(2,1)))

x=0:3/e:3;

graph=plot(x,t1,'-',x,t2,'-*',x,t3,'-',x,t4,'-*')
xlabel('Heat exchanger length')
ylabel('outlet temperature')
title('mass flow rate ratio variation')

%legend('1','2')


% %test
% a=[1 2 3;4 5 6;7 8 9]
% b=zeros(3)
% for u=1:3
%    b(u,u)=a(u,u);
%    
% end
% b
% a=a-b

end



%maldistribution_4_stream(454,454)