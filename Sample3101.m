clear;
close all;
%����ͼ��
I=imread('misaka.jpg');
subplot(121),imshow(I);
for a=1:2
%ȡ����ͼ���R����
R=I(:,:,1);
[N1,M1]=size(R);
%��R������������ת����������ȡ����
R0=double(R);
Rlog=log(R0+1);
%��R�������ж�ά����Ҷ�任
Rfft2=fft2(R0);
%�γɸ�˹�˲�����
sigma=250;
F=zeros(N1,M1);
for i=1:N1
	for j=1:M1
	F(i,j)=exp(-((i-N1/2)^2+(j-M1/2)^2)/(2*sigma*sigma));
	end
end
F=F./(sum(F(:)));
%�Ը�˹�˲��������ж�ά����Ҷ�任
Ffft=fft2(double(F));
%��R�������˹�˲��������о������
DR0=Rfft2.*Ffft;
DR=ifft2(DR0);
%�ڶ������У���ԭͼ���ȥ��ͨ�˲����ͼ�񣬵õ���Ƶ������ͼ��
DRdouble=double(DR);
DRlog=log(DRdouble+1);
Rr=Rlog-DRlog;
%ȡ���������õ���ǿ���ͼ�����
EXPRr=exp(Rr);
%����ǿ���ͼ����жԱȶ�������ǿ
MIN=min(min(EXPRr));
MAX=max(max(EXPRr));
EXPRr=(EXPRr-MIN)/(MAX-MIN);
EXPRr=adapthisteq(EXPRr);

%ȡ����ͼ���G����
G=I(:,:,2);
[N1,M1]=size(G);
%��G������������ת����������ȡ����
G0=double(G);
Glog=log(R0+1);
%��G�������ж�ά����Ҷ�任
Gfft2=fft2(G0);
%�γɸ�˹�˲�����
sigma=250;
for i=1:N1
	for j=1:M1
	F(i,j)=exp(-((i-N1/2)^2+(j-M1/2)^2)/(2*sigma*sigma));
	end
end
F=F./(sum(F(:)));
%�Ը�˹�˲��������ж�ά����Ҷ�任
Ffft=fft2(double(F));
%��G�������˹�˲��������о������
DG0=Gfft2.*Ffft;
DG=ifft2(DG0);
%�ڶ������У���ԭͼ���ȥ��ͨ�˲����ͼ�񣬵õ���Ƶ������ͼ��
DGdouble=double(DG);
DGlog=log(DGdouble+1);
Gg=Glog-DGlog;
%ȡ���������õ���ǿ���ͼ�����
EXPGg=exp(Gg);
%����ǿ���ͼ����жԱȶ�������ǿ
MIN=min(min(EXPGg));
MAX=max(max(EXPGg));
EXPGg=(EXPGg-MIN)/(MAX-MIN);
EXPGg=adapthisteq(EXPGg);

%ȡ����ͼ���B����
B=I(:,:,3);
[N1,M1]=size(B);
%��B������������ת����������ȡ����
B0=double(B);
Blog=log(B0+1);
%��B�������ж�ά����Ҷ�任
Bfft2=fft2(B0);
%�γɸ�˹�˲�����
sigma=250;
for i=1:N1
	for j=1:M1
	F(i,j)=exp(-((i-N1/2)^2+(j-M1/2)^2)/(2*sigma*sigma));
	end
end
F=F./(sum(F(:)));
%�Ը�˹�˲��������ж�ά����Ҷ�任
Ffft=fft2(double(F));
%��B�������˹�˲��������о������
DB0=Bfft2.*Ffft;
DB=ifft2(DB0);
%�ڶ������У���ԭͼ���ȥ��ͨ�˲����ͼ�񣬵õ���Ƶ������ͼ��
DBdouble=double(DB);
DBlog=log(DBdouble+1);
Bb=Blog-DBlog;
%ȡ���������õ���ǿ���ͼ�����
EXPBb=exp(Bb);
%����ǿ���ͼ����жԱȶ�������ǿ
MIN=min(min(EXPBb));
MAX=max(max(EXPBb));
EXPBb=(EXPBb-MIN)/(MAX-MIN);
EXPBb=adapthisteq(EXPBb);

%����ǿ���ͼ��R��G��B���������ں�
I0(:,:,1)=EXPRr;
I0(:,:,2)=EXPGg;
I0(:,:,3)=EXPBb;
%��ʾ���н��
% subplot(121),imshow(I);
subplot(122),imshow(I0);
I=I0;
end
imwrite(I0,'output.png');