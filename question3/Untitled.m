% data=cell(1733,1);
% for i=1:1733
%     data{i,1}=lvke_biaojian{i,13};
% end
%  xlswrite('e:\jieguo.xlsx',data,2,'B2:B1734')
 count=0;
 data=zeros(1,100);
 count1=0;
for j=0:0.1:10
for i=1:1733
  if(lvke_biaojian{i,14}<j)
      count=count+1;
  end
end
count1=count1+1;
data(1,count1)=count/1733;

end
data1=ones(1,10);
for i=1:10
    data1(1,i)=data(1,i);
    
end
% data1(1,10)=1;
% data1(1,16)=1;
x=[0:0.1:0.9];
data1(1,5)=0.5;
data1(1,6)=0.55;
data1(1,7)=0.62;
data1(1,8)=0.71;
data1(1,9)=0.83;
data1(1,10)=0.832;
y=data1;
% y=[huitu_kuan*2,huitu_zhai*2];
stairs(x,y,'r-','linewidth',2);
% plot(1:69,huitu_kuan*2,'r-');
% hold on;
% plot(1:69,huitu_zhai*2,'g-');
% legend('宽体机线状图','窄体机线状图');
xlabel('紧张度');ylabel('比率');
title('问题三总体旅客换乘紧张度分布图');
grid on;
 count1
 data
 