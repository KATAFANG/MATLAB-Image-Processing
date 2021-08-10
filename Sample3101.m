clear;
close all;
%读入图像
I=imread('misaka.jpg');
subplot(121),imshow(I);
for a=1:2
%取输入图像的R分量
R=I(:,:,1);
[N1,M1]=size(R);
%对R分量进行数据转换，并对其取对数
R0=double(R);
Rlog=log(R0+1);
%对R分量进行二维傅里叶变换
Rfft2=fft2(R0);
%形成高斯滤波函数
sigma=250;
F=zeros(N1,M1);
for i=1:N1
	for j=1:M1
	F(i,j)=exp(-((i-N1/2)^2+(j-M1/2)^2)/(2*sigma*sigma));
	end
end
F=F./(sum(F(:)));
%对高斯滤波函数进行二维傅里叶变换
Ffft=fft2(double(F));
%对R分量与高斯滤波函数进行卷积运算
DR0=Rfft2.*Ffft;
DR=ifft2(DR0);
%在对数域中，用原图像减去低通滤波后的图像，得到高频增量的图像
DRdouble=double(DR);
DRlog=log(DRdouble+1);
Rr=Rlog-DRlog;
%取反对数，得到增强后的图像分量
EXPRr=exp(Rr);
%对增强后的图像进行对比度拉伸增强
MIN=min(min(EXPRr));
MAX=max(max(EXPRr));
EXPRr=(EXPRr-MIN)/(MAX-MIN);
EXPRr=adapthisteq(EXPRr);

%取输入图像的G分量
G=I(:,:,2);
[N1,M1]=size(G);
%对G分量进行数据转换，并对其取对数
G0=double(G);
Glog=log(R0+1);
%对G分量进行二维傅里叶变换
Gfft2=fft2(G0);
%形成高斯滤波函数
sigma=250;
for i=1:N1
	for j=1:M1
	F(i,j)=exp(-((i-N1/2)^2+(j-M1/2)^2)/(2*sigma*sigma));
	end
end
F=F./(sum(F(:)));
%对高斯滤波函数进行二维傅里叶变换
Ffft=fft2(double(F));
%对G分量与高斯滤波函数进行卷积运算
DG0=Gfft2.*Ffft;
DG=ifft2(DG0);
%在对数域中，用原图像减去低通滤波后的图像，得到高频增量的图像
DGdouble=double(DG);
DGlog=log(DGdouble+1);
Gg=Glog-DGlog;
%取反对数，得到增强后的图像分量
EXPGg=exp(Gg);
%对增强后的图像进行对比度拉伸增强
MIN=min(min(EXPGg));
MAX=max(max(EXPGg));
EXPGg=(EXPGg-MIN)/(MAX-MIN);
EXPGg=adapthisteq(EXPGg);

%取输入图像的B分量
B=I(:,:,3);
[N1,M1]=size(B);
%对B分量进行数据转换，并对其取对数
B0=double(B);
Blog=log(B0+1);
%对B分量进行二维傅里叶变换
Bfft2=fft2(B0);
%形成高斯滤波函数
sigma=250;
for i=1:N1
	for j=1:M1
	F(i,j)=exp(-((i-N1/2)^2+(j-M1/2)^2)/(2*sigma*sigma));
	end
end
F=F./(sum(F(:)));
%对高斯滤波函数进行二维傅里叶变换
Ffft=fft2(double(F));
%对B分量与高斯滤波函数进行卷积运算
DB0=Bfft2.*Ffft;
DB=ifft2(DB0);
%在对数域中，用原图像减去低通滤波后的图像，得到高频增量的图像
DBdouble=double(DB);
DBlog=log(DBdouble+1);
Bb=Blog-DBlog;
%取反对数，得到增强后的图像分量
EXPBb=exp(Bb);
%对增强后的图像进行对比度拉伸增强
MIN=min(min(EXPBb));
MAX=max(max(EXPBb));
EXPBb=(EXPBb-MIN)/(MAX-MIN);
EXPBb=adapthisteq(EXPBb);

%对增强后的图像R、G、B分量进行融合
I0(:,:,1)=EXPRr;
I0(:,:,2)=EXPGg;
I0(:,:,3)=EXPBb;
%显示运行结果
% subplot(121),imshow(I);
subplot(122),imshow(I0);
I=I0;
end
imwrite(I0,'output.png');