function [ ah, cb ] = plot_trasfer_time( W1, W2, dW, dV1_arr, dV2_arr, Dlim )
%PLOT_TRASFER Calculate and plot the pannel for Trasfer Waiting Time

[W1_arr, W2_arr] = meshgrid(W1, W2);

% calc block
x = ( W2_arr - W1_arr ) ./ dW;
x(x<0) = x(x<0) + abs(2*pi/dW);

% plot block
ah = pcolor(dV1_arr, dV2_arr, x./3600./24);
cb = colorbar; shading flat; ax = gca; ax.CLim = Dlim; colormap(jet);



end

