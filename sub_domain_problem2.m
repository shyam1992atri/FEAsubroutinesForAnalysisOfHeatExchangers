function sub_domain_problem2

e=input('specify the number of elements');
s=zeros(4,8);
s(1,1)=-1+1/2*1.354*e;
s(1,5)=1+1/2*1.354*e;
s(1,2)=-1/2*1.354*e;
s(1,6)=-1/2*1.354*e;
s(1,3)=0;
s(1,7)=0;
s(1,4)=0;
s(1,8)=0;

s(2,1)=-1/2*-0.9604*e;
s(2,5)=-1/2*-0.9604*e;
s(2,2)=-1+1/2*-0.9604*e+1/2*-0.9604*e;
s(2,6)=1+1/2*-0.9604*e+1/2*-0.9604*e;
s(2,3)=-1/2*-0.9604*e;
s(2,7)=-1/2*-0.9604*e;
s(2,4)=0;
s(2,8)=0;

s(3,1)=0;
s(3,5)=0;
s(3,2)=-1/2*-0.5902*e;
s(3,6)=-1/2*-0.5902*e;
s(3,3)=-1+1/2*-0.5902*e+1/2*-0.5902*e;
s(3,7)=1+1/2*-0.5902*e+1/2*-0.5902*e;
s(3,4)=-1/2*-0.5902*e;
s(3,8)=-1/2*-0.5902*e;

s(4,1)=0;
s(4,5)=0;
s(4,2)=0;
s(4,6)=0;
s(4,3)=-1/2*-0.8015*e;
s(4,7)=-1/2*-0.8015*e;
s(4,4)=-1+1/2*-0.8015*e;
s(4,8)=1+1/2*-0.8015*e;
s
k=0
    

for i=2:1:e
    sg=[zeros(4,4*(i-1)) s zeros(4,(4*(e-1)-4*(i-1)))];
    for j=1:4
        temp=sg(j,:);
        for l=k+1:k+4
            gs_f(k+1,:)=temp;
        end
    k=k+1;
    end
    
end

g1=[s,zeros(4,4*(e-1))];
g3=[eye(4,4*(e+1))];
global_stifnes=[g1;gs_f;g3]
constant=[zeros((4*e),1);1;0;-0.5529;-1.85];
solution=inv(global_stifnes)*constant
for y=3:-1:0
    theta_out=solution((size(solution,1)-y),:);
    t_out=theta_out*(41.93-34.93)+41.93
end
end