function [k,KG,U,KR,epsilon,sigma,R] = TrussSolver(E,L,A,Theta,F,U,nodes);
k={};
epsilon={};
sigma=[];
KG=zeros(2*max(cell2mat(nodes)));
for i=1:length(E)
    k{i}=E(i)*A(i)/L(i)*[cos(deg2rad(Theta(i)))^2 cos(deg2rad(Theta(i)))*sin(deg2rad(Theta(i))) -(cos(deg2rad(Theta(i)))^2) -cos(deg2rad(Theta(i)))*sin(deg2rad(Theta(i))) ; cos(deg2rad(Theta(i)))*sin(deg2rad(Theta(i))) sin(deg2rad(Theta(i)))^2 -cos(deg2rad(Theta(i)))*sin(deg2rad(Theta(i))) -(sin(deg2rad(Theta(i)))^2); -(cos(deg2rad(Theta(i)))^2) -cos(deg2rad(Theta(i)))*sin(deg2rad(Theta(i))) cos(deg2rad(Theta(i)))^2 cos(deg2rad(Theta(i)))*sin(deg2rad(Theta(i))) ; -cos(deg2rad(Theta(i)))*sin(deg2rad(Theta(i))) -(sin(deg2rad(Theta(i)))^2) cos(deg2rad(Theta(i)))*sin(deg2rad(Theta(i))) sin(deg2rad(Theta(i)))^2];
    KG(2*nodes{i}(1)-1,2*nodes{i}(1)-1) = KG(2*nodes{i}(1)-1,2*nodes{i}(1)-1) + k{i}(1,1);
    KG(2*nodes{i}(1)-1,2*nodes{i}(1)) = KG(2*nodes{i}(1)-1,2*nodes{i}(1)) + k{i}(1,2);
    KG(2*nodes{i}(1)-1,2*nodes{i}(2)-1) = KG(2*nodes{i}(1)-1,2*nodes{i}(2)-1) + k{i}(1,3);
    KG(2*nodes{i}(1)-1,2*nodes{i}(2)) = KG(2*nodes{i}(1)-1,2*nodes{i}(2)) + k{i}(1,4);
    KG(2*nodes{i}(1),2*nodes{i}(1)-1) = KG(2*nodes{i}(1),2*nodes{i}(1)-1) + k{i}(2,1);
    KG(2*nodes{i}(1),2*nodes{i}(1)) = KG(2*nodes{i}(1),2*nodes{i}(1)) + k{i}(2,2);
    KG(2*nodes{i}(1),2*nodes{i}(2)-1) = KG(2*nodes{i}(1),2*nodes{i}(2)-1) + k{i}(2,3);
    KG(2*nodes{i}(1),2*nodes{i}(2)) = KG(2*nodes{i}(1),2*nodes{i}(2)) + k{i}(2,4);
    KG(2*nodes{i}(2)-1,2*nodes{i}(1)-1) = KG(2*nodes{i}(2)-1,2*nodes{i}(1)-1) + k{i}(3,1);
    KG(2*nodes{i}(2)-1,2*nodes{i}(1)) = KG(2*nodes{i}(2)-1,2*nodes{i}(1)) + k{i}(3,2);
    KG(2*nodes{i}(2)-1,2*nodes{i}(2)-1) = KG(2*nodes{i}(2)-1,2*nodes{i}(2)-1) + k{i}(3,3);
    KG(2*nodes{i}(2)-1,2*nodes{i}(2)) = KG(2*nodes{i}(2)-1,2*nodes{i}(2)) + k{i}(3,4);
    KG(2*nodes{i}(2),2*nodes{i}(1)-1) = KG(2*nodes{i}(2),2*nodes{i}(1)-1) + k{i}(4,1);
    KG(2*nodes{i}(2),2*nodes{i}(1)) = KG(2*nodes{i}(2),2*nodes{i}(1)) + k{i}(4,2);
    KG(2*nodes{i}(2),2*nodes{i}(2)-1) = KG(2*nodes{i}(2),2*nodes{i}(2)-1) + k{i}(4,3);
    KG(2*nodes{i}(2),2*nodes{i}(2)) = KG(2*nodes{i}(2),2*nodes{i}(2)) + k{i}(4,4);
end
KR=KG;
KR([find(U==0)],:)=[];
KR(:,[find(U==0)])=[];
f=F;
f(:,[find(U==0)])=[];

u=f/KR;
U(find(U~=0))=u;

for l=1:length(E)
    epsilon{l}=[U(:,2*nodes{l}(1)-1:(2*nodes{l}(1)-1)+1) U(:,2*nodes{l}(2)-1:(2*nodes{l}(2)-1)+1)];
    sigma(l)=(E(l)/L(l))*[-cos(deg2rad(Theta(l))) -sin(deg2rad(Theta(l))) cos(deg2rad(Theta(l))) sin(deg2rad(Theta(l)))]*epsilon{l}';
end

R=KG*U'-F';
end