clc
clear
close all

img_or=imread('ean-13.png');
img_gray=rgb2gray(img_or);
img_b=im2bw(img_gray);
figure (1)
imshow(img_b);
SE=[1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1]';
number=imbothat(img_b,SE);   %obtem imagem oom apenas os numeros do barcode
bar=imclose(img_b, SE);      %obtem imagem com apenas as barras do barcode 
figure (2)
imshow(number); 
figure (3)
imshow(bar)

%BW = edge(img_b, 'canny');
%[H,T,R] = hough(BW);
%x=T


