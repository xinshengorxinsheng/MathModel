function tu_plot(rel,control)
%由邻接矩阵画图
%输入为邻接矩阵，必须为方阵；
%第二个输入为控制量，0表示无向图，1表示有向图。默认值为0
 
r_size=size(rel);
if nargin<2
    control=0;
end
if r_size(1)~=r_size(2)
    disp('Wrong Input! The input must be a square matrix!');
    return;
end
len=r_size(1);
 
rho=10;%限制图尺寸的大小
r=2/1.05^len;%点的半径
theta=0:(2*pi/len):2*pi*(1-1/len);
[pointx,pointy]=pol2cart(theta',rho);
theta=0:pi/36:2*pi;
[tempx,tempy]=pol2cart(theta',r);
point=[pointx,pointy];
hold on
for i=1:len
    temp=[tempx,tempy]+[point(i,1)*ones(length(tempx),1),point(i,2)*ones(length(tempx),1)];
    plot(temp(:,1),temp(:,2),'r');
    text(point(i,1)-0.3,point(i,2),num2str(i));
    %画点
end
for i=1:len
    for j=1:len
        if rel(i,j)
            link_plot(point(i,:),point(j,:),r,control);
            %连接有关系的点
        end
    end
end
set(gca,'XLim',[-rho-r,rho+r],'YLim',[-rho-r,rho+r]);
axis off