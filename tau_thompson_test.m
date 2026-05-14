function cleaned_data = tau_thompson_test(data, alpha)


    if nargin < 2
        alpha = 0.05;
    end

    data = data(:);
    cleaned_data = data;
    outliers_found = true;

    while outliers_found
        n = length(cleaned_data);

        if n < 3
            warning('Too few data points remaining to continue test.');
            break;
        end

        mu = mean(cleaned_data);
        sigma = std(cleaned_data);

        
        [~, idx] = max(abs(cleaned_data - mu));
        xi = cleaned_data(idx);

        
        delta = abs(xi - mu) / sigma;

        % Compute critical tau value using lookup table
        tau_crit = compute_tau_critical(n, alpha);

        if delta > tau_crit

            cleaned_data(idx) = [];
        else
            outliers_found = false;
        end
    end

    fprintf('Done. %d point(s) removed.\n', length(data) - length(cleaned_data));
end


function tau = compute_tau_critical(n, alpha)
% Compute critical tau using a t-distribution lookup table
% then apply: tau = t*(n-1) / sqrt(n*(n-2+t^2))

    % --- T-value lookup tables ---
    % Rows = degrees of freedom (df = 1 to 30, then 40, 60, 120, inf)
    df_table = [1:30, 40, 60, 120, 10000]';

    % Two-tailed t-values at common alpha levels
    % Columns: alpha = 0.10, 0.05, 0.02, 0.01
    t_table = [
        6.314,  12.706, 31.821, 63.657;   % df=1
        2.920,   4.303,  6.965,  9.925;   % df=2
        2.353,   3.182,  4.541,  5.841;   % df=3
        2.132,   2.776,  3.747,  4.604;   % df=4
        2.015,   2.571,  3.365,  4.032;   % df=5
        1.943,   2.447,  3.143,  3.707;   % df=6
        1.895,   2.365,  2.998,  3.499;   % df=7
        1.860,   2.306,  2.896,  3.355;   % df=8
        1.833,   2.262,  2.821,  3.250;   % df=9
        1.812,   2.228,  2.764,  3.169;   % df=10
        1.796,   2.201,  2.718,  3.106;   % df=11
        1.782,   2.179,  2.681,  3.055;   % df=12
        1.771,   2.160,  2.650,  3.012;   % df=13
        1.761,   2.145,  2.624,  2.977;   % df=14
        1.753,   2.131,  2.602,  2.947;   % df=15
        1.746,   2.120,  2.583,  2.921;   % df=16
        1.740,   2.110,  2.567,  2.898;   % df=17
        1.734,   2.101,  2.552,  2.878;   % df=18
        1.729,   2.093,  2.539,  2.861;   % df=19
        1.725,   2.086,  2.528,  2.845;   % df=20
        1.721,   2.080,  2.518,  2.831;   % df=21
        1.717,   2.074,  2.508,  2.819;   % df=22
        1.714,   2.069,  2.500,  2.807;   % df=23
        1.711,   2.064,  2.492,  2.797;   % df=24
        1.708,   2.060,  2.485,  2.787;   % df=25
        1.706,   2.056,  2.479,  2.779;   % df=26
        1.703,   2.052,  2.473,  2.771;   % df=27
        1.701,   2.048,  2.467,  2.763;   % df=28
        1.699,   2.045,  2.462,  2.756;   % df=29
        1.697,   2.042,  2.457,  2.750;   % df=30
        1.684,   2.021,  2.423,  2.704;   % df=40
        1.671,   2.000,  2.390,  2.660;   % df=60
        1.658,   1.980,  2.358,  2.617;   % df=120
        1.645,   1.960,  2.326,  2.576;   % df=inf
    ];

    % Match alpha to correct column
    alpha_levels = [0.10, 0.05, 0.02, 0.01];
    [~, col] = min(abs(alpha_levels - alpha));

    % Tau test uses alpha/(2n) as significance — find adjusted df
    df = n - 2;

    if df < 1
        tau = Inf;
        return;
    end

    % Clamp df to table range and interpolate
    df = min(df, max(df_table));
    df = max(df, 1);

    % Linear interpolation between table entries
    t_crit = interp1(df_table, t_table(:, col), df, 'linear', 'extrap');

    % Convert t to tau
    tau = (t_crit * (n - 1)) / sqrt(n * (n - 2 + t_crit^2));
end