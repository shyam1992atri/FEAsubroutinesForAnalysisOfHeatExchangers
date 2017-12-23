% this program runs on sub domain method applied for multi fluid 4 chanel
%heat exchanger
%writen by ShyamPrasad V Atri and Abhishek bhat
function modified_stifnes 

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

gs_11=[s,zeros(4,4*(e-1))];

gs_1e1=[eye(4,4*(e+1))];

k=0

if e>1
    for i=2:1:e
        gs_i=[zeros(4,4*(i-1)),s,zeros(4,(4*(e-1)-4*(i-1)))];
        for j=1:4
            temp=gs_i(j,:);
            for l=k+1:k+4
                gs_f(k+1,:)=temp
            end
        end
        k=k+1;
    end    
end

global_stifnes=[gs_11;gs_f;gs_1e1]
constant=[zeros((4*e),1);1;0;1;0]
solution=inv(global_stifnes)*constant