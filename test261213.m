function test261213
a=[1 2 3 4;5 6 7 8;1 0 0 0;0 1 0 0];
b=[0 0 1 2]';

n=input('specify the number of elements : ')

soln=zeros(n*n,1);
temp=zeros(n,1);

for i=1:n
   s=inv(a)*b;
   b(4,1)=s(4,1);
   soln(i,:)=s';
   temp(i,1)=s(3,1);

end

for k=1:n-1
    for j=1:n
        b(3,1)=temp(j,1);
        s=inv(a)*b;
        b(4,1)=s(4,1);
        soln(j+k*n,:)=s';
        temp(j,1)=s(3,1);
    end

end