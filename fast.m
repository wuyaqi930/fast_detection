tic;
%��ȡͼƬ
pic=imread('messi.jpg');

%��ʾͼƬ
figure;imshow(pic);title('FAST�ǵ���');hold on;

%�ж�ͼ�ǻҶ�ͼ���ǲ�ɫͼ
[col row D]=size(pic);

if D==3
    pic2=rgb2gray(pic);
end

%�����ⴰ��
mask=[0 0 1 1 1 0 0;...
      0 1 0 0 0 1 0;...
      1 0 0 0 0 0 1;...
      1 0 0 0 0 0 1;...
      1 0 0 0 0 0 1;...
      0 1 0 0 0 1 0;...
      0 0 1 1 1 0 0];

mask=uint8(mask);

%�趨��ֵ
threshold=20;

%fast��������
for i=4:col-3
    for j=4:row-3%��I1��I9������I0�Ĳ��С����ֵ�����Ǻ�ѡ��
        %1.��ʼɸѡ
        delta1=abs(pic(i-3,j)-pic(i,j))>threshold;
        delta9=abs(pic(i+3,j)-pic(i,j))>threshold;
        delta5=abs(pic(i,j+3)-pic(i,j))>threshold;
        delta13=abs(pic(i,j-3)-pic(i,j))>threshold;
        
        if sum([delta1 delta9 delta5 delta13])>=3
            %ȡ���ĵ���Χ��ʮ������
            block=pic(i-3:i+3,j-3:j+3);
            
            %��ԭʼ�����mask���
            block=block.*mask;%��ȡԲ��16����
            
            %ȡ��Χ16����
    
            %������
            GreyMinusCenter = block([3,4,5,9,13,15,21,22,28,29,35,37,41,45,46,47])-pic(i,j);
            
            %������
            count = 0;
            
            %��ʮ�������鿪ʼ����
            for n = 1:length(GreyMinusCenter)
                if n<4
                    for num = n:n+12
                        if GreyMinusCenter(num)>20
                            count=count+1;
                        end
                    end 
                    
                    %�������������12������ô���ɹ�������ѭ��
                    if count ==12
%                         disp("�������");
                        count = 0;
                        plot(j,i,'ro');
                        break;%����ѭ��
                    else
%                         disp("���㲻����");
                        count = 0;
                    end
                else 
                    %���ǰ���
                    for num = n:16
                        if GreyMinusCenter(num)>20
                            count=count+1;
                        end
                    end 
                    
                    %������
                    for num = 1:n-4
                        if GreyMinusCenter(num)>20
                            count=count+1;
                        end
                    end 
                    
                     %�������������12������ô���ɹ�������ѭ��
                    if count ==12
%                         disp("�������");
                        count = 0;
                        plot(j,i,'ro');
                        break;%����ѭ��
                    else
%                         disp("���㲻����");
                        count = 0;
                    end
                end
            end
        end
    end
end
toc;




