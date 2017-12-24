function test2
a=[1 2 3 4;5 6 7 8;9 10 11 12;13 14 15 16];
c=input('press 1 or 2');
b=zeros(4,8)
for i=1:4
    for j=1:4
        if j==i
            b(i,j)=sum(a(i,:));
            b(i,j+4)=-sum(a(i,:));
        else
            b(i,j)=-a(i,j);
            b(i,j+4)=-a(i,j);
        end
    end
end
a
b
switch c
    case c==1
        disp('test1');
    otherwise 
        disp('test 2');
end
    

        