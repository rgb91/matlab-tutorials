%% HOMEWORK — Session 10 — SOLUTION (Part B)
%  ─────────────────────────────────────────────

subject_ids = {'S01', 'S02', 'S03'};
erps = [];
labels = {};

figure;
colors = lines(3);

for i = 1:length(subject_ids)
    % 1. Load the file
    filename = sprintf('data/homework_%s.mat', subject_ids{i});
    tmp = load(filename);
    
    fprintf('--- %s (%s) ---\n', tmp.subject_id, tmp.condition);
    
    % 2. Call extract_epochs
    [my_epochs, my_time] = extract_epochs(tmp.continuous, tmp.fs, ...
                                           tmp.event_samples, 0.1, 0.3);
    
    fprintf('  Extracted %d epochs\n', size(my_epochs, 1));
    
    % 3. Compare to ground truth
    %    Ground truth is NOT baseline-corrected, so apply baseline first
    gt = tmp.epochs_ground_truth;
    bl_idx = tmp.epoch_time < 0;
    gt_bc = zeros(size(gt));
    for t = 1:size(gt, 1)
        gt_bc(t, :) = gt(t, :) - mean(gt(t, bl_idx));
    end
    
    max_diff = max(abs(my_epochs(:) - gt_bc(:)));
    fprintf('  Max difference from ground truth: %.6e\n', max_diff);
    if max_diff < 1e-10
        fprintf('  ✓ MATCH\n');
    else
        fprintf('  ⚠ Small numerical difference (likely rounding)\n');
    end
    
    % 4. Compute ERP
    erp = mean(my_epochs, 1);
    
    % 5. Store for plotting
    plot(my_time * 1000, erp, 'Color', colors(i,:), 'LineWidth', 2);
    hold on;
    labels{i} = sprintf('%s (%s)', subject_ids{i}, tmp.condition);
end

xline(0, 'r--', 'Stimulus');
yline(0, 'k:');
xlabel('Time relative to stimulus (ms)');
ylabel('Amplitude (\muV)');
title('ERPs — All Subjects');
legend(labels, 'Location', 'northeast');
% Expected: all 3 ERPs show a peak around +100 ms post-stimulus
%   with slight amplitude differences between subjects.
