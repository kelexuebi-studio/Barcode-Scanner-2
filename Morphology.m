classdef Morphology
    %UNTITLED3 Summary of this class goes here
    %   Detailed explanation goes here

    properties
        structuringElement
    end

    methods

        function obj = Morphology()
        end

        function img = closing (obj,imgIn, raio)

            obj.structuringElement = strel ('disk',raio);
            img = imclose (imgIn, obj.structuringElement);

            figure;
            imshow (img);

        end

        function img = opening (obj,imgIn, raio)

            obj.structuringElement = strel ('disk',raio);
            img = imopen (imgIn, obj.structuringElement);

            figure;
            imshow (img);

        end

        function res = terminalPoints (obj, img)

            obj.structuringElement = [0 0 0; 0 1 0; 0 0 0];

            res = zeros (size(img));

            for i = 1:9

                obj.structuringElement (i) = 1;

                if (i ~= 1) && (i ~= 6)
                    obj.structuringElement (i-1) = 0;
                end

                if i ~= 5
                    imgTerminal= bwhitmiss (img, obj.structuringElement, ~obj.structuringElement);
                    res = res + imgTerminal;
                end
            end

            figure;
            imshow (res);
        end

        function res = dilatation (obj, img, radius)
            obj.structuringElement = strel ('disk', radius);
            res = imdilate (img, obj.structuringElement);

            figure;
            imshow (res);
        end

        function res = erosion (obj, img, radius)
            obj.structuringElement = strel ('disk', radius);
            res = imerode (img, obj.structuringElement);

            figure;
            imshow (res);
        end

    end
end
