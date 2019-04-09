% 为粒子群优化算法生成合适的粒子，每个粒子就是航班序列
function G=shengchenglizi(xunhuancishu)
%% 飞机属性匹配，存储到矩阵中,data.xls的sheet4中
%% 飞机属性匹配，存储到矩阵中,data.xls的sheet4中
[num1,txt1,raw1] = xlsread('e:\data.xlsx');%将excel表格中所有飞机航班数据读取出来
[num2,txt2,raw2] = xlsread('e:\data.xlsx',3);%将excel表格中所有接机口数据读取出来
data_feijileibie=cell(303,1);%飞机类别，宽窄机型
data_feijileibie=raw1(:,13);
data_feijidaoda=cell(303,1);%飞机到达类型
data_feijidaoda=raw1(:,5);
data_feijichufa=cell(303,1);%飞机出发类型
data_feijichufa=raw1(:,10);
data_jikouleibie=cell(66,1);%接机口类别
data_jikouleibie=raw2(:,6);
data_jikoudaoda=cell(66,1);%接机口到达类型
data_jikoudaoda=raw2(:,4);
data_jikouchufa=cell(66,1);%接机口到达类型
data_jikouchufa=raw2(:,5);
time_feijipaixu=cell(303,1);%飞机到达时间分钟
time_feijipaixu=raw1(:,14);
%定义飞机与接机口属性匹配矩阵
jieguo_pipei=zeros(303,69);
for i=1:303
    for j=1:69
        if(data_feijileibie{i,1}==data_jikouleibie{j,1})
            switch data_jikoudaoda{j,1}
                case 'D, I'
                     switch data_jikouchufa{j,1}
                         case 'D, I'
                             jieguo_pipei(i,j)=1;
                         otherwise
                             if(data_feijichufa{i,1}==data_jikouchufa{j,1})
                                  jieguo_pipei(i,j)=1;
                             else
                                  jieguo_pipei(i,j)=0;
                             end
                     end
                otherwise
                    if(data_feijidaoda{i,1}==data_jikoudaoda{j,1})
                        switch data_jikouchufa{j,1}
                            case 'D, I'
                                 jieguo_pipei(i,j)=1;
                            otherwise
                                 if(data_feijichufa{i,1}==data_jikouchufa{j,1})
                                     jieguo_pipei(i,j)=1;
                                 else
                                     jieguo_pipei(i,j)=0;
                                 end
                        end
                    else
                         jieguo_pipei(i,j)=0;
                    end
            end
        else
              jieguo_pipei(i,j)=0;
        end          
%         jieguo_pipei(i,j)   %调试
%              data_jikoudaoda{j,1}
%             data_jikouchufa{j,1}
%             j
    end
end
% xlswrite('e:\data.xlsx', jieguo_pipei,4);%飞机号与登机口存储到表的sheet4
%% 时间匹配
date_feijidaoda=cell(303,1);%飞机到达日期
date_feijidaoda=raw1(:,2);
date_daoda=zeros(303,1);
for i=1:303
    switch date_feijidaoda{i,1}
        case '2018/1/19'
            date_daoda(i,1)=0;
        case '2018/1/20'
            date_daoda(i,1)=1;
    end
end
time_feijidaoda=cell(303,1);%飞机到达时间
time_feijidaoda=raw1(:,3);
time_daoda=zeros(303,1);
for i=1:303
    if(isa(time_feijidaoda{i,1},'char')==1)
        S_daoda = regexp(time_feijidaoda{i,1}, '\:', 'split');
        hour_daoda=str2num(char(S_daoda(1)));
        miniute_daoda=str2num(char(S_daoda(2)));
        time_daoda(i,1)=hour_daoda*60+miniute_daoda;
    elseif(isa(time_feijidaoda{i,1},'double')==1)
        time_daoda(i,1)=time_feijidaoda{i,1}*24*60;
    end
end
 global fenzhong_daoda;
 fenzhong_daoda=zeros(303,1);
fenzhong_daoda=date_daoda*24*60+time_daoda;
% xlswrite('e:\data.xlsx', fenzhong_daoda,1,'N1:N303');%飞机出发时间存储到表的sheet1
%飞机出发时间
date_feijichufa=cell(303,1);%飞机到达日期
date_feijichufa=raw1(:,7);
date_chufa=zeros(303,1);
for i=1:303
    switch date_feijichufa{i,1}
        case '2018/1/20'
            date_chufa(i,1)=1;
        case '2018/1/21'
            date_chufa(i,1)=2;
    end
end
time_feijichufa=cell(303,1);%飞机到达时间
time_feijichufa=raw1(:,8);
time_chufa=zeros(303,1);
for i=1:303
    if(isa(time_feijichufa{i,1},'char')==1)
        S_chufa = regexp(time_feijichufa{i,1}, '\:', 'split');
        hour_chufa=str2num(char(S_chufa(1)));
        miniute_chufa=str2num(char(S_chufa(2)));
        time_chufa(i,1)=hour_chufa*60+miniute_chufa;
    elseif(isa(time_feijichufa{i,1},'double')==1)
        time_chufa(i,1)=time_feijichufa{i,1}*24*60;
    end
end
global fenzhong_chufa;
fenzhong_chufa=zeros(303,1);
fenzhong_chufa=date_chufa*24*60+time_chufa;
%  xlswrite('e:\data.xlsx', fenzhong_chufa,1,'O1:O303');%飞机出发时间存储到表的sheet1
 %% 综合飞机属性以及时间匹配结果
  tongjikoufeiji=zeros(303,69);
 for j=1:69
     count=1;
     for i=1:303
         if(jieguo_pipei(i,j)==1)
             tongjikoufeiji(count,j)=i;
             count=count+1;
         end
     end
 end
%  xlswrite('e:\data.xlsx', tongjikoufeiji,5);%在同一个接机口的飞机数存储到表的sheet5
 feijinengqujikou=zeros(303,69);
 for i=1:303
     count=1;
     for j=1:69
         if(jieguo_pipei(i,j)==1)
             feijinengqujikou(i,count)=j;
             count=count+1;
         end
     end
 end
% xlswrite('e:\data.xlsx',feijinengqujikou,6);%飞机能去登机口的数目，也就是着色存储到表的sheet6
%% 列出时间冲突的飞机, 将处理好的飞机冲突转化成邻接矩阵
% feiji_shijianchongtu=zeros(303,138);
count_feijitongjikou=zeros(1,69);
linjiejuzhen=zeros(303,303);%定义邻接矩阵
juzhen_daochushijian=xlsread('e:\data.xlsx',1,'N1:O303');
for j=1:69
    count_feijitongjikou(1,j)=0;
    for i=1:303
        if(tongjikoufeiji(i,j)~=0)
            count_feijitongjikou(1,j)=count_feijitongjikou(1,j)+1;
        end
    end
end
for j=1:69
           juzhen_paixu=zeros(count_feijitongjikou(1,j),3);
           for l=1:count_feijitongjikou(1,j)
               juzhen_paixu(l,1)=tongjikoufeiji(l,j);       
           end
       for i=1: count_feijitongjikou(1,j)   %赋值
           juzhen_paixu(i,2)=juzhen_daochushijian(tongjikoufeiji(i,j),1);
           juzhen_paixu(i,3)=juzhen_daochushijian(tongjikoufeiji(i,j),2);
       end
       for i=1: count_feijitongjikou(1,j)   %冒泡排序
        for k=1:count_feijitongjikou(1,j)-i
               if(juzhen_paixu(k,2)>juzhen_paixu(k+1,2))
                   temp=juzhen_paixu(k,:);
                   juzhen_paixu(k,:)=juzhen_paixu(k+1,:);
                   juzhen_paixu(k+1,:)=temp;
               end
        end
      end
%      xlswrite('e:\1.xlsx',juzhen_paixu);
       for i=1:count_feijitongjikou(1,j)
           for k=(i+1):count_feijitongjikou(1,j)
              if((juzhen_paixu(i,3)+45)<=juzhen_paixu(k,2))
                  linjiejuzhen(juzhen_paixu(i,1),juzhen_paixu(k,1))=0;
              else
                   linjiejuzhen(juzhen_paixu(i,1),juzhen_paixu(k,1))=1;
              end
           end
       end
end
%  xlswrite('e:\data.xlsx',linjiejuzhen,7);%存储邻接矩阵
%% 以时间序列去安排飞机去安排航班
for c_gongdiaoyong=1:xunhuancishu
shijianweixu=zeros(303,2);
for i=1:303
   shijianweixu(i,1)=i;
    shijianweixu(i,2)=time_feijipaixu{i,1};
end
for i=1:303
    for j=1:303-i
        if(shijianweixu(j,2)>shijianweixu(j+1,2))
            temp=shijianweixu(j+1,:);
            shijianweixu(j+1,:)=shijianweixu(j,:);
            shijianweixu(j,:)=temp;
        end
    end
end
%feijizhuose=xlsread('e:\data.xlsx',6);   %从表中读取已处理好的飞机对应登机位数组
feijizhuose=feijinengqujikou;
 xjuzhen=zeros(303,69);%行数表示为飞机数量，列数为登机位数量
 hangbanxulie=zeros(1,303);%航班序列(b1,b2,....,bn),用于粒子群算法优化
 
 for a=1:303
    countfeijizhuose=count_feijizhuose(feijizhuose);  % 统计每架飞机对应的登机位个数
     hengzuobiao=shijianweixu(a,1);%定义X的i
     if(countfeijizhuose(hengzuobiao,1)~=0)   
          num=countfeijizhuose(hengzuobiao,1);
          b=round(rand(1,1)*(num-1))+1;%此处取随机整数，赋予随机性
          zongzuobiao=feijizhuose(hengzuobiao,b);%定义X的j
           xjuzhen(hengzuobiao,zongzuobiao)=1;   %X i,j矩阵
          hangbanxulie(1,hengzuobiao)=zongzuobiao; %航班序列
             %此处调用邻接矩阵，将与无向图的第i个定点相邻的顶点(飞机)去掉相应的着色(登机位)
             for k=1:303
                 if(linjiejuzhen(hengzuobiao,k)==1)
                     for m=1:countfeijizhuose(k,1)
                         if(feijizhuose(k,m)==zongzuobiao)
                             feijizhuose(k,m)=0;
                             
                             %此处把数组元素向前缩进，实现链表功能
                             if(countfeijizhuose(k,1)-m>=0)
                                 for n=1:(countfeijizhuose(k,1)+1-m)
                                     feijizhuose(k,m+n-1)=feijizhuose(k,m+n);
                                     countfeijizhuose=count_feijizhuose(feijizhuose); %及时更新
                                 end
                               
                             end
                             
                         end
                     end
                 end
             end
     end
 end
 G= hangbanxulie;
 end