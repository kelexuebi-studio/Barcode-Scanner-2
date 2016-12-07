close all;
clear all;
clc;

%% Image Reading

img = imread ('barcode-pc.png');
img_or = img;
img = rgb2gray (img);
img = im2double (img);


figure, imshow (img);


tam = size(img);
%figure, plot (1:tam(2),(sum(img,1)));  %horizontal projection
tam = size(sum(img,2));
%figure, plot (1:tam(1),sum(img,2));  %vertical projection



%% Image rotate

% imgOriginal = img;
% 
% img = imrotate (img, 1, 'bicubic');
% figure, imshow (img);

%% Image filtering

img = imgaussfilt (img, 0.2);
%figure, imshow (img);



%% Image binarize



% T = adaptthresh (img, 0.6);
% img = imbinarize (img, T);
 
 img = im2bw(img, graythresh(img));
% figure, imshow (img);
 img = imcomplement(img);

%% Image close

se = strel ('square', 4);
img = imclose (img, se);
%figure, imshow (img);

%% Edges Determination

imgEdge = edge (img);
%figure, imshow (imgEdge);

%% Hough Transform

[H, T, R] = hough (imgEdge);

P = houghpeaks (H, 500,'Threshold', 0.4*max(H(:)));

lines = houghlines (imgEdge, T, R, P);
%figure, imshow(img), hold on
max_len = 0;
for k = 1:length(lines)
   %xy = [lines(k).point1; lines(k).point2];
   %plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','green');

   % Plot beginnings and ends of lines
  % plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','yellow');
   %plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');

   % Determine the endpoints of the longest line segment
   len = norm(lines(k).point1 - lines(k).point2);
   if ( len > max_len)
      max_len = len;
     % xy_long = xy;
   end
end

mx = 0;
tamanhoMax = 0;
tam = size(lines);
for i = 1:tam(2)
    
    tamanho = sqrt((lines(i).point1(1)-lines(i).point2(1))^2 + (lines(i).point1(2)-lines(i).point2(2))^2);
    if (tamanhoMax < tamanho)
        tamanhoMax = tamanho;
        mx = i;
    end
    
end;

if lines(mx).theta > 0
    img = imrotate (img, (lines(mx).theta));
else
    img = imrotate (img, (lines(mx).theta));
end;

%img = imcomplement(img);
figure, imshow(img);
imf=img;

se=strel('disk', 8);
img=imtophat(img, se);
%figure, imshow(img);


tam = size(img);
%figure, plot (1:tam(2),(sum(img,1)));  %horizontal projection
tam = size(sum(img,2));
%figure, plot (1:tam(1),sum(img,2));  %vertical projection
h=sum(img,1);
v=sum(img,2);
mh=max(h);
mv=max(v);

ih=1;
iv=1;
fh=1;
fv=1;

for i=1:size(v, 1)
    v(i)=v(i)/mv;
end

for i=1:size(h, 2)
    h(i)=h(i)/mh;
end

for i=1:size(v, 1)
    if v(i)>0.4
        iv=i;
        break;
    end
end

for i=1:size(h, 2)
    if h(i)>0.2
        ih=i;
        break;
    end
end

i=size(v, 1);
while i~=0
    if v(i)>0.4
        fv=i;
        break;
    end
    i=i-1;
end

i=size(h, 2);
while i~=0
    if h(i)>0.4
        fh=i;
        break;
    end
    i=i-1;
end


l=(fh-ih)/20;

img=imcrop(imf,[ih-l iv  fh+2*l-ih fv-iv]);
figure, imshow(img);



%%      Filtering

img = medfilt2 (img,[5 5]);
%imgFilt = imgaussfilt (img);
%figure, imshow (img);

%%      Morphology

imgMorph = img;
se = strel ('disk', 4, 0);
%imgMorph = imtophat ((img), se);

%imgMorph = imdilate (img, se);
figure, imshow (imgMorph);


%%      Rescale Image


[x,y] = size (imgMorph);

midx = round (x/2);

 i = 1;
 yinit = i+1;
 while (imgMorph (midx, i) == 0)
     i=i+1;
     yinit = i;
 end

 i = y;
 yend = i-1;
 while (imgMorph (midx, i) == 0)
      i=i-1;
      yend = i;
 end
 
imgRescaled = imgMorph (x*.10:x*.8, yinit:yend);
figure, imshow (imgRescaled);

resizeFactor = 10000;

imgRescaled = imresize (imgRescaled, [x*.8-x*.10 resizeFactor*95], 'method', 'nearest');
figure, imshow (imgRescaled);

imgBits = zeros (95);

tam = size(imgRescaled);
for j = 1: tam(1)
    for i=1:95
        imgBits(j,i) = mode (imgRescaled(1,i*resizeFactor-resizeFactor+1:resizeFactor*(i)));
    end;
end;

imgRescaled = imgBits;

%%  BarCode Decodificaton

ean13 = zeros (tam(1), 13);
code = zeros (tam(1), 13);

for i=1:tam(1)
    % Check C1

    digit = 1;
     C1 = imgRescaled (i, digit:digit+2);
    digit = digit + 3;
     if (~isequal(C1, [1 0 1]))
         disp ('Error on C1');
     end;


    [ean13out, codeOut] = EAN13digits(imgRescaled(i, digit: digit+6));
    ean13 (i, 2) = ean13out;
    code (i:2) = codeOut;
    digit = digit + 7;
    [ean13out, codeOut] = EAN13digits(imgRescaled(i, digit: digit+6));
    ean13 (i, 3) = ean13out;
    code (i:3) = codeOut;
    digit = digit + 7;
    [ean13out, codeOut] = EAN13digits(imgRescaled(i, digit: digit+6));
    ean13 (i, 4) = ean13out;
    code (i:4) = codeOut;
    digit = digit + 7;
    [ean13out, codeOut] = EAN13digits(imgRescaled(i, digit: digit+6));
    ean13 (i, 5) = ean13out;
    code (i:5) = codeOut;
    digit = digit + 7;
    [ean13out, codeOut] = EAN13digits(imgRescaled(i, digit: digit+6));
    ean13 (i, 6) = ean13out;
    code (i:6) = codeOut;
    digit = digit + 7;
    [ean13out, codeOut] = EAN13digits(imgRescaled(i, digit: digit+6));
    ean13 (i, 7) = ean13out;
    code (i:7) = codeOut;
    digit = digit + 7;

    C2 = imgRescaled (i, digit:digit+4);
    digit = digit + 5;
      if (~isequal(C2,[0 1 0 1 0]))
        disp ('Error on C2');   
      end;

    [ean13out, codeOut] = EAN13digits(imgRescaled(i, digit: digit+6));
    ean13 (i, 8) = ean13out;
    code (i:8) = codeOut;
    digit = digit + 7;
    [ean13out, codeOut] = EAN13digits(imgRescaled(i, digit: digit+6));
    ean13 (i, 9) = ean13out;
    code (i:9) = codeOut;
    digit = digit + 7;
    [ean13out, codeOut] = EAN13digits(imgRescaled(i, digit: digit+6));
    ean13 (i, 10) = ean13out;
    code (i:10) = codeOut;
    digit = digit + 7;
    [ean13out, codeOut] = EAN13digits(imgRescaled(i, digit: digit+6));
    ean13 (i, 11) = ean13out;
    code (i:11) = codeOut;
    digit = digit + 7;
    [ean13out, codeOut] = EAN13digits(imgRescaled(i, digit: digit+6));
    ean13 (i, 12) = ean13out;
    code (i:12) = codeOut;
    digit = digit + 7;
    [ean13out, codeOut] = EAN13digits(imgRescaled(i, digit: digit+6));
    ean13 (i, 13) = ean13out;
    code (i:13) = codeOut;
    digit = digit + 7;

    C3 = imgRescaled (i, digit:digit+2);
    digit = digit + 3;
     if (~isequal(C3, [1 0 1]))
         disp ('Error on C3');
     end;
end;
%% Check Digit
    
mult = [3 1 3 1 3 1 3 1 3 1 3 1];

for i=1:tam(1)
    checkDigit = ean13 (i, 2:13).*mult;
    checkDigit = sum(checkDigit);

    sub = ceil(checkDigit / 10) * 10;
    checkDigit = sub - checkDigit;


    ean13(i,1) = checkDigit;
end;

    % Verificar o check Digit
    
    checker = zeros (tam);
for i=1:tam(1)
    checker(i) = codeCheck(ean13(i,1), code(i,:));
    if (codeCheck(ean13(i,1), code(i,:)) == 1)
        ean13str = mat2str (ean13(i,:));

        disp ('O código é ');
        disp (ean13str(2:29));
        return;
    end;
end;
    
ean13str = mat2str (ean13);

% disp ('O código é ');
% disp (ean13str(2:29));