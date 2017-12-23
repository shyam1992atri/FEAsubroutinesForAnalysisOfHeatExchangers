function fea_more_than_8_stream 
% green terms represent comments
% this programme solves for any number of heat exchangers say n
% streams...The out put of this programme is the outlet temperature
% This program works of finate element analysis
% it employs sub domain method of assembling the stifness matrix to give
% global_stifnes_matrix*temperature_vector=boundry_condition vector (K*T=C) 
n=12%input('speccify the number of streams:');
l=3;

e=input('specify the number of elements:');

disp('specify the m.cp value of counter flowing stream with a -ve value in counter flow')

s=zeros(n,2*n);          % initialising the coeffecient matrix generated from the differential equations

hc=[0 110 42 28 39 40 131 72 90 51 60 71 ;
    110 0 51 42 32 83 93 101 131 81 45 75 ;
    42 51 0 32 33 43 56 76 89 131 110 11 ; 
    28 42 32  0 73 83 52 43 54 56 89 79 ; 
    39 32 33 73 0 91 45 56 75 89 32 45 ; 
    40 83 43 83 91 0 80 45 72 42 28 39 ; 
    131 93 56 52 45 80 0 46 57 17 24 38 ;
    72 101 76 43 56 45 46 0 89 32 41 110 ;
    90 131 89 54 75 72 57 89 0 131 32 55 ; 
    51 81 131 56 89 42 17 32 131 0 47 12 ; 
    60 45 110 89 32 28 24 41 32 47 0 11 ; 
    71 75 11 79 45 39  38 110 55 12 11 0 ] ; %zeros(n,n); 
% this matrix is used to initialise the UA coeffecient terms that will be further used to generate the terms of diff eqn
%[]
% hc_t=zeros(n);
% for u=1:n
%    hc_t(u,u)=hc(u,u);
%    
% end
% hc=hc-hc_t;
%mf=randn(n,1)%[530 -1100 378 -684 530 -1100 378 -684 530 -1100 378 -684]' ; %zeros(n,1);           % this matrix initialises the m.cp values of all the streams
x_of_mass=1:n;
x_of_mass=x_of_mass'
mf=[530 -1100 378 -684 530 -1100 378 -684 530 -1100 378 -684]' ; %zeros(n,1);           % this matrix initialises the m.cp values of all the streams
%mf_2=polyfit(x_of_mass,mf,2)
%mf=1.2767*x_of_mass.^2-39.29*x_of_mass-32.727
%mf=  [70.7403 -106.2002 139.1067 -169.4598 -197.2595 222.5058 -245.1987 265.3382 -282.9243 297.9570 -310.4363 320.3622]'



% plot(x,mf)
boundry_constant=[76 7 43 15 76 7 43 15 76 7 43 15]'; %zeros(n,1);     % This matrix initialisrs the boundry conditions specified in the problem

% for d=1:1:n             % loop to control the rows of UA
%     for g=d:1:n          % loop to control the columns
%         if d==g       
%             hc(d,g)=0;        % initialising UA11 and so on terms to zero 
%         else
%             fprintf('UA %d %d ',d,g)
%             hc(d,g)=input('specify overall heat transfer coeff of streams:');
%             hc(g,d)=hc(d,g);      % UA matrix is symetric about the principal Diagonal
%         end
%     
%     end
%     
%     fprintf('m.cp of stream %d ',d)
%     mf(d,1)=input(' value:'); 
%     
%     fprintf('boundry temperatures in the problem of stream %d',d)
%     boundry_constant(d,1)=input(' value :');
%     
% end
%*************************************************************************
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
for y=n-1:-1:0                                % loop to extract in let and outlet temperatures
    t_in(y+1,1)=solution(y+1,:);
    t_out_1(y+1,1)=solution((size(solution,1)-y),:);
end
for t=1:1:n                   % loop to organise output temperatures
    t_out(t,1)=t_out_1(n+1-t,:);
end

global_stifnes
solution;
t_in                                 % final inlet temperatures
t_out                                % final outlet temperatures

t_1=1;

for i=1:n:size(solution,1)
    t1(t_1,:)=solution(i,:);
    t2(t_1,:)=solution(i+1,:);
    t3(t_1,:)=solution(i+2,:);
    t4(t_1,:)=solution(i+3,:);
    t5(t_1,:)=solution(i+4,:);
    t6(t_1,:)=solution(i+5,:);
    t7(t_1,:)=solution(i+6,:);
    t8(t_1,:)=solution(i+7,:);
    t9(t_1,:)=solution(i+8,:);
    t10(t_1,:)=solution(i+9,:);
    t11(t_1,:)=solution(i+10,:);
    t12(t_1,:)=solution(i+11,:);
    t_1=t_1+1;
end

x=0:3/e:3;
%SUBPLOT(1,2,1)
plot(x,t1,'-*',x,t2,'-*',x,t3,'-*',x,t4,'-*',x,t5,'-*',x,t6,'-*',x,t7,'-*',x,t8,'-*',x,t9,'-*',x,t10,'-*',x,t11,'-*',x,t12,'-*')
xlabel('Heat exchanger length')
ylabel('Temperature')
% SUBPLOT(1,2,2)
% plot(x_of_mass,mf)
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
