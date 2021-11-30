sx=0;
syms s real
if sx==1
    syms psi theta phi real
else
    psi=0;
end
m=220/9.8;
I=eye(3);
I(1,1)=0.07335;
I(2,2)=0.25068;
I(3,3)=0.25447;
invI=inv(I);
if sx==1
    A=sym(zeros(13,13));
    B=sym(zeros(13,12));
else
    A=(zeros(13,13));
    B=(zeros(13,12));
end
R=[cos(psi),sin(psi),0;
    -sin(psi),cos(psi),0;
    0,0,1];
A(1:3,7:9)=R;
A(4:6,10:12)=eye(3);
A(12,13)=1;
FootPos=[0.17, -0.14, -0.24;
    0.17, 0.14, -0.24;
    -0.17, -0.14, -0.24;
    -0.17, 0.14, -0.24;];
C=eye(13);
for i=1:4
   W=R*FootPos(i,:)';
   FootPosW=[0,-W(3),W(2);W(3),0,-W(1);-W(2),W(1),0];
   if i==1 ||i==2  ||i==3  ||i==4    
       B(10:12,(i-1)*3+1:(i-1)*3+3)=eye(3)/m;
       B(7:9,(i-1)*3+1:(i-1)*3+3)=R*invI*(R')*FootPosW;
   end
end
% CONT=ctrb(A,B);
% rank(CONT)
rank([B,A*B]);%3、4条腿时B矩阵秩为6，系统能控性为12(除了重力)，2条腿时B矩阵秩为5，系统能控性为10，1条腿时B矩阵秩为3，系统能控性为6
%系统为完全能观
Q=eye(13);
sI=eye(13)*s;
eAt=ilaplace(inv(sI-A));
[V,D]=eig(A);%A特征值全为0
[V,J] = jordan(A);
f1=[0,0,220/4];
f2=[0,0,220/4];
f3=[0,0,220/4];
f4=[0,0,220/4];
u=[f1,f2,f3,f4];
IC=[0,0,0,0,0,0.24,0,0,0,0,0,0,-9.8];%Initialcondition
Gs=C*inv(sI-A)*B;
jd=zeros(1,12);
for i=1:12
jd(i)=-0.1*i;%极点必须互异才能使用place配置
end
A1=A(1:12,1:12);
B1=B(1:12,:);
K1=place(A1,B1,jd);%针对前12行(不包括重力(不可控)进行极点配置)
K=[K1,zeros(12,1)];
ABK=A-B*K;
EC=[0,0,0,0,0,0.24,0,0,0,1,1,0,-9.8];%MPC期望输出