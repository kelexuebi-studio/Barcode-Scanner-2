classdef Image
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        original
        preProcessed
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
    end
    
end

