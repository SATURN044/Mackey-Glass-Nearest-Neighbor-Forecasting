% Prediction and Visualization
load clustering_results.mat
sigma = 0.1; % Width of membership functions

% Predict using the weighted average (Center of Gravity) 
y_pred = zeros(length(y_output), 1);
for k = 1:length(y_output)
    num = 0; den = 0;
    for i = 1:m
        % Gaussian Membership Function
        mu = exp(-norm(x_input(k,:) - x_c(i,:))^2 / (2 * sigma^2));
        num = num + (H(i)/B(i)) * mu;
        den = den + mu;
    end
    y_pred(k) = num / (den + 1e-9);
end

% Plotting results 
figure('Color', [1 1 1]);
subplot(2,1,1);
plot(y_output, 'b', 'DisplayName', 'Actual'); hold on;
plot(y_pred, 'r--', 'DisplayName', 'FIS Prediction');
title(['Mackey-Glass Prediction with ', num2str(m), ' Rules']);
legend; grid on;

subplot(2,1,2);
plot(y_output - y_pred, 'k');
title('Prediction Error');
grid on;
