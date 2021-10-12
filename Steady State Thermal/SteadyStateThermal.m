n=input('Enter the number of Bar Elements = ');
K=[];
L=[];
A=[];
modes=[];
h=[];
Q=[];
T=[];
Tc=[];
for i=1:n
    K(i)=input(['Enter K',num2str(i),' (N/mm2) = ']);
    L(i)=input(['Enter L',num2str(i),' (mm) = ']);
    A(i)=input(['Enter A',num2str(i),' (mm2) = ']);
end
cprintf('*red*','For modes of heat transfer >>>>\nEnter the corresponding numbers:\n1.Source node\n2.Conduction\n3.Conducion+Convection\n-------------------------------------------------------------\nFor Temperature >>>>\nEnter the corresponding value for "KNOWN" nodes and "1" for "UNKNOWN" nodes.\n')
for i=1:n+1
    modes(i)=input(['Enter mode of heat transfer at node ',num2str(i),' = ']);
    T(i)=input(['Enter temperature T',num2str(i),' (deg C) = ']);
    Q(i)=input(['Enter displacement Q',num2str(i),' (mm) = ']);
    if(modes(i)==3)
        h(i)=input(['Enter  h',num2str(i),' (W/m2K) = ']);
        Tc(i)=input(['Enter Convection Temperaure Tc',num2str(i),' (deg C) = ']);
    else
        h(i)=0;
        Tc(i)=0;
    end
end
[k,KG,R,T]=SteadyStateThermalSolver(K,L,A,modes,h,Q,T,Tc);

cprintf('*cyan*','Global Element Stiffness Matrix =\n');
disp(KG);
cprintf('*cyan*','Nodal Temperature =\n');
disp(T);
cprintf('*cyan*','Load Vector =\n');
disp(R);