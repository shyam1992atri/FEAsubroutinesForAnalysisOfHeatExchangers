function test3
n=input('number');
e=input('elements');
g3=zeros(n,2*n);
g3_t=zeros(1,n);
d=1;
de=n+2;
if mod(n,2)==1
    for i=1:2:n
        g3_t(1,i)=d;
        d=d+2;
    end
    for j=2:2:n-1
        g3_t(1,j)=d;
        d=d+2;
    end
end
if mod(n,2)==0
    for h=1:2:n
        g3_t(1,h)=d;
        d=d+2;
    end
    for k=2:2:n+1
        g3_t(1,k)=de;
        de=de+2;
    end
end

for y=1:1:n
    g3(y,g3_t(y))=1;
end
g3_z=zeros(n,n*(e-1));
l=1;
m=1;
for f=1:1:n
    g3_1=g3(:,f);
    for g=l:l+n
        g3_11(:,l)=g3_1;
    end
    l=l+1;
end
for w=n+1:1:2*n
    g3_1=g3(:,w);
    for g=m:m+n
        g3_12(:,m)=g3_1;
    end
    m=m+1;
end
g3_11;
g3_12;
g3_t;
g3;
g3_final=[g3_11 g3_z g3_12]


end
