% this program runs on sub domain method applied for multi fluid 4 chanel
%heat exchanger
%writen by ShyamPrasad V Atri and Abhishek bhat
function stifnes 

e=input('specify the number of elements');
s=zeros(4,8);
s(1,1)=-1+0.25/e;
s(1,5)=1+0.25/e;
s(1,2)=-0.25/e;
s(1,6)=-0.25/e;
s(1,3)=0;
s(1,7)=0;
s(1,4)=0;
s(1,8)=0;

s(2,1)=-0.25/e;
s(2,5)=-0.25/e;
s(2,2)=-1+0.25/e+0.25/e;
s(2,6)=1+0.25/e+0.25/e;
s(2,3)=-0.25/e;
s(2,7)=-0.25/e;
s(2,4)=0;
s(2,8)=0;

s(3,1)=0;
s(3,5)=0;
s(3,2)=-0.25/e;
s(3,6)=-0.25/e;
s(3,3)=-1+0.25/e+0.25/e;
s(3,7)=1+0.25/e+0.25/e;
s(3,4)=-0.25/e;
s(3,8)=-0.25/e;

s(4,1)=0;
s(4,5)=0;
s(4,2)=0;
s(4,6)=0;
s(4,3)=-0.25/e;
s(4,7)=-0.25/e;
s(4,4)=-1+0.25/e;
s(4,8)=1+0.25/e;
s
%gs=zeros(e+1,1);
%gs_11=zeros(4,4);
%gs_1e=[zeros(4,4*(e-1)),s];
%gs_1e1=[eye(4,4*(e+1))];
%if e>1
%    for i=2:1:(e-1)
%    end
%end

        
    

    






