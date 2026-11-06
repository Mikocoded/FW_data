t= readmatrix("cyferki.csv");

lambda=mean(t(:,2));

%create poisson dist plot%
xValues = 0:max(t(:, 2));
poissonProbabilities = poisspdf(xValues, lambda);

%fit poisson dist%
observedValues = t(:, 2);
observedCounts = histcounts(observedValues, -0.5:1:(max(observedValues) + 0.5));
expectedCounts = numel(observedValues) * poissonProbabilities;
hold on;
bar(xValues, poissonProbabilities);
xlabel('Value');
ylabel('Probability');
title('Poisson Distribution');
plot(xValues, expectedCounts / numel(observedValues), 'r-', 'LineWidth', 2);
legend('Observed', 'Poisson fit');
hold off;