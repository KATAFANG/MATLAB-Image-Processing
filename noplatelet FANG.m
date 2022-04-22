%FANG
%2021.1
clear;
clc;
A=imread('1.bmp');
subplot(2,3,1),imshow(A),title('original image');
BW=im2bw(A,graythresh(A));
subplot(2,3,2),imshow(BW),title('BW');
IBW=~BW;
%%%%%%%%%
IBW(:,1)=1;
IBW(:,512)=1;
IBW(1,:)=1;
IBW(512,:)=1;
IBW(512,511:512)=0;
subplot(2,3,3),imshow(IBW),title('border-amended IBW');
%%%%%%%%%
F1=imfill(IBW,'holes');
SE=ones(3);
% F2=imdilate(F1,SE,'same');
subplot(2,3,4),imshow(F1),title('no holes F1');
% subplot(2,3,4),imshow(F2),title('dilated F2');
se = strel('disk',9);
F3 = imerode(F1,se);   %ÕºœÒ∏Ø ¥
F3 = imdilate(F3,se);   %ÕºœÒ≈Ú’Õ
subplot(2,3,5),imshow(F3),title('no platelets F3');
F4=bwperim(F3);
subplot(2,3,6),imshow(F4),title('final F4');