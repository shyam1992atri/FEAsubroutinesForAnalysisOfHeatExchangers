function cross_flow_Subdomain20614_n_stream
n=4 ;%input('number of stream : ');%input('number of streams');
e=input('number of elements : ');

%disp('specify the m.cp value of counter flowing stream with a -ve value in counter flow')

k=zeros(n,2*n);          % initialising the coeffecient matrix generated from the differential equations

hc=[0 0.5 0.05 0;0 0 0.5 0.05;0 0 0 0.5;0 0 0 0] ;%zeros(n,n);         % this matrix is used to initialise the UA coeffecient terms that will be further used to generate the terms of diff eqn

mf=[1 1 1 1]'; %zeros(n,1);           % this matrix initialises the m.cp values of all the streams

boundry_constant=[1 0 1 0]'; %zeros(n,1);     % This matrix initialisrs the boundry conditions specified in the problem

for d=1:1:n             % loop to control the rows of UA
    for g=d:1:n          % loop to control the columns
%         if d==g       
%             hc(d,g)=0;        % initialising UA11 and so on terms to zero 
%         else
%             fprintf('UA %d %d ',d,g)
%             hc(d,g)=input('specify overall heat transfer coeff of streams:');
             hc(g,d)=hc(d,g);      % UA matrix is symetric about the principal Diagonal
%         end
%     
     end
    
    %fprintf('m.cp of stream %d ',d)
    %mf(d,1)=input(' value:'); 
    
    %fprintf('boundry temperatures in the problem of stream %d',d)
    %boundry_constant(d,1)=input(' value :');
    
end

for c=1:1:n            % loop to control the rows of diff eqn matrix
    for p=1:1:n        % loop to control the columns of diff eqn matrix
        if p==c 
            k(c,p)=-mf(c,1)+(sum(hc(c,:))/(2*e));         % The ii term contains the sum of all terms
            k(c,p+n)=mf(c,1)+(sum(hc(c,:))/(2*e));        % The coeff matrix is symetric about middle verticle line
        else
            k(c,p)=-hc(c,p)/(2*e);
            k(c,p+n)=-hc(c,p)/(2*e);             % Mirroring terms about mid line
        end
    end
end


k  % finally generated coeff matrix of the differential equations  


gc=zeros(2*e*(e+1));

%Assembeling-----------------------------
for i=1:2:2*e
    gc(i:i+1,ceil((i+1)/2):ceil((i+1)/2)+1)=k(:,1:2);
end

j=1;
a=1;
b=1;
a=a+2*e;
b=b+e+1;
while j<e

    gc(a:a+2*e,b:b+e+1)=gc(1:1+2*e,1:1+e+1);
    a=a+2*e;
    b=b+e+1;
    j=j+1;
end


if e>=3
    gc((2*e^2+1),(e*(e+1)+1))=0;
end
%


p=e*(e+1);
d=e*(e+1)+1;
z=zeros(2*e,1);

for h=1:2:2*e 
    z(h,1)=d;
    d=d+e+1;
end

for u=1:2:2*e
    gc(u:u+1,z(u,1):z(u,1)+1)=k(:,3:4);

end

aa=e*(e+1); 
g_temp=gc(1:2*e,aa+1:aa+e*e+1);

co=2*e;
for w=2:e
    gc((co+1):(co+2*e),(aa+w):(aa+w+e*e))=gc(1:2*e,aa+1:aa+e*e+1);
    co=co+2*e;
    
end

f=2*e*(e+1)-2*e+1;
    
for g=1:e+1:2*e*(e+1)
    gc(f,g)=1;
    f=f+1;
    if f<=(2*e*(e+1)-2*e+1+e)
        constant(f-1,1)=boundry_constant(1,1);
        
    else
        constant(f-1,1)=boundry_constant(2,1);
        
    end
    
    

end

gc ; 
constant;
solution=inv(gc)*constant;
t_o=zeros(2*e,1);

l=1;
for s=e+1:e+1:2*e*(e+1)
    t_o(l,1)=solution(s,1);
    l=l+1;
end

t_out=zeros(2,1);
t_out(1,1)=sum(t_o(1:e,:))/e;
t_out(2,1)=sum(t_o(e+1:2*e,:))/e;
t_out;


%effectiveness=zeros(n,1);

% for w=1:n
%     %effectiveness(w,1)=(boundry_constant(1,1)-t_out(w,1))/(boundry_constant(1,1)-boundry_constant(2,1));
%     
% end

    
gc;   
effectiveness=1-t_out(1,1)


end
