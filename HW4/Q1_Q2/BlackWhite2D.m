classdef BlackWhite2D
    properties (Access = private)
        image0 % Original binary image
    end
    properties (Access = public)
        mask % Binary mask
    end
    methods
        % Constructor
        function obj = BlackWhite2D(img_init, mask_init)
            obj.image0 = logical(img_init); % Ensure binary
            if nargin < 2
                obj.mask = [0 1 0; 1 1 1; 0 1 0];
            else
                obj.mask = mask_init;
            end
        end
        
        % Grow method
        function output = grow(obj, iternum, newmask)
            if nargin < 2, iternum = 1; end
            if nargin < 3, newmask = obj.mask; end
            output = obj.image0;
            R = (size(newmask, 1) - 1) / 2; % Half-width of mask
            for iter = 1:iternum
                padded_img = padarray(output, [R, R], 0); % Pad with zeros
                temp = output;
                for i = 1:size(output, 1)
                    for j = 1:size(output, 2)
                        sub_img = padded_img(i:i+2*R, j:j+2*R);
                        temp(i, j) = any(any(sub_img & newmask));
                    end
                end
                output = temp;
            end
        end
        
        % Shrink method
        function output = shrink(obj, iternum, newmask)
            if nargin < 2, iternum = 1; end
            if nargin < 3, newmask = obj.mask; end
            output = obj.image0;
            R = (size(newmask, 1) - 1) / 2; % Half-width of mask
            for iter = 1:iternum
                padded_img = padarray(output, [R, R], 1); % Pad with ones
                temp = output;
                for i = 1:size(output, 1)
                    for j = 1:size(output, 2)
                        sub_img = padded_img(i:i+2*R, j:j+2*R);
                        temp(i, j) = all(all(sub_img | ~newmask));
                    end
                end
                output = temp;
            end
        end
    end
end