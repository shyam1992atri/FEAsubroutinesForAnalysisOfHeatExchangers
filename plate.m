function plate
n=input('Number of elements');
P=[-.25 .25 0 0 -.25 .25 0 0; .25 -.5 .25 0 .25 -.5 .25 0; 0 .25 -.5 .25 0 .25 -.5 .25; 0 0 .25 -.25 0 0 .25 -.25];
Q=[eye(4) -eye(4)];
A=Q+(P/n);
B=[1; 0; 1; 0; zeros(4,1)];
B
i=0;
S=[eye(4,8)];
if n==1
    S=[S; A];
end
if n>1
    S=[S zeros(4); A zeros(4); zeros(4) A];
    B=[B; zeros(4,1)];
for i=1:(n-3)
   S=[S zeros((i+2)*4,4)];
   S=[S; zeros(4,4*(i+1)) A];
   B=[B; zeros(4,1)];
   i=i+1;
end
end
S
X=inv(S)*B;
X
end