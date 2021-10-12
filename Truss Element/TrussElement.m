n=input('Enter the number of Truss Elements = ');
E=[];
L=[];
A=[];
F=[];
U=[];
Theta=[];
nodes={};
for i=1:n
    E(i)=input(['Enter E',num2str(i),' (N/mm2) = ']);
    L(i)=input(['Enter L',num2str(i),' (mm) = ']);
    A(i)=input(['Enter A',num2str(i),' (mm2) = ']);
    Theta(i)=input(['Enter Theta',num2str(i),' (wrt positive X axis)',' (deg) = ']);
    nodes{i}=input(['Enter node numbers for element ',num2str(i),' [start no,end no] =']);
end
cprintf('*cyan*','For Displacements >>>>\nEnter "0" for FIXED SUPPORTS (zero displacement) and "1" for UNKNOWN DISPLACEMENTS\n')
for i=1:max(cell2mat(nodes))
    F(2*i-1)=input(['Enter Fx',num2str(i),' ( Horizontal Force at node ',num2str(i),')',' (N) = ']);
    F(2*i)=input(['Enter Fy',num2str(i),' (Vertical Force at node ',num2str(i),')',' (N) = ']);
    U(2*i-1)=input(['Enter U',num2str(i),' (Horizontal Displacement at node ',num2str(i),')',' (mm) = ']);
    U(2*i)=input(['Enter V',num2str(i),' (Vertical Displacement at node ',num2str(i),')',' (mm) = ']);
end
[k,KG,U,KR,epsilon,sigma,R]=TrussSolver(E,L,A,Theta,F,U,nodes);
cprintf('*cyan*','Global Element Stiffness Matrix =\n');
disp(KG);
cprintf('*cyan*','Nodal Displacement =\n');
disp(U);
cprintf('*cyan*','Element Stress =\n');
disp(sigma);
cprintf('*cyan*','Nodal Reactions =\n');
disp(R');

    