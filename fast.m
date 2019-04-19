tic;
%读取图片
pic=imread('messi.jpg');

%显示图片
figure;imshow(pic);title('FAST角点检测');hold on;

%判断图是灰度图还是彩色图
[col row D]=size(pic);

if D==3
    pic2=rgb2gray(pic);
end

%定义检测窗口
mask=[0 0 1 1 1 0 0;...
      0 1 0 0 0 1 0;...
      1 0 0 0 0 0 1;...
      1 0 0 0 0 0 1;...
      1 0 0 0 0 0 1;...
      0 1 0 0 0 1 0;...
      0 0 1 1 1 0 0];

mask=uint8(mask);

%设定阈值
threshold=20;

%fast特征点检测
for i=4:col-3
    for j=4:row-3%若I1、I9与中心I0的差均小于阈值，则不是候选点
        %1.初始筛选
        delta1=abs(pic(i-3,j)-pic(i,j))>threshold;
        delta9=abs(pic(i+3,j)-pic(i,j))>threshold;
        delta5=abs(pic(i,j+3)-pic(i,j))>threshold;
        delta13=abs(pic(i,j-3)-pic(i,j))>threshold;
        
        if sum([delta1 delta9 delta5 delta13])>=3
            %取中心点周围的十六个点
            block=pic(i-3:i+3,j-3:j+3);
            
            %把原始矩阵和mask相乘
            block=block.*mask;%提取圆周16个点
            
            %取周围16个点
    
            %亮点检测
            GreyMinusCenter = block([3,4,5,9,13,15,21,22,28,29,35,37,41,45,46,47])-pic(i,j);
            
            %计数器
            count = 0;
            
            %从十六个数组开始测试
            for n = 1:length(GreyMinusCenter)
                if n<4
                    for num = n:n+12
                        if GreyMinusCenter(num)>20
                            count=count+1;
                        end
                    end 
                    
                    %如果亮点数量是12个，那么检测成功，结束循环
                    if count ==12
%                         disp("亮点存在");
                        count = 0;
                        plot(j,i,'ro');
                        break;%结束循环
                    else
%                         disp("亮点不存在");
                        count = 0;
                    end
                else 
                    %检测前半截
                    for num = n:16
                        if GreyMinusCenter(num)>20
                            count=count+1;
                        end
                    end 
                    
                    %检测后半截
                    for num = 1:n-4
                        if GreyMinusCenter(num)>20
                            count=count+1;
                        end
                    end 
                    
                     %如果亮点数量是12个，那么检测成功，结束循环
                    if count ==12
%                         disp("亮点存在");
                        count = 0;
                        plot(j,i,'ro');
                        break;%结束循环
                    else
%                         disp("亮点不存在");
                        count = 0;
                    end
                end
            end
        end
    end
end
toc;




