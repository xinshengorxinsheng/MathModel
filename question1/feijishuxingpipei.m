%% �˳���������̰�ġ���������ݵ��㷨���㲢����õ�һ���(�������з���)
%% �ɻ�����ƥ�䣬�洢��������,data.xls��sheet4��
[num1,txt1,raw1] = xlsread('e:\data.xlsx');%��excel���������зɻ��������ݶ�ȡ����
[num2,txt2,raw2] = xlsread('e:\data.xlsx',3);%��excel���������нӻ������ݶ�ȡ����
data_feijileibie=cell(303,1);%�ɻ���𣬿�խ����
data_feijileibie=raw1(:,13);
data_feijidaoda=cell(303,1);%�ɻ���������
data_feijidaoda=raw1(:,5);
data_feijichufa=cell(303,1);%�ɻ���������
data_feijichufa=raw1(:,10);
data_jikouleibie=cell(66,1);%�ӻ������
data_jikouleibie=raw2(:,6);
data_jikoudaoda=cell(66,1);%�ӻ��ڵ�������
data_jikoudaoda=raw2(:,4);
data_jikouchufa=cell(66,1);%�ӻ��ڵ�������
data_jikouchufa=raw2(:,5);
time_feijipaixu=cell(303,1);%�ɻ�����ʱ�����
time_feijipaixu=raw1(:,14);
%����ɻ���ӻ�������ƥ�����
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
%         jieguo_pipei(i,j)   %����
%              data_jikoudaoda{j,1}
%             data_jikouchufa{j,1}
%             j
    end
end
 %xlswrite('e:\data.xlsx', jieguo_pipei,4);%�ɻ�����ǻ��ڴ洢������sheet4
%% ʱ��ƥ��
date_feijidaoda=cell(303,1);%�ɻ���������
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
time_feijidaoda=cell(303,1);%�ɻ�����ʱ��
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
% xlswrite('e:\data.xlsx', fenzhong_daoda,1,'N1:N303');%�ɻ�����ʱ��洢������sheet1
%�ɻ�����ʱ��
date_feijichufa=cell(303,1);%�ɻ���������
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
time_feijichufa=cell(303,1);%�ɻ�����ʱ��
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
 %xlswrite('e:\data.xlsx', fenzhong_chufa,1,'O1:O303');%�ɻ�����ʱ��洢������sheet1
 %% �ۺϷɻ������Լ�ʱ��ƥ����
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
%xlswrite('e:\data.xlsx', tongjikoufeiji,5);%��ͬһ���ӻ��ڵķɻ����洢������sheet5
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
 %xlswrite('e:\data.xlsx',feijinengqujikou,6);%�ɻ���ȥ�ǻ��ڵ���Ŀ��Ҳ������ɫ�洢������sheet6
%% �г�ʱ���ͻ�ķɻ�, �������õķɻ���ͻת�����ڽӾ���
% feiji_shijianchongtu=zeros(303,138);
count_feijitongjikou=zeros(1,69);
linjiejuzhen=zeros(303,303);%�����ڽӾ���
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
       for i=1: count_feijitongjikou(1,j)   %��ֵ
           juzhen_paixu(i,2)=juzhen_daochushijian(tongjikoufeiji(i,j),1);
           juzhen_paixu(i,3)=juzhen_daochushijian(tongjikoufeiji(i,j),2);
       end
       for i=1: count_feijitongjikou(1,j)   %ð������
        for k=1:count_feijitongjikou(1,j)-i
               if(juzhen_paixu(k,2)>juzhen_paixu(k+1,2))
                   temp=juzhen_paixu(k,:);
                   juzhen_paixu(k,:)=juzhen_paixu(k+1,:);
                   juzhen_paixu(k+1,:)=temp;
               end
        end
      end
     xlswrite('e:\1.xlsx',juzhen_paixu);
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
%xlswrite('e:\data.xlsx',linjiejuzhen,7);%�洢�ڽӾ���
%% ��ʱ������ȥ���ŷɻ�ȥ���ź���

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
feijizhuose=feijinengqujikou;
 xjuzhen=zeros(303,69);%������ʾΪ�ɻ�����������Ϊ�ǻ�λ����
 hangbanxulie=zeros(1,303);%��������(b1,b2,....,bn),��������Ⱥ�㷨�Ż�
  
 for a=1:303
    countfeijizhuose=count_feijizhuose(feijizhuose);  % ͳ��ÿ�ܷɻ���Ӧ�ĵǻ�λ����
     hengzuobiao=shijianweixu(a,1);%����X��i
     if(countfeijizhuose(hengzuobiao,1)~=0)   
          num=countfeijizhuose(hengzuobiao,1);
          b=round(rand(1,1)*(num-1))+1;%�˴�ȡ������������������
          zongzuobiao=feijizhuose(hengzuobiao,b);%����X��j
           xjuzhen(hengzuobiao,zongzuobiao)=1;   %X i,j����
          hangbanxulie(1,hengzuobiao)=zongzuobiao; %��������
             %�˴������ڽӾ��󣬽�������ͼ�ĵ�i���������ڵĶ���(�ɻ�)ȥ����Ӧ����ɫ(�ǻ�λ)
             for k=1:303
                 if(linjiejuzhen(hengzuobiao,k)==1)
                     for m=1:countfeijizhuose(k,1)
                         if(feijizhuose(k,m)==zongzuobiao)
                             feijizhuose(k,m)=0;
                             
                             %�˴�������Ԫ����ǰ������ʵ����������
                             if(countfeijizhuose(k,1)-m>=0)
                                 for n=1:(countfeijizhuose(k,1)+1-m)
                                     feijizhuose(k,m+n-1)=feijizhuose(k,m+n);
                                     countfeijizhuose=count_feijizhuose(feijizhuose); %��ʱ����
                                 end
                               
                             end
                             
                         end
                     end
                 end
             end
     end
 end
 %hangbanxulie
 count=0;
 for i=1:303
     for j=1:69
         if(xjuzhen(i,j)~=0)
             count=count+1;
         end
     end
 end
  count
 count1=0;
 for j=1:69
     if(sum(xjuzhen(:,j))==0)
         count1=count1+1;
     end
 end
 count1
 count2=0;
 data=zeros(303,2);
 for i=1:303
     if(hangbanxulie(1,i)~=0)
         count2=count2+1;
          data(count2,1)=i;
          data(count2,2)=hangbanxulie(1,i);
     end
 end
 count2  %��������һ����303���ɹ����䵽�ǻ��ڵķɻ�

 %% ��ͼ
%���ڽӾ�����������ͼ
figure(1);
c = sparse(linjiejuzhen); %ת����ϡ�������ʽ
view(biograph(c));
c = max(c,c'); %����ǶԳƵ�����ͼ
view(biograph(tril(c),[],'ShowArrows','off'));

 %��Xij[]��������ɢ��ͼ
 figure(2);
 scatter(data(:,1),data(:,2),'r');
axis([0 350 0 60]);
legend('�ɻ������������ͼ');
xlabel('�ɻ�������(��)');ylabel('�ǻ�����(��)');grid on;

% ��խ����ֱ���״ͼ
huitu_kuan=zeros(1,69);
huitu_zhai=zeros(1,69);
for j=1:69
    count_kuan=0;
    count_zhai=0;
    for i=1:303
         if(xjuzhen(i,j)==1)
             if(strcmp(raw1{i,13},'W'))
                 count_kuan=count_kuan+1;
             elseif(strcmp(raw1{i,13},'N'))
                 count_zhai=count_zhai+1;
             end
         end
    end
    huitu_kuan(1,j)=count_kuan;
    huitu_zhai(1,j)=count_zhai;
end
figure(3);
plot(1:69,huitu_kuan,'r-');
hold on;
plot(1:69,huitu_zhai,'g-');
legend('�������״ͼ','խ�����״ͼ');
xlabel('�ǻ�λ');ylabel('��������');

% ������ �ǻ��� 
figure(4);
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
    rectangle('Position',[juzhen(huatu1(i,1),1),huatu1(i,2),juzhen(huatu1(i,1),2)-juzhen(huatu1(i,1),1)+45,1],'Curvature',[1 1],'EdgeColor','b','LineWidth',2);
end
xlabel('����ʱ��');ylabel('�ǻ���');
title('����һ�����λ����ͼ');
x=hangbanxulie;
count=0;
fangzheng=zeros(303,69);
for i=1:303
    if(x(1,i)~=0)
        count=count+1;
        fangzheng(i,x(1,i))=1;
    end
end
disp(strcat('�����ŵ���󺽰���','=',num2str(count)));
count_xjuzhen=0;
 for h=1:69
    if(sum(fangzheng(:,h))==0)
        count_xjuzhen=count_xjuzhen+1;
    end
 end
 disp(strcat('�ǻ�����������Ϊ','=',num2str(count_xjuzhen)));