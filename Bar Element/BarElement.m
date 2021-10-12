n=input('Enter the number of Bar Elements = ');
E=[];
L=[];
A=[];
F=[];
U=[];
for i=1:n
    E(i)=input(['Enter E',num2str(i),' (N/mm2) = ']);
    L(i)=input(['Enter L',num2str(i),' (mm) = ']);
    A(i)=input(['Enter A',num2str(i),' (mm2) = ']);
end
cprintf('*cyan*','For Displacements >>>>\nEnter "0" for FIXED SUPPORTS (zero displacement) and "1" for UNKNOWN DISPLACEMENTS\n')
for i=1:n+1
    F(i)=input(['Enter F',num2str(i),' (Force at node ',num2str(i),')',' (N) = ']);
    U(i)=input(['Enter U',num2str(i),' (Displacement at node ',num2str(i),')',' (mm) = ']);
end
[k,KG,U,KR,epsilon,sigma,R]=BarSolver(E,L,A,F,U);
cprintf('*cyan*','Global Element Stiffness Matrix =\n');
disp(KG);
cprintf('*cyan*','Nodal Displacement =\n');
disp(U);
cprintf('*cyan*','Element Stress =\n');
disp(sigma);
cprintf('*cyan*','Nodal Reactions =\n');
disp(R');