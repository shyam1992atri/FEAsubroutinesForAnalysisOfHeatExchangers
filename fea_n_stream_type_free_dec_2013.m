function fea_n_stream_type_free_dec_2013
% green terms represent comments
% this programme solves for any number of heat exchangers say n
% streams...The out put of this programme is the outlet temperature
% This program works of finate element analysis
% it employs sub domain method of assembling the stifness matrix to give
% global_stifnes_matrix*temperature_vector=boundry_condition vector (K*T=C) 
n=input('speccify the number of streams:');

e=input('specify the number of elements:');

disp('specify the m.cp value of counter flowing stream with a -ve value in counter flow')

s=zeros(n,2*n);          % initialising the coeffecient matrix generated from the differential equations

hc=zeros(n,n);         % this matrix is used to initialise the UA coeffecient terms that will be further used to generate the terms of diff eqn

mf=zeros(n,1);           % this matrix initialises the m.cp values of all the streams

boundry_constant=zeros(n,1);     % This matrix initialisrs the boundry conditions specified in the problem

for d=1:1:n             % loop to control the rows of UA
    for g=d:1:n          % loop to control the columns
        if d==g       
            hc(d,g)=0;        % initialising UA11 and so on terms to zero 
        else
            fprintf('UA %d %d ',d,g)
            hc(d,g)=input('specify overall heat transfer coeff of streams:');
            hc(g,d)=hc(d,g);      % UA matrix is symetric about the principal Diagonal
        end
    
    end
    
    fprintf('m.cp of stream %d ',d)
    mf(d,1)=input(' value:'); 
    
    fprintf('boundry temperatures in the problem of stream %d',d)
    boundry_constant(d,1)=input(' value :');
    
end

for c=1:1:n            % loop to control the rows of diff eqn matrix
    for p=1:1:n        % loop to control the columns of diff eqn matrix
        if p==c 
            s(c,p)=-mf(c,1)+(sum(hc(c,:))/(2*e));         % The ii term contains the sum of all terms
            s(c,p+n)=mf(c,1)+(sum(hc(c,:))/(2*e));        % The coeff matrix is symetric about middle verticle line
        else
            s(c,p)=-hc(c,p)/(2*e);
            s(c,p+n)=-hc(c,p)/(2*e);             % Mirroring terms about mid line
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
t_in                                  % final inlet temperatures
t_out                                 % final outlet temperatures


end
