function [k,KG,R,T] = SteadyStateThermalSolver(K,L,A,modes,h,Q,T,Tc)
k={};
R={};
KG=zeros(length(K)+1);
for i=1:length(K)
    k{i}=[A(i)*K(i)/L(i),-1*A(i)*K(i)/L(i);-1*A(i)*K(i)/L(i),A(i)*K(i)/L(i)];    
    if(modes(i)==3)
        k{i}=k{i}+h(i)*A(i)*[1 0;0 0];
    end
    if(modes(i+1)==3)
        k{i}=k{i}+h(i+1)*A(i)*[0 0;0 1];
    end
    KG(i,i) = KG(i,i) + k{i}(1,1);
    KG(i,i+1) = KG(i,i+1) + k{i}(1,2);
    KG(i+1,i) = KG(i+1,i) + k{i}(2,1);
    KG(i+1,i+1) = KG(i+1,i+1) + k{i}(2,2);
end
KK=KG;

for i=1:length(K)
    R{i}=Q(i)*A(i)*L(i)*0.5*[1 1]+h(i)*A(i)*Tc(i)*[1 0];
end

R=cell2mat(R);
R=[R(1) R(2:2:length(R)-2)+R(3:2:length(R)-1) R(length(R))];

t=T;
F=KK(:,find(T~=1));
KK(find(T~=1),:)=[];
KK(:,find(T~=1))=[];
t(:,find(T==1))=[];

for i=1:size(F,2)
    R=R'-(F(:,i)*t(i));
end
R(find(T~=1),:)=[];
R
KK
tt=R'/KK;
T(T==1)=tt;
end