[num1,txt1,raw1] = xlsread('e:\data.xlsx');%将excel表格中所有飞机航班数据读取出来
particlesize=10;

hangbanxulie=globalbest_x;
x=hangbanxulie;
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
 disp(strcat('登机口数量最少为','=',69-num2str(count_xjuzhen)));
%% 宽窄体机分别画线状图
huitu_kuan=zeros(1,69);
huitu_zhai=zeros(1,69);
 count_kuan_ji=0;
 count_zhai_ji=0;
for j=1:69
    count_kuan=0;
    count_zhai=0;
    for i=1:303
         if(fangzheng(i,j)==1)
             if(strcmp(raw1{i,13},'W'))
                 count_kuan=count_kuan+1;
             elseif(strcmp(raw1{i,13},'N'))
                 count_zhai=count_zhai+1;
             end
         end
    end
    huitu_kuan(1,j)=count_kuan;
    count_kuan_ji=count_kuan_ji+count_kuan;
    huitu_zhai(1,j)=count_zhai;
    count_zhai_ji=count_zhai_ji+count_zhai;
end
figure(1)
% x=[1:69,1:69];
% y=[huitu_kuan*2,huitu_zhai*2];
% stairs(x,y);
plot(1:69,huitu_kuan*2,'r-');
hold on;
plot(1:69,huitu_zhai*2,'g-');
legend('宽体机线状图','窄体机线状图');
xlabel('登机位');ylabel('航班数量');
title('问题二登机口的宽窄机航班数量对比');
grid on;
figure(3)
kuanzhaiji_bingtu=[count_kuan_ji*2,count_zhai_ji*2];
labels={'宽体机','窄体机'};
pie(kuanzhaiji_bingtu,labels);
title('问题二登机口的宽窄机航班数量比例图');