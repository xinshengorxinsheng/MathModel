clc;clear all;close all;
tic;                              %程序运行计时
E0=0.001;                        %允许误差
MaxNum=100;                                                     %粒子最大迭代次数
narvs=1;                                                               %目标函数的自变量个数
particlesize=30;                                                   %粒子群规模
c1=2;                                                                    %每个粒子的个体学习因子，也称为加速常数
c2=2;                                                                    %每个粒子的社会学习因子，也称为加速常数
w=0.6;                                                                   %惯性因子
linjiejuzhen=xlsread('e:\data.xlsx',7);
bianyiquji=xlsread('e:\data.xlsx',6);
% 判断变异取集的个数
countbianyiquji=zeros(1,303);
for i=1:303
    count_bianyiquji=0;
    for j=1:69
        if(bianyiquji(i,j)~=0)
            count_bianyiquji=count_bianyiquji+1;
        end
    end
    countbianyiquji(1,i)=count_bianyiquji;
end

% vmax=0.8;                                                   %粒子的最大飞翔速度
for i=1:particlesize
    [x(i,:)]=shengchenglizi(1);                       %粒子所在的位置
end
% v=2*rand(particlesize,303);                               %粒子的飞翔速度
%目标函数
for i=1:particlesize
        f(i)=fitness(x(i,:));  
end
personalbest_x=x;
personalbest_faval=f;
[globalbest_faval i]=min(personalbest_faval);
globalbest_x=personalbest_x(i,:);
k=1;
while k<=MaxNum
    for i=1:particlesize
%         for j=1:narvs
            f(i)=fitness(x(i,:));
%         end
        if f(i)<personalbest_faval(i) %判断当前位置是否是历史上最佳位置
            personalbest_faval(i)=f(i);
            personalbest_x(i,:)=x(i,:);
        end
    end
    [globalbest_faval i]=min(personalbest_faval);
    globalbest_x=personalbest_x(i,:);
    for i=1:particlesize %更新粒子群里每个个体的最新位置
       feijihao=round(rand(1,1)*(302))+1;%选择一个点变异
       select_bianyi=round(rand(1,1)*(countbianyiquji(feijihao)-1))+1;%这个飞机所对应的航班港口
       bianyi_tihuan=bianyiquji(select_bianyi);
       flag_bianyi_tihuan=true;
       select_jiaocha=round(rand(1,2)*302)+1;%选择基因片段交叉的位置，两处位置
       jiaocha_tihuan=zeros(1,2);
       flag_jiaocha_tihuan=true;
       for j=1:303     %判断能否变异
           if(x(i,j)==bianyi_tihuan)
               if(linjiejuzhen(feijihao,j)==1)
                   flag_bianyi_tihuan=false;
                   break;
               else
                   continue;
               end
           else   
               continue;
           end
       end
       if(flag_bianyi_tihuan)
           x(i,feijihao)=bianyi_tihuan;%执行变异
       end
       for j=1:2
            jiaocha_tihuan(1,j)=globalbest_x(1, select_jiaocha(1,j));
            for k=1:303     %判断能否交叉
                if(x(i,k)==jiaocha_tihuan(1,j))
                     if(linjiejuzhen(select_jiaocha(1,j),k)==1)
                         flag_jiaocha_tihuan=false;
                         break;
                     else
                         continue;
                     end
                else
                    continue;
                end
            end
       end
        if(flag_jiaocha_tihuan)
            for j=1:2
                x(i,select_jiaocha(1,j))= jiaocha_tihuan(1,j);%执行交叉
            end
        end
    end
    if 1/abs(globalbest_faval)<E0,break,end%此处需要注意
    k=k+1;
end
Value1=-globalbest_faval-1; Value1=num2str(Value1);
% strcat指令可以实现字符的组合输出
disp(strcat('the maximum value','=',Value1));
%输出最大值所在的横坐标位置
Value2=globalbest_x; Value2=num2str(Value2);
disp(strcat('the corresponding coordinate','=',Value2));

x=globalbest_x;
count=0;
fangzheng=zeros(303,69);
for i=1:303
    if(x(1,i)~=0)
        count=count+1;
        fangzheng(i,x(1,i))=1;
    end
end
disp(strcat('所安排的最大航班数','=',num2str(count)));
count_xjuzhen=0;
 for h=1:69
    if(sum(fangzheng(:,h))==0)
        count_xjuzhen=count_xjuzhen+1;
    end
 end
 disp(strcat('登机口数量最少为','=',num2str(count_xjuzhen)));

% 画航班 登机口 
hangbanxulie=globalbest_x;
figure;
axis([0 4000 0 70]);
juzhen=xlsread('e:\data.xls',1,'N1:O303');
cmd=0;
for i=1:303
    if(hangbanxulie(1,i)~=0)
        cmd=cmd+1;
    end
end
huatu1=zeros(cmd,2);
count=0;
for i=1:303
    if(hangbanxulie(1,i)~=0)
        count=count+1;
        huatu1(count,1)=i;
        huatu1(count,2)=hangbanxulie(1,i);
    end
end
for i=1:cmd
    rectangle('Position',[juzhen(huatu1(i,1),1),huatu1(i,2),juzhen(huatu1(i,1),2)-juzhen(huatu1(i,1),1),1],'Curvature',[1 1],'EdgeColor','b','LineWidth',2);
end
xlabel('航班时刻');ylabel('登机口');title('航班机位分配图');
grid on;toc;