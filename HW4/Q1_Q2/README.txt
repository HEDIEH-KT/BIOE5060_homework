% Initialize the inputs
img_init = [0 1 0; 0 0 1; 1 1 0]; % Binary image
mask_init = [1 1 1; 1 1 1; 1 1 1]; % Custom mask

% Create an object of BlackWhite2D class
bw = BlackWhite2D(img_init, mask_init);

% Test the grow operation
output_grow = bw.grow(1); % Perform one iteration of growth
disp(output_grow);

% Test the shrink operation
output_shrink = bw.shrink(1); % Perform one iteration of shrinkage
disp(output_shrink);
img_init = [0 1 0;            0 0 1;            1 1 0];
mask_init = [1 1 1;             1 1 1;             1 1 1];
output_grow = [1 1 1;               1 1 1;               1 1 1];
output_shrink = [0 0 0;                 0 0 0;                 0 0 0];