function fea_n_stream_modified
% green terms represent comments
% this programme solves for any number of heat exchangers say n
% streams...The out put of this programme is the outlet temperature
% This program works of finate element analysis
% it employs sub domain method of assembling the stifness matrix to give
% global_stifnes_matrix*temperature_vector=boundry_condition vector (K*T=C) 
n=input('speccify the number of streams:');

e=input('specify the number of elements:');

disp('press 1 for co-current,cross flow and 2 for counter flow')

type=input('Specify the type of flow:');

disp('specify the m.cp value of counter flowing stream with a -ve value in counter flow')

s=zeros(n,2*n);          % initialising the coeffecient matrix generated from the differential equations

hc=zeros(n-1,n);         % this matrix is used to initialise the UA coeffecient terms that will be further used to generate the terms of diff eqn

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
switch type
    case type==1                    % this case accounts for cross flow and parallel cocurrent flow
        
        if e==1                    % for one element 
            global_stifnes=[s;eye(n,2*n)];
            constant=[zeros((n*e),1);boundry_constant];
            solution=inv(global_stifnes)*constant;
        end

        if e>1                    % for more than one elements

            for i=2:1:e           % loop to generate batch of coeff matrix for different streams
                sg=[zeros(n,n*(i-1)) s zeros(n,(n*(e-1)-n*(i-1)))];
                for j=1:n         % loop to discritise the generated matrix above
                    temp=sg(j,:);        % assigning each row term to a temporary variable 
                        for l=k+1:k+n          % loop to assign the descritised variable to a global stifness matrix 
                            gs_f(k+1,:)=temp;      % assigned global matrix that waits for all elements descritised rows to be added
                        end
                    k=k+1;                      % counter that control the assembly of descritised row to global matrix
                end
            end
            g1=[s,zeros(n,n*(e-1))];
            g3=[eye(n,n*(e+1))];                % Boundry condition matrix that generates terms for known values
            global_stifnes=[g1;gs_f;g3];           % final assembled global stifnes matrix
            constant=[zeros((n*e),1);boundry_constant];
            solution=inv(global_stifnes)*constant;           % Solution of the problem
        end


        for y=n-1:-1:0                % loop that extracts the outlet temperatures
            t_out_1(y+1,1)=solution((size(solution,1)-y),:);
        end
        for t=1:1:n                   % loop that organises the outlet temperatures
            t_out(t,1)=t_out_1(n+1-t,:);
        end
        t_out                        % final out let temperature matrix
        
    otherwise                  % This case accounts only for counter flow

        g3=zeros(n,2*n);              % temporary variable for constant matrix
        g3_t=zeros(1,n);              % matrix that acccounts for position of 1 in boundry condition matrix
        d=1;                          % counter to increment for odd and even streams
        de=n+2;                       % counter to increment only for even terms
        if mod(n,2)==1                      % condition to check for odd number of streams
            for i=1:2:n
                g3_t(1,i)=d;                % loop to generate position for odd numbered rows
                d=d+2;
            end
            for j=2:2:n-1
                g3_t(1,j)=d;                % loop to generate positions in even numbered rows
                d=d+2;
            end
        end
        
        if mod(n,2)==0                     %condition to check for even number of streams           
            for h=1:2:n
                g3_t(1,h)=d;               %loop to generate position for odd numbered rows
                d=d+2;
            end
            for k=2:2:n+1
                g3_t(1,k)=de;              %loop to generate positions in even numbered rows
                de=de+2;
            end
        end

        for y=1:1:n                     %loop to assemble positioning of boundry conditions
            g3(y,g3_t(y))=1;
        end
        
        g3_z=zeros(n,n*(e-1));             % zero matrix to account for boundry conditions whwn there are more than one elements
        
        l=1;                               % counter to saperate the left side of positioning boundry condition matrix
        m=1;                               % counter to saperate the right side of positioning boundry condition matrix
        for f=1:1:n               % loop to generate left part
            g3_1=g3(:,f);
            for g=l:l+n
                g3_11(:,l)=g3_1;           % assembly as per the assembly done for global stifnes matrix
            end
            l=l+1;
        end
        for w=n+1:1:2*n             % loop to generate left part
            g3_1=g3(:,w);
            for g=m:m+n
                g3_12(:,m)=g3_1;         %  assembly as per the assembly done for global stifnes matrix   
            end
            m=m+1;
        end
        g3_final=[g3_11 g3_z g3_12];      % assembeling the boundry condition matrix
        s;
        k=0;
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
end