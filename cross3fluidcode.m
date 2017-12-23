clc
N1=2;%number of row
n1=2;%number of Elements per row
n=N1*n1;%total no of elements
nnode=n*6;
%max=nnode-((3*n)-3);%highest number on the element
NTU=5;
NTU1=NTU/n1;  
C12=1;
R=1;
C32=1;
m1=NTU1/6;
m2=NTU1*C12*(n1/N1)/6;
m3=NTU1*C12*(n1/N1)*R/6;
m4=NTU1*C12*R/(6*C32);

Teta1in=0;
Teta2in=1;
Teta3in=1;

k=[-1/2+2*m1  -2*m1           0         1/2+m1     -m1               0;
    -2*m2     -1/2+2*m2+2*m3 -2*m3      -m2        1/2+m2+m3        -m3 ;
    0         -2*m4          -1/2+2*m4   0         -m4              1/2+m4 ;
    -1/2+m1   -m1             0         1/2+2*m1   -2*m1              0 ;
    -m2       -1/2+m2+m3     -m3         -2*m2      1/2+2*m2+2*m3   -2*m3; 
    0         -m4            -1/2+m4     0          -2*m4           1/2+2*m4 ];

AK=zeros((n*3)+3);
F=zeros((n*3)+3,1);
    T1out=zeros(nnode,1);
    T2out=zeros(nnode,1);
    T3out=zeros(nnode,1);
   
for L=1:n;       
     N(3)=(L*3);
     N(4)=N(3)+1;
     N(5)=N(4)+1;
     N(6)=N(5)+1;
     N(1)=N(3)-2;
     N(2)=((L-(n1-1))*3)-1;  
     
  if L< n1+1;
            N(2)=2;
  end
  m1=uint8(L)
   m=idivide(m1,n1)
   if L==(m*n1)+1;
       N(1)=1;
       N(3)=3;
   end 
   N;
%LER = Last elemnt in a row
   LER=m*n1;
   if L==LER;
       T1out(N(4),1)=N(4);
       %T2out(N(5),1)=N(5);
       T3out(N(6),1)=N(6);
   end
   if L >(n1*(N1-1));
        T2out(N(5),1)=N(5);
   end  

    for i=1:6;
    for j=1:6; 
        AK(N(i),N(j))=AK(N(i),N(j))+k(i,j);
    end
    end  
   
end 

 
AK;
F(1,:)=0;
F(1,1)=Teta1in;
F(2,:)=0;
F(2,1)=Teta2in;
F(3,:)=0;
F(3,1)=Teta3in;
AK(1,:)=0;
AK(1,1)=1;
AK(2,:)=0;
AK(2,2)=1;
AK(3,:)=0;
AK(3,3)=1;
AK;
 F;
 T=AK\F;
  AT1=0.0;
  AT2=0.0;
  AT3=0.0;
  
 for I=1:nnode;
     if T1out(I,1)~=0;
        AT1=AT1+T(T1out(I),1);
    end
     if T2out(I,1)~=0;
          AT2=AT2+T(T2out(I),1)
    end
     if T3out(I,1)~=0;
        AT3=AT3+T(T3out(I),1);
    end
 end

 AT1;
 AT2;
 AT3;
Teta1out=AT1/N1
Teta2out=AT2/n1
Teta3out=AT3/N1

E3FHX=(C32*(Teta3out-Teta3in)+(C12*Teta1out))/((C32*(1-Teta3in))+(C12))
% plot(NTU,Teta1out,'.m')
% hold on 
% plot(NTU,Teta2out,'.m')
% hold on 
% plot(NTU,Teta3out,'.m')
% hold on
 plot(NTU,E3FHX,'.m');
 hold on;

