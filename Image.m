classdef Image
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        original
        divide
        preProcessed
        morphology
        final
    end
    
    methods
        function img = Image (name)
            imgReaded = imread (name);
            
            img.original = im2double (imgReaded);
            img.final = img.original
            figure;
            imshow (img.original);
        end
        
        function show (obj)
            figure;
            imshow (obj.final);
        end
        
        
        %
        % First you have to say that te image which you want o divide is
        % equal at the divided image. 
        %
        % img.todivide = img.divided
        function [A,B,C,D] = devide4 (obj)
           
            [r, c, p] = size(obj.divide);
            
            A=obj.divide(1:r/2,1:c/2);
            B=obj.divide(1:r/2,c/2+1:c);
            C=obj.divide(r/2+1:r,1:c/2);
            D=obj.divide(r/2+1:r,c/2+1:c);
            
            figure;
            subplot 332
            imshow(A);
            title('Image part 1');
            subplot 333
            imshow(B);
            title('Image part 2');
            subplot 335
            imshow(C);
            title('Image part 3');
            subplot 336
            imshow(D);
            title('Image part 4');
        end
        
    end
    
end

