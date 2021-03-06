function [H,flag]=point2line(p,A,B)
% [H,flag]=piont2line(p,A,B)
% p是实际坐标，A是线段第一个坐标，B是线段第二个坐标
% 返回H是垂直距离，flag是方向，1是右边，0是重合，-1左左边
x1=A(1);
y1=A(2);
x2=B(1);
y2=B(2);
x=p(1);
y=p(2);
H =abs((y2-y1)*x + (x1-x2)*y + (x2*y1-x1*y2))/sqrt((y2-y1)^2+(x1-x2)^2);
M=[y2-y1,x1-x2];
AC=[x-x1,y-y1];
if AC*M'>0
    flag=1;
elseif AC*M'==0
    flag=0;
else
    flag=-1;
end
end


% 设A(x1,y1)和B(x2,y2)
% 直线AB方程为：(y-y1)/(x-x1)=(y2-y1)/(x2-x1)
% 整理：(y2-y1)x1+(x1-x2)y+(x2y1-x1y2)=0
% 由点到直线距离公式：│Ax＋By＋C│/(A*A＋B*B)^0.5得：
% 设点(x,y)到直线BB的距离为H,则：
% H =│(y2-y1)x＋(x1-x2)y＋(x2y1-x1y2)│/((y2-y1)*2＋(x1-x2)^2)^0.5


% 构造一个向量与向量A->B垂直.称其为 向量M.
% 则 下两个内积异号：
% (向量A->C)*M 与 （向量A->C')*M 异号 
% 补充：
% 设向量A->B=（x,y）,取 M = (y,-x) 指向右边,
% 凡是 (向量A->C)*M > 0 的C都在右边.
% 凡是 (向量A->C)*M < 0 的C都在左边. 