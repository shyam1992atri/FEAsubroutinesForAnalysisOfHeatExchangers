function fea_n_stream_type_longitudinal_co_testing
% green terms represent comments
% this programme solves for any number of heat exchangers say n
% streams...The out put of this programme is the outlet temperature
% This program works of finate element analysis
% it employs sub domain method of assembling the stifness matrix to give
% global_stifnes_matrix*temperature_vector=boundry_condition vector (K*T=C) 
n=3  ; %input('speccify the number of streams:');

e=input('specify the number of elements:');

disp('specify the m.cp value of counter flowing stream with a -ve value in counter flow')

s=zeros(n,2*n);          % initialising the coeffecient matrix generated from the differential equations



ntu=[5 0 5]' ; %zeros(n,1);           % this matrix initialises the NTU values of all the streams

boundry_constant=[1 0 0]' ; %zeros(n,1);     % This matrix initialisrs the boundry conditions specified in the problem
% for i=1:n
%     mf(i,1)=input('give ntu val');
%     boundry_constant(i,1)=input('give boundry temperatures');
% end

mu=1.67;
nu=1.67;%input('give value of mu');
lamda=0.05 ; %input('give value of lamda');
alfa=0.003;
tamb=300;
R=(300-87)/(297-87);

oro=-alfa*mu*nu*ntu(1,1)*(R+1)/e;


s=[
    -1+ntu(1,1)*0.5/e  -ntu(1,1)*0.5/e   0   1+ntu(1,1)*0.5/e  -ntu(1,1)*0.5/e   0;
    ntu(1,1)*0.5/e    (-lamda*nu/e-ntu(1,1)*0.5/e-ntu(3,1)*0.5/(mu*e))    ntu(3,1)*0.5/(mu*e)    ntu(1,1)*0.5/e    (lamda*nu/e-ntu(1,1)*0.5/e-ntu(3,1)*0.5/(mu*e))    ntu(3,1)*0.5/(mu*e);
    0    ntu(3,1)*0.5/e    1-ntu(3,1)*0.5/e-alfa*mu*nu*ntu(3,1)*0.5/e    0    ntu(3,1)*0.5/e    -1-ntu(3,1)*0.5/e-alfa*mu*nu*ntu(3,1)*0.5/e         
    ]

% a=[1         2   3;  -lamda*nu/e-ntu(1,1)*0.5/e-ntu(3,1)*0.5/(mu*e)
%    4    5   6]
% 
% s=[-1+ntu(1,1)*0.5 -ntu(1,1)*0.5 0 1+ntu(1,1)*0.5 -ntu(1,1)*0.5 0 ;
%     ntu(1,1)*0.5/(lamda) -1-ntu(1,1)*0.5/(mu*lamda)-ntu(3,1)*0.5/(lamda) ntu(3,1)*0.5/(mu*lamda) ntu(1,1)*0.5/(lamda) 1-ntu(1,1)*0.5/(mu*lamda)-ntu(3,1)*0.5/(lamda) ntu(3,1)*0.5/(mu*lamda);
%     0 -ntu(3,1)*0.5/mu 1+ntu(3,1)*0.5/mu 0 -ntu(3,1)*0.5/mu -1+ntu(3,1)*0.5/mu ]
% s   % finally generated coeff matrix of the differential equations 

k=0; % counter to asssemble the coeffecient matrices---------------------------------------------------------------------------------------------
for r=1:n                                        % this loop maks the problem flow independent 
    g3=zeros(1,n*(e+1));
    if ntu(r,1)>0                                      % depending on the m.cp value programme decides what type of flow is taking place
        g3(1,r)=1;
        g3_final(r,:)=g3;
    end
    if ntu(r,1)<0
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

for h=n:n:e*n-(n-1)
    constant(h,1)=oro;
    
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
    global_stifnes=[g1;gs_f;g3_final];% Assembeling the global stifnes matrix
    q=size(global_stifnes,1);
    global_stifnes(q-1,2)=-1;   % only for 3 stream %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    global_stifnes(q-1,q-1)=1;
    constant=[zeros((n*e),1);boundry_constant];
    for h=n:n:e*n
        constant(h,1)=oro;
    
    end
    constant;
    solution=inv(global_stifnes)*constant;
end
for y=n-1:-1:0                                % loop to extract in let and outlet temperatures
    t_in(y+1,1)=solution(y+1,:);
    t_out_1(y+1,1)=solution((size(solution,1)-y),:);
end
for t=1:1:n                   % loop to organise output temperatures
    t_out(t,1)=t_out_1(n+1-t,:);
end
global_stifnes
t_in                                  % final inlet temperatures
t_out                                 % final outlet temperatures


end
