% 给旅客分类打标签
[num1,txt1,raw1] = xlsread('e:\data.xls',1);%将excel表格中所有飞机航班数据读取出来
[num3,txt3,raw3] = xlsread('e:\data.xls',2);%将excel表格中所有旅客数据读取出来
hangbanhao_daoda=cell(303,1);%飞机到达航班号
hangbanhao_daoda=raw1(:,4);
hangbanhao_chufa=cell(303,1);%飞机出发航班号
hangbanhao_chufa=raw1(:,9);
lvke_daoda=cell(1733,1);%旅客到达航班号
lvke_daoda=raw3(:,3);
lvke_chufa=cell(1733,1);%旅客出发航班号
lvke_chufa=raw3(:,5);
feijileixing_daoda=cell(303,1);%飞机到达类型
feijileixing_daoda=raw1(:,5);
feijileixing_chufa=cell(303,1);%飞机出发类型
feijileixing_chufa=raw1(:,10);
lvke_biaojian=cell(1733,5);
lvke_renshu=cell(1733,1);%旅客人数
lvke_renshu=raw3(:,2);


x=zeros(1733,2);
for i=1:1733
    for j=1:303
        if( strcmp(hangbanhao_daoda{j},lvke_daoda{i}))
            x(i,1)=j;
        end
    end
end
for i=1:1733
    for j=1:303
        if( strcmp(hangbanhao_chufa{j},lvke_chufa{i}))
            x(i,2)=j;
        end
    end
end
% 此处调用航班分配序列，有优化算法即取最优的分配序列
A=xlsread('e:\jieguo.xlsx',2,'A2:A304');
hangbanxulie=A';
for i=1:1733
    if(x(i,1)~=0&& x(i,2)~=0)
         if(hangbanxulie(1,x(i,1))>28)
            lvke_biaojian{i,2}='S';
            lvke_biaojian{i,1}=feijileixing_daoda{x(i,1)};
         else
            lvke_biaojian{i,2}='T';
            lvke_biaojian{i,1}=feijileixing_daoda{x(i,1)};
         end
    end
   
         if(hangbanxulie(1,x(i,2))>28)
            lvke_biaojian{i,3}='S';
            lvke_biaojian{i,4}=feijileixing_chufa{x(i,2)};
         else
             lvke_biaojian{i,3}='T';
             lvke_biaojian{i,4}=feijileixing_chufa{x(i,2)};
         end
         
          lvke_biaojian{i,5}=lvke_renshu{i};
end

for i=1:1733
    lvke_biaojian{i,6}=strcat( lvke_biaojian{i,1}, lvke_biaojian{i,2}, lvke_biaojian{i,3}, lvke_biaojian{i,4});
end
for i=1:1733
    switch  lvke_biaojian{i,6}
        case 'DTTD'
            lvke_biaojian{i,7}=15;
            lvke_biaojian{i,8}=0;
        case 'DTSD'
            lvke_biaojian{i,7}=20;
            lvke_biaojian{i,8}=1;
        case 'DTTI'
            lvke_biaojian{i,7}=35;
            lvke_biaojian{i,8}=0;
         case 'DTSI'
            lvke_biaojian{i,7}=40;
            lvke_biaojian{i,8}=1;
         case 'DSTD'
            lvke_biaojian{i,7}=20;
            lvke_biaojian{i,8}=1;
         case 'DSSD'
            lvke_biaojian{i,7}=15;
            lvke_biaojian{i,8}=0;
        case 'DSTI'
            lvke_biaojian{i,7}=40;
            lvke_biaojian{i,8}=1;
        case 'DSSI'
            lvke_biaojian{i,7}=35;
            lvke_biaojian{i,8}=0;
        case 'ITTD'
            lvke_biaojian{i,7}=35;
            lvke_biaojian{i,8}=0;
        case 'ITSD'
            lvke_biaojian{i,7}=40;
            lvke_biaojian{i,8}=1;
        case 'ITTI'
            lvke_biaojian{i,7}=20;
            lvke_biaojian{i,8}=0;
         case 'ITSI'
            lvke_biaojian{i,7}=30;
            lvke_biaojian{i,8}=1;
        case 'ISTD'
            lvke_biaojian{i,7}=40;
            lvke_biaojian{i,8}=1;
         case 'ISSD'
            lvke_biaojian{i,7}=45;
            lvke_biaojian{i,8}=2;
         case 'ISTI'
            lvke_biaojian{i,7}=30;
            lvke_biaojian{i,8}=1;
         case 'ISSI'
            lvke_biaojian{i,7}=20;
            lvke_biaojian{i,8}=0;
    end
end
count=0;
qiuhe=0;
count1=0;
[num2,txt2,raw2] =xlsread('e:\jieguo.xlsx',2,'B2:B1734');
for i=1:1733
     if(x(i,1)~=0&& x(i,2)~=0)
          if(hangbanxulie(1,x(i,1))~=0&&hangbanxulie(1,x(i,2))~=0)
               
               qiuhe=qiuhe+lvke_biaojian{i,5}*lvke_biaojian{i,7};
              lvke_biaojian{i,8}= lvke_biaojian{i,5}*lvke_biaojian{i,7};
              if(raw2{i,1}<lvke_biaojian{i,8})
                  count=count+1;
              end
              if(raw2{i,1}~=0)
                  count1=count1+1;
              end
              
          end
     end
end
count
 qiuhe