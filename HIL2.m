N=input('NTU = ')
e=0.05
f=0.005
c=1
if c>1
    d=1/c
    a=((1/c)+1)*N
    b=((1/c)+1)*N
else
    d=1
    a=(c+1)*N
    b=(c+1)*N
end
n=input('no of elements =')
R=0
N=N/n;
a=a/n;
b=b/n;
C1=[a/3-0.5 -a/3 0 a/6+0.5 -a/6 0; a/3 -d*e-a/3-b/(3*c) b/(3*c) a/6 d*e-a/6-b/(6*c) b/(6*c); 0 b/3 -b/3-0.5-(f*c*d*N)/3 0 b/6 -b/6+0.5-(f*c*d*N)/6; a/6-0.5 -a/6 0 a/3+0.5 -a/3 0; a/6 d*e-a/6-b/(6*c) b/(6*c) a/3 -d*e-a/3-b/(3*c) b/(3*c); 0 b/6 -b/6-0.5-(f*c*d*N)/6 0 b/3 -b/3+0.5-(f*c*d*N)/3]
if n==1
    A1=zeros(3*n+3,3*n+3);
    A1(1:3*n+3,1:3*n+3)=[C1];
end
for j=2:n
    if j==2
        A1=zeros(3*j+3,3*j+3);
        A1(2*j-3:3*j,2*j-3:3*j)=[C1];
    end
    A1(3*j+3,3*j+3)=0;
    B1=zeros(3*j+3,3*j+3);
    B1(3*j-2:3*j+3,3*j-2:3*j+3)=[C1];
    A1=B1+A1;
end
A1(1,:)=zeros(1,3*n+3);
A1(3*n+3,:)=zeros(1,3*n+3);
A1(1,1)=1;
A1(3*n+3,3*n+3)=1;
E1=[0 0 -(f*c*d*N)*(R+1)/2 0 0 -(f*c*d*N)*(R+1)/2];
K1=E1';
if n==1
   E1=E1';
end
for j=2:n
    if j==2
       E1=zeros(9,1);
       E1(1:6,:)=[K1];
    end
    E1(3*j+3,1)=0;
    D1=zeros(3*j+3,1);
    D1(3*j-2:3*j+3,:)=[K1];
    E1=E1+D1;
end
E1(1,1)=1;
E1(3*n+3,1)=0;
T1=inv(A1)*E1
e1=((1-T1(3*n+1,1))/(d*(1+((e)*((T1(2,1))-(T1(3*n+2,1)))))))
T1=T1';
T1=(T1.*(297-84.9))+84.9;
T1=T1';
Th1=T1([1:3:3*n+1],1);
Tc1=T1([3:3:3*n+3],1);
TH1=Th1([linspace(1,n+1,5)],1)
TC1=Tc1([linspace(1,n+1,5)],1)
x1=[0:1:n];
Th1=Th1';
Tc1=Tc1';
plot(x1,Th1,x1,Tc1)

e=0
f=0
C1=[a/3-0.5 -a/3 0 a/6+0.5 -a/6 0; a/3 -d*e-a/3-b/(3*c) b/(3*c) a/6 d*e-a/6-b/(6*c) b/(6*c); 0 b/3 -b/3-0.5-(f*c*d*N)/3 0 b/6 -b/6+0.5-(f*c*d*N)/6; a/6-0.5 -a/6 0 a/3+0.5 -a/3 0; a/6 d*e-a/6-b/(6*c) b/(6*c) a/3 -d*e-a/3-b/(3*c) b/(3*c); 0 b/6 -b/6-0.5-(f*c*d*N)/6 0 b/3 -b/3+0.5-(f*c*d*N)/3]
if n==1
    A1=zeros(3*n+3,3*n+3);
    A1(1:3*n+3,1:3*n+3)=[C1];
end
for j=2:n
    if j==2
        A1=zeros(3*j+3,3*j+3);
        A1(2*j-3:3*j,2*j-3:3*j)=[C1];
    end
    A1(3*j+3,3*j+3)=0;
    B1=zeros(3*j+3,3*j+3);
    B1(3*j-2:3*j+3,3*j-2:3*j+3)=[C1];
    A1=B1+A1;
end
A1(1,:)=zeros(1,3*n+3);
A1(3*n+3,:)=zeros(1,3*n+3);
A1(1,1)=1;
A1(3*n+3,3*n+3)=1;
E1=[0 0 -(f*c*d*N)*(R+1)/2 0 0 -(f*c*d*N)*(R+1)/2];
K1=E1';
if n==1
   E1=E1';
end
for j=2:n
    if j==2
       E1=zeros(9,1);
       E1(1:6,:)=[K1];
    end
    E1(3*j+3,1)=0;
    D1=zeros(3*j+3,1);
    D1(3*j-2:3*j+3,:)=[K1];
    E1=E1+D1;
end
E1(1,1)=1;
E1(3*n+3,1)=0;
T1=inv(A1)*E1
e2=((1-T1(3*n+1,1))/(d*(1+((e)*((T1(2,1))-(T1(3*n+2,1)))))))
T1=T1';
T1=(T1.*(297-84.9))+84.9;
T1=T1';
Th1=T1([1:3:3*n+1],1);
Tc1=T1([3:3:3*n+3],1);
TH1=Th1([linspace(1,n+1,5)],1)
TC1=Tc1([linspace(1,n+1,5)],1)
x1=[0:1:n];
Th1=Th1';
Tc1=Tc1';
df=(e2-e1)/e2