clc
clear
close all

%% Image Reading

imgReaded = imread ('ean-13.jpg');
imgGray = rgb2gray (imgReaded);
img = im2double (imgGray);

%%      Filtering

%imgFilt = imgaussfilt (img);
%figure, imshow (imgFilt);

%%      Morphology

se = strel ('line', 45, 0);
imgMorph = imtophat (~(img), se);
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
 
imgRescaled = imgMorph (midx:midx, yinit:yend);
figure, imshow (imgRescaled);

imgRescaled = imresize (imgRescaled, [1 95]);
figure, imshow (imgRescaled);

%%  BarCode Decodificaton

% Check C1

digit = 1;
 C1 = imgRescaled (digit:digit+2);
digit = digit + 3;
 if (C1 ~= [1 0 1])
     disp ('Error on C1');
 end;
 
ean13 = [0 0 0 0 0 0 0 0 0 0 0 0 0];


ean13 (2) = EAN13digits(imgRescaled(digit: digit+6));
digit = digit + 7;
ean13 (3) = EAN13digits(imgRescaled(digit: digit+6));
digit = digit + 7;
ean13 (4) = EAN13digits(imgRescaled(digit: digit+6));
digit = digit + 7;
ean13 (5) = EAN13digits(imgRescaled(digit: digit+6));
digit = digit + 7;
ean13 (6) = EAN13digits(imgRescaled(digit: digit+6));
digit = digit + 7;
ean13 (7) = EAN13digits(imgRescaled(digit: digit+6));
digit = digit + 7;

C2 = imgRescaled (digit:digit+4);
digit = digit + 5;
  if (C2 ~= [1 0 1 0 1])
    disp ('Error on C2');   
  end;

ean13 (8) = EAN13digits(imgRescaled(digit: digit+6));
digit = digit + 7;
ean13 (9) = EAN13digits(imgRescaled(digit: digit+6));
digit = digit + 7;
ean13 (10) = EAN13digits(imgRescaled(digit: digit+6));
digit = digit + 7;
ean13 (11) = EAN13digits(imgRescaled(digit: digit+6));
digit = digit + 7;
ean13 (12) = EAN13digits(imgRescaled(digit: digit+6));
digit = digit + 7;
ean13 (13) = EAN13digits(imgRescaled(digit: digit+6));
digit = digit + 7;
