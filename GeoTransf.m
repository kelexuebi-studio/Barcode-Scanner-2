classdef GeoTransf
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        
        originalPts;
        distortedPts;
        transformationFunction;
        
        size;
        angle;
        
    end
    
    methods
        
        function obj = GeoTransf()
        end
        
        function res = autoTransf (obj, imgOriginal, imgDistorted)
            
            ptsOriginal = detectSURFFeatures (imgOriginal);
            ptsDistorted = detectSURFFeatures (imgDistorted);
            
            [featuresOriginal, validPtsOriginal] = extractFeatures (imgOriginal, ptsOriginal);
            [featuresDistorted, validPtsDistorted] = extractFeatures (imgDistorted, ptsDistorted);
            
            indexPairs = matchFeatures (featuresOriginal, featuresDistorted);
            
            obj.originalPts  = validPtsOriginal(indexPairs(:,1));
            obj.distortedPts = validPtsDistorted(indexPairs(:,2));
            
            obj.transformationFunction = estimateGeometricTransform(obj.distortedPts, obj.originalPts, 'projective');
            res = imwarp (imgDistorted, obj.transformationFunction, 'cubic');
            
            figure
            imshow (res);
            
        end
        
        function res = transformImg (obj, img)
            J = imresize(img, obj.scale); % Try varying the scale factor.

            res = imrotate(J,obj.angle); % Try varying the angle, theta.
            figure, imshow(res);
 
        end
        
    end
    
end

