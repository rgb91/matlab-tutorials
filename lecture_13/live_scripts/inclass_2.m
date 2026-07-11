%% T-Test version 2

addpath("/Users/sanjaysaha/Projects/matlab-tutorials/lecture_13/data/");
load("ttest2_demo_data.mat");
fprintf('Comparing %s\n', measure);
fprintf('control   mean = %.2f\n', mean(control));
fprintf('treatment mean = %.2f\n', mean(treatment));


%%
[h, p, ci, stats] = ttest2(control, treatment);
fprintf("TWO-sample test");
fprintf('t(%d) = %.2f\n', stats.df, stats.tstat);
fprintf('t-test result: h = %d, p = %.4f\n', h, p);
fprintf("95%% CI for the mean: [%.2f %.2f]\n", ci(1), ci(2));
if h == 1
    fprintf("-->> Significant: the groups differ (p < 0.05).\n");
else
    fprintf("-->> Not significant: cannot conclude the groups differ.\n");
end


%% now with 'anova_data.mat'
load('anova_data.mat');
fprintf('Measure: %s\n', measure);
fprintf('control n = %d, mild n = %d, severe n = %d\n', ...
    numel(control), numel(mild), numel(severe));


%% SEM of control group
sem_control = std(control) / sqrt(numel(control));
fprintf("\nControl: mean = %.2f, std = %.2f, SEM = %.2f\n", ...
    mean(control), std(control), sem_control)
fprintf("\n 95%% CI (mean +/- 2*SEM): [%.2f %.2f]\n", ...
    mean(control)-2*sem_control, mean(control)+2*sem_control);


%% T-Test control vs severe
[h, p, ci, stats] = ttest2(control, severe);
fprintf('\n--- ttest2: control vs severe ---\n');
fprintf('t(%d) = %.2f,  p = %.3e\n', stats.df, stats.tstat, p);
fprintf('h = %d  (1 = reject "means equal")\n', h);
fprintf('95%% CI for difference in means: [%.2f, %.2f]\n', ci(1), ci(2));
