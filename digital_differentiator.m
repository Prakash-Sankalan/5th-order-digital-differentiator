close all; clearvars;
format long;
% Step 1: Define parameters
k = 5;                          % Order of the differentiator
wp = 0.95 * pi;                 % Maximum passband frequency
theta_array = [0, 0, 0, 0, 0, 0, 0, 0.00362, 0.014, 0.0043945, ...
               0.013933, 0.005977, 0.0136704, 0.00749, 0.0131570, ...
               0.009041, 0.012344, 0.01106, 0.0113001, 0.013147, ...
               0.010548, 0.015842, 0.010103, 0.018984, 0.009762, ...
               0.02255, 0.009748, 0.026558, 0.009585, 0.02989, ...
               0.009417, 0.0314, 0.009266, 0.032056, 0.009037, ...
               0.032408, 0.008805, 0, 0.008615];

% Get user input for filter length (odd/even)
prompt1 = 'Enter the length of filter: ';
N = input(prompt1);

% Define frequency vector and desired response
w = linspace(1e-10, wp, 120);
D = (w / (2 * pi)).^k;          % Desired frequency response
W = ones(1, length(w));         % Initial weights
S = [];

% Step 2: Construct the S matrix based on filter length (odd/even)
if mod(N, 2) == 0
    for i = 1:N/2
        S = [S; sin((i - 0.5) * w)];
    end
else
    for i = 1:(N - 1)/2
        S = [S; sin(i * w)];
    end
end

% Step 3: Iterative WLS process to optimize filter coefficients
for i = 1:1000
    M = zeros(1, length(w));
    W = W ./ max(W);
    Q = zeros(size(S, 1));
    d = zeros(size(S, 1), 1);
    
    % Construct matrices Q and d
    for j = 1:length(w)
        Q = Q + (W(j) * (S(:, j) * S(:, j)')/(D(j)^2));
        d = d + (W(j) * S(:, j)/D(j));
    end
    
    % Solve for filter coefficients b
    b = pinv(Q) * d;

    
    % Calculate the actual response M(w)
    for p = 1:size(S, 1)
        M = M + b(p) * S(p, :);
    end
    
    % Calculate errors
    Ea = M - D;                 % Absolute error
    Er = Ea ./ D;               % Relative error
    beta = abs(Er);             % Error envelope for weight update
    W = (beta .^ theta_array(N)) .* W;
    

end
% Step 4: Plotting the results
% 1. Plot Ideal vs Actual Frequency Response
figure;
subplot(3,1,1);
plot(w / (2 * pi), D, 'b', 'LineWidth', 1.5); hold on;
plot(w / (2 * pi), M, 'r--', 'LineWidth', 1.5);
xlabel('Normalized Frequency (\omega / 2\pi)');
axis([0 0.5 0 0.030])
ylabel('Magnitude');
title('Ideal vs Actual Frequency Response');
legend('Ideal Response', 'Actual Response using WLS');
title(['Response of dd with length ' num2str(N)]);
grid on;

% 2. Plot Modulus of the Absolute Error
subplot(3,1,2);
plot(w / (2 * pi), abs(Ea), 'g', 'LineWidth', 1.5);

xlabel('Normalized Frequency (\omega / 2\pi)');
ylabel('Modulus of Error');
title('Modulus of Absolute Error');
axis([0 0.5 0 0.003])
title(['Response of dd with length ' num2str(N)]);
grid on;

% Calculate Modulus of Percentage Error
percentage_error = abs(Er) * 100;  % Convert relative error to percentage

% 3. Plot Modulus of Percentage Error
subplot(3,1,3);
plot(w / (2 * pi), percentage_error, 'm', 'LineWidth', 1.5);
xlabel('Normalized Frequency (\omega / 2\pi)');
ylabel('Modulus of Percentage Error (%)');
title('Modulus of Percentage Error vs Normalized Frequency');
axis([0 0.5 0 10]); % Adjust axis to fit plot
title(['Response of dd with length ' num2str(N)]);
grid on;