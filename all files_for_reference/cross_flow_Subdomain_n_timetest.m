function cross_flow_Subdomain_n_timetest
% clear all 
% clc
t=cputime;
n=4 ;%input('number of stream : ');%input('number of streams');
e=32;%input('number of elements : ');


kj=zeros(n,2*n);          % initialising the coeffecient matrix generated from the differential equations

hc=[0 0.5 0.05 0;0 0 0.5 0.05;0 0 0 0.5;0 0 0 0] ;%zeros(n,n);         %------ this matrix is used to initialise the UA coeffecient terms that will be further used to generate the terms of diff eqn

mf=[1 1 1 1]'; %zeros(n,1);           %------- this matrix initialises the m.cp values of all the streams

boundry_constant=[1 0 1 0]'; %zeros(n,1);     %----- This matrix initialisrs the boundry conditions specified in the problem

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
            kj(c,p)=-mf(c,1)+(sum(hc(c,:))/(2*e));         % The ii term contains the sum of all terms
            kj(c,p+n)=mf(c,1)+(sum(hc(c,:))/(2*e));        % The coeff matrix is symetric about middle verticle line
        else
            kj(c,p)=-hc(c,p)/(2*e);
            kj(c,p+n)=-hc(c,p)/(2*e);             % Mirroring terms about mid line
        end
    end
end

kj;
k=zeros(n,2*n);
jam=1;
for q=1:2:2*n
    
        k(:,jam)=kj(:,q);
    
        jam=jam+1;
    
end

ore=2*n*0.5+1;
for w=2:2:2*n
    
        k(:,ore)=kj(:,w);
    
        ore=ore+1;
    
end


k;


%Assembeling-----------------------------
%horisontal elements
gc=zeros(n*e*(e+1));
a=zeros(e,1);
b=zeros(e,1);
c=zeros(e,1);
d=zeros(e,1);
djvu=0;
dj=0;
rj=0;

lt_row=n*e;
lt_col=n*e-2*(e-1);

lt_r=n*e;
lt_c=n*e-2*(e-1);



for h=2:e
    d(1,1)=n;
    b(1,1)=n;
    b(h,1)=b(h-1,1)+n;
    d(h,1)=d(h-1,1)+n/2;

end

for r=1:e
   c(r,1)=d(r,1)-(n-1);
   a(r,1)=b(r,1)-(n-1);
end
aa=[a b c d];

for i=1:1:e
    gc(a(i,1):b(i,1),c(i,1):d(i,1))=k(:,1:n);
end

% extension of produced

for w=1:e
    if w<e
    gc(lt_r+1:lt_r+lt_row,lt_c+1:lt_c+lt_col)=gc(1:lt_row,1:lt_col);
    end
    lt_r=lt_r+lt_row;
    lt_c=lt_c+lt_col;

end
%gc(:,n*e*(e+1)*0.5+1:n*e*(e+1))=zeros(n*e*(e+1)*0.5+1:n*e*(e+1))
% horisontal done

%vertical elements---------------
zx=n*e*(e+1)*0.5;
a_v=zeros(e,1);
b_v=zeros(e,1);
c_v=zeros(e,1);
d_v=zeros(e,1);
djvu_v=0;
dj_v=0;
rj_v=0;

lt_row_v=n*e;
lt_col_v=n*e-2*(e-1);

lt_r_v=n*e;
lt_c_v=n*e-2*(e-1)+zx;



for h=2:e
    d_v(1,1)=n+zx;
    b_v(1,1)=n;
    b_v(h,1)=b(h-1,1)+n;
    d_v(h,1)=d(h-1,1)+n/2+zx;

end

for r=1:e
   c_v(r,1)=d_v(r,1)-(n-1);
   a_v(r,1)=b_v(r,1)-(n-1);
end
aa_v=[a_v b_v c_v d];

for i=1:1:e
    gc(a_v(i,1):b_v(i,1),c_v(i,1):d_v(i,1))=k(:,1+n:n+n);
end

% extension of produced

for w=1:e
    if w<e
    gc(lt_r_v+1:lt_r_v+lt_row_v,lt_c_v+1:lt_c_v+lt_col_v)=gc(1:lt_row_v,1+zx:lt_col_v+zx);
    end
    lt_r_v=lt_r_v+lt_row_v;
    lt_c_v=lt_c_v+lt_col_v;

end

%---------------------- apply bc

cls=1;
clh=n*0.5*e+n*0.5;
clv=size(gc,1)-(e*n-1);
for y=1:e
    gc(clv,cls)=1;
    gc(clv+1,cls+1)=1;
    cls=cls+clh;
    clv=clv+2;
    
end

%-------------

cls_v=1+zx;
clh_v=n*0.5*e+n*0.5;
clv_v=size(gc,1)-(e*n*0.5-1);
for y=1:e
    gc(clv_v,cls_v)=1;
    gc(clv_v+1,cls_v+1)=1;
    cls_v=cls_v+clh_v;
    clv_v=clv_v+2;
    
end

gc;

c=[zeros(1,size(gc,1)-n*e),ones(1,n*e*0.5),zeros(1,n*e*0.5)]' ;
sn=inv(gc)*c;
%------ processing solution
t_out=zeros(1,n);
t_out(1,1)=sn(2*e+1);

t_out(1,2)=sn(2*e+1+zx);

t_out(1,3)=sn(2*e+2);

t_out(1,4)=sn(2*e+2+zx);
% t_temp=zeros(e,1);
% 
% cv=2*e+2
% cv_s=2*e+1;
% 
% for g=1:e
%     t_temp(g,1)=sn(cv,1);
%     if e==2
%         cv=cv+cv_s;
%     else
%         cv=cv+cv_s+1;
%     end
%     
% end
% 
% t_temp(1,1)
t_out
e=cputime-t
end