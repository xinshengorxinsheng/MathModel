% 给旅客分类打标签
[num1,txt1,raw1] = xlsread('e:\data.xls',1);%将excel表格中所有飞机航班数据读取出来
[num3,txt3,raw3] = xlsread('e:\data.xls',2);%将excel表格中所有旅客数据读取出来
[num2,txt2,raw2] = xlsread('e:\data.xls',3);%将excel表格中接机口数据读取出来
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
time_feijidaoda=cell(303,1);%前一航班到达时间
time_feijidaoda=raw1(:,14);
time_feijichufa=cell(303,1);%后一航班出发时间
time_feijichufa=raw1(:,15);


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

hangbanxulie=shengchenglizi(1);
for i=1:1733
    if(x(i,1)~=0&& x(i,2)~=0)
         if(hangbanxulie(1,x(i,1))>28)
            lvke_biaojian{i,2}='S';
            lvke_biaojian{i,1}=feijileixing_daoda{x(i,1)};
         else
            lvke_biaojian{i,2}='T';
            lvke_biaojian{i,1}=feijileixing_daoda{x(i,1)};
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

for i=1:1733
   if(x(i,1)~=0&& x(i,2)~=0)
        if(hangbanxulie(1,x(i,1))<=9)
            lvke_biaojian{i,9}='TN';
        elseif(hangbanxulie(1,x(i,1))>9&&hangbanxulie(1,x(i,1))<=19)
            lvke_biaojian{i,9}='TC';
        elseif(hangbanxulie(1,x(i,1))>19&&hangbanxulie(1,x(i,1))<=28)
            lvke_biaojian{i,9}='TS';
        elseif(hangbanxulie(1,x(i,1))>=29&&hangbanxulie(1,x(i,1))<=38) 
            lvke_biaojian{i,9}='SN';
        elseif(hangbanxulie(1,x(i,1))>=39&&hangbanxulie(1,x(i,1))<=48)
             lvke_biaojian{i,9}='SC';
        elseif(hangbanxulie(1,x(i,1))>=49&&hangbanxulie(1,x(i,1))<=58)
             lvke_biaojian{i,9}='SS';
       elseif(hangbanxulie(1,x(i,1))>=59&&hangbanxulie(1,x(i,1))<=69)
             lvke_biaojian{i,9}='SE';
        end
         
        if(hangbanxulie(1,x(i,2))<=9)
            lvke_biaojian{i,10}='TN';
        elseif(hangbanxulie(1,x(i,2))>9&&hangbanxulie(1,x(i,2))<=19)
            lvke_biaojian{i,10}='TC';
        elseif(hangbanxulie(1,x(i,2))>19&&hangbanxulie(1,x(i,2))<=28)
            lvke_biaojian{i,10}='TS';
        elseif(hangbanxulie(1,x(i,2))>=29&&hangbanxulie(1,x(i,2))<=38) 
            lvke_biaojian{i,10}='SN';
        elseif(hangbanxulie(1,x(i,2))>=39&&hangbanxulie(1,x(i,2))<=48)
             lvke_biaojian{i,10}='SC';
        elseif(hangbanxulie(1,x(i,2))>=49&&hangbanxulie(1,x(i,2))<=58)
             lvke_biaojian{i,10}='SS';
       elseif(hangbanxulie(1,x(i,2))>=59&&hangbanxulie(1,x(i,2))<=69)
             lvke_biaojian{i,10}='SE';
         end
   end
end
for i=1:1733
   if(x(i,1)~=0&& x(i,2)~=0)
        switch lvke_biaojian{i,9}
            case 'TN'
                switch lvke_biaojian{i,10}
                    case 'TN'
                        lvke_biaojian{i,11}=10;
                    case 'TC'
                         lvke_biaojian{i,11}=15;
                    case 'TS'
                         lvke_biaojian{i,11}=20;
                    case 'SN'
                         lvke_biaojian{i,11}=25;
                    case 'SC'
                         lvke_biaojian{i,11}=20;
                    case 'SS'
                         lvke_biaojian{i,11}=25;
                    case 'SE'
                         lvke_biaojian{i,11}=25;
                end
            case 'TC'
                switch lvke_biaojian{i,10}
                    case 'TN'
                         lvke_biaojian{i,11}=15;
                    case 'TC'
                         lvke_biaojian{i,11}=10;
                    case 'TS'
                         lvke_biaojian{i,11}=15;
                    case 'SN'
                         lvke_biaojian{i,11}=20;
                    case 'SC'
                         lvke_biaojian{i,11}=15;
                    case 'SS'
                         lvke_biaojian{i,11}=20;
                    case 'SE'
                         lvke_biaojian{i,11}=20;
                end
            case 'TS'
                 switch lvke_biaojian{i,10}
                     case 'TN'
                         lvke_biaojian{i,11}=20;
                    case 'TC'
                         lvke_biaojian{i,11}=15;
                    case 'TS'
                         lvke_biaojian{i,11}=10;
                    case 'SN'
                         lvke_biaojian{i,11}=25;
                    case 'SC'
                         lvke_biaojian{i,11}=20;
                    case 'SS'
                         lvke_biaojian{i,11}=25;
                    case 'SE'
                         lvke_biaojian{i,11}=25;
                end
            case 'SN'
                switch lvke_biaojian{i,10}
                    case 'TN'
                         lvke_biaojian{i,11}=25;
                    case 'TC'
                         lvke_biaojian{i,11}=20;
                    case 'TS'
                         lvke_biaojian{i,11}=25;
                    case 'SN'
                         lvke_biaojian{i,11}=10;
                    case 'SC'
                         lvke_biaojian{i,11}=15;
                    case 'SS'
                         lvke_biaojian{i,11}=20;
                    case 'SE'
                         lvke_biaojian{i,11}=20;
                end
            case 'SC'
                switch lvke_biaojian{i,10}
                     case 'TN'
                         lvke_biaojian{i,11}=20;
                    case 'TC'
                         lvke_biaojian{i,11}=15;
                    case 'TS'
                         lvke_biaojian{i,11}=20;
                    case 'SN'
                         lvke_biaojian{i,11}=15;
                    case 'SC'
                         lvke_biaojian{i,11}=10;
                    case 'SS'
                         lvke_biaojian{i,11}=15;
                    case 'SE'
                         lvke_biaojian{i,11}=15;
                end 
            case 'SS'
                switch lvke_biaojian{i,10}
                    case 'TN'
                         lvke_biaojian{i,11}=25;
                    case 'TC'
                         lvke_biaojian{i,11}=20;
                    case 'TS'
                         lvke_biaojian{i,11}=25;
                    case 'SN'
                         lvke_biaojian{i,11}=20;
                    case 'SC'
                         lvke_biaojian{i,11}=15;
                    case 'SS'
                         lvke_biaojian{i,11}=10;
                    case 'SE'
                         lvke_biaojian{i,11}=20;
                end 
            case 'SE'
                 switch lvke_biaojian{i,10}
                     case 'TN'
                         lvke_biaojian{i,11}=25;
                    case 'TC'
                         lvke_biaojian{i,11}=20;
                    case 'TS'
                         lvke_biaojian{i,11}=25;
                    case 'SN'
                         lvke_biaojian{i,11}=20;
                    case 'SC'
                         lvke_biaojian{i,11}=15;
                    case 'SS'
                         lvke_biaojian{i,11}=20;
                    case 'SE'
                         lvke_biaojian{i,11}=10;
                end 
        end
   end
end
count=0;
qiuhe_zuiduanliucheng=0;
qiuhe_jiyun=0;
qiuhe_xingzou=0;
qiuhe_huanchengjinzhangdu=0;
qiuhe_hangbanlianjieshijian=0;
% huanchengshijian=zeros(1733,1);
for i=1:1733
     if(x(i,1)~=0&& x(i,2)~=0)
          if(hangbanxulie(1,x(i,1))~=0&&hangbanxulie(1,x(i,2))~=0)%港口号其中有一个等于零的就不再考虑
               count=count+1;
               qiuhe_zuiduanliucheng=qiuhe_zuiduanliucheng+lvke_biaojian{i,5}*lvke_biaojian{i,7};
               qiuhe_jiyun=qiuhe_jiyun+lvke_biaojian{i,5}*lvke_biaojian{i,8};
               qiuhe_xingzou=qiuhe_xingzou+lvke_biaojian{i,5}*lvke_biaojian{i,11};
               lvkehuanchengshijian=lvke_biaojian{i,5}*lvke_biaojian{i,7}+lvke_biaojian{i,5}*lvke_biaojian{i,8}+lvke_biaojian{i,5}*lvke_biaojian{i,11};
               lvke_biaojian{i,12}=lvkehuanchengshijian;
               hangbanlianjieshijian=time_feijichufa{x(i,2)}-time_feijidaoda{x(i,1)};
               qiuhe_hangbanlianjieshijian=qiuhe_hangbanlianjieshijian+hangbanlianjieshijian;
               lvke_biaojian{i,13}= hangbanlianjieshijian;
               huanchengjinchangdu=lvkehuanchengshijian/hangbanlianjieshijian;
               qiuhe_huanchengjinzhangdu=qiuhe_huanchengjinzhangdu+huanchengjinchangdu;
                lvke_biaojian{i,14}= huanchengjinchangdu;
                lvke_biaojian{i,16}=lvkehuanchengshijian;
                
          end
     end
end
pinjun_hangbanlianjieshijian=qiuhe_hangbanlianjieshijian/303;
pinjun_huanchengjinzhangdu=52.5/pinjun_hangbanlianjieshijian;
qiuhe_huanchengjinzhangdu
