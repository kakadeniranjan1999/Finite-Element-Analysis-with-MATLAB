function [k,KG,U,KR,epsilon,sigma,R] = BarSolver( E,L,A,F,U )
k={};
epsilon={};
sigma=[];
KG=zeros(length(E)+1);
for j =1:length(E)
   k{j}=[A(j)*E(j)/L(j),-1*A(j)*E(j)/L(j);-1*A(j)*E(j)/L(j),A(j)*E(j)/L(j)];
   KG(j,j) = KG(j,j) + k{j}(1,1);
   KG(j,j+1) = KG(j,j+1) + k{j}(1,2);
   KG(j+1,j) = KG(j+1,j) + k{j}(2,1);
   KG(j+1,j+1) = KG(j+1,j+1) + k{j}(2,2);
end
KR=KG;
KR([find(U==0)],:)=[];
KR(:,[find(U==0)])=[];
f=F;
f(:,[find(U==0)])=[];

u=f/KR;
U(find(U~=0))=u;

for l=1:length(U)-1
    epsilon{l}=U([l l+1]);
    sigma(l)=(E(l)/L(l))*[-1 1]*epsilon{l}';
end

R=KG*U'-F';
end