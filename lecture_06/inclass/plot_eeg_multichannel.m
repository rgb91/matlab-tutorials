function plot_eeg_multichannel(eeg_matrix, t, offset_scale, fig_title)

n_channels = size(eeg_matrix, 1);
disp(n_channels)

% color_vector = ['g', 'b', 'y', 'r', 'm', 'w', 'c', 'g'];

figure; 
% hold on;
for ch = 1:n_channels
    offset = (ch-1) * offset_scale;
    plot(t, eeg_matrix(ch, :)+offset, 'w');
    hold on;
end

yticks((0:n_channels-1)*offset_scale)
xlabel('Time (seconds)')
title(fig_title)
grid on;
box off;

end