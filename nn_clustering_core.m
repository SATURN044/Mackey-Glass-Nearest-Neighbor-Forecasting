% Nearest-Neighbor Clustering Implementation
load mgdata_generated.mat
g = mgdata;

% Create Input-Output Pairs 
% Inputs: x(t-3), x(t-2), x(t-1), x(t) | Output: x(t+1)
for i = 1:1195  
    x_input(i,1:4) = g(i:i+3);
    y_output(i,1) = g(i+4);
end

% Parameters
r = 0.002; % Radius from your PDF Page 6 
m = 1;     % Number of clusters
x_c(1,:) = x_input(1,:); 
H(1) = y_output(1);
B(1) = 1;

% Clustering Loop 
for k = 2:1195
    for i = 1:m
        e(i) = norm(x_input(k,:) - x_c(i,:)); 
    end
    [min_val, I] = min(e);
    
    if min_val < r
        B(I) = B(I) + 1;
        H(I) = H(I) + y_output(k);
    else
        m = m + 1;
        B(m) = 1;
        H(m) = y_output(k);
        x_c(m,:) = x_input(k,:);
    end
end

save('clustering_results.mat', 'x_c', 'H', 'B', 'm', 'x_input', 'y_output');
fprintf('Clustering complete. Found %d clusters.\n', m);
