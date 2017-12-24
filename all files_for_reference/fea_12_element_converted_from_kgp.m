function fea_12_element_converted_from_kgp
% green terms represent comments
% this programme solves for any number of heat exchangers say n
% streams...The out put of this programme is the outlet temperature
% This program works of finate element analysis
% it employs sub domain method of assembling the stifness matrix to give
% global_stifnes_matrix*temperature_vector=boundry_condition vector (K*T=C) 
n=12;

e=input('specify the number of elements:');

s=zeros(n,2*n);          % initialising the coeffecient matrix generated from the differential equations

hc=zeros(n,n);       % this matrix is used to initialise the UA coeffecient terms that will be further used to generate the terms of diff eqn

mf=[457.73;-748.87;610.8;-147.51;758.58;-174.765;457.73;-748.87;610.8;-147.51;758.58;-174.765];           % this matrix initialises the m.cp values of all the streams

boundry_constant=[300;180;350;160;320;170;300;180;350;160;320;170];     % This matrix initialisrs the boundry conditions specified in the problem
h=[116 163 135 94 116 94 116 163 135 94 116 94];
fin_hight=[0.019 0.019 0.015 0.01 0.019 0.01 0.019 0.019 0.015 0.01 0.019 0.01];
fin_freq=[78.74 118.5 250.1 244.1 78.74 244.1 78.74 118.5 250.1 244.1 78.74 244.1];
alfa=[0.05 0.05 0.05 0.15 0.01 0.001 0.05 0.05 0.05 0.15 0.01 0.001];
aw=0.5*1;   %length=1meter bredth=0.5 meter
af=zeros(1,n);


for j=1:1:n
    af(1,j)=2*0.5*1*fin_hight(1,j)*fin_freq(1,j);
end

hc=[
         0   57.7286   59.4517   52.2759   51.6820   53.7118       0   57.7286   59.4517   52.2759   51.6820   53.7118
   68.9557         0   84.4754   70.6880   69.6063   73.3391 68.9557         0   84.4754   70.6880   69.6063   73.3391
   65.5298   76.3473         0   67.0922   66.1170   69.4759 65.5298   76.3473         0   67.0922   66.1170   69.4759
   59.6328   68.4600   70.8968         0   60.1187   62.8831 59.6328   68.4600   70.8968         0   60.1187   62.8831
   47.1087   52.4514   53.8700   47.9108         0   49.1142 47.1087   52.4514   53.8700   47.9108         0   49.1142
   38.9708   42.5568   43.4859   39.5181   39.1777         0 38.9708   42.5568   43.4859   39.5181   39.1777         0
         0   57.7286   59.4517   52.2759   51.6820   53.7118       0   57.7286   59.4517   52.2759   51.6820   53.7118
   68.9557         0   84.4754   70.6880   69.6063   73.3391 68.9557         0   84.4754   70.6880   69.6063   73.3391
   65.5298   76.3473         0   67.0922   66.1170   69.4759 65.5298   76.3473         0   67.0922   66.1170   69.4759
   59.6328   68.4600   70.8968         0   60.1187   62.8831 59.6328   68.4600   70.8968         0   60.1187   62.8831
   47.1087   52.4514   53.8700   47.9108         0   49.1142 47.1087   52.4514   53.8700   47.9108         0   49.1142
   38.9708   42.5568   43.4859   39.5181   39.1777         0 38.9708   42.5568   43.4859   39.5181   39.1777         0
   ]

% for k=1:1:n
%     for l=1:1:n
%         if l==k
%             hc(k,l)=0;
%         else
%             hc(k,l)=1/((1/(h(1,k)*(aw+alfa(1,k)*af(1,k))))+(1/(h(1,l)*(aw+(1-alfa(1,l))*af(1,l)))));
%         end
%         
%     end
%     
% end


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