function shaft_model_bootstrap(D, T, L, phi)
    % Define data vectors. For example:
    J = pi * (D^4) / 32; % Area polar moment of intertia
    n = length(T); % number of data points
    numBootstraps = 1000; % number of bootstrap samples
    % Initial guess for shear modulus G and error in angle of twist phiE
    G0 = 1;
    phiE0 = 0;
    % Define objective function
    objfun = @(x,T,J,L,phi) sum((T - (J*x(1)/L) .* (phi-x(2))).^2);
    % Define constraints for G (G > 0)
    options = optimoptions(@fmincon,'Algorithm','interior-point','Display','off');
    lb = [0, -Inf]; % lower bounds
    ub = [Inf, Inf]; % upper bounds
    % Initialize array to hold bootstrap estimates
    bootstrap_estimates = zeros(numBootstraps,2);
    
    % Perform bootstrap estimation
    for i = 1:numBootstraps
    % Generate bootstrap sample
    ind = randi(n,n,1);
    T_b = T(ind);
    J_b = J;
    L_b = L;
    phi_b = phi(ind);
    % Call fmincon to minimize objective function for bootstrap sample
    x_b = fmincon(@(x) objfun(x,T_b,J_b,L_b,phi_b),...
    [G0,phiE0],[],[],[],[],lb,ub,[],options);
    bootstrap_estimates(i,:) = x_b;
    end
    % Compute confidence intervals
    alpha = 0.05; % 95% confidence interval
    G_conf_int = quantile(bootstrap_estimates(:,1),[alpha/2, 1-alpha/2]);
    phiE_conf_int = quantile(bootstrap_estimates(:,2),[alpha/2, 1-alpha/2]);
    % Display the confidence intervals
    disp(['95% confidence interval for G: ', num2str(G_conf_int(1)), ',', num2str(G_conf_int(2))])
    disp(['95% confidence interval for phiE: ', num2str(phiE_conf_int(1)), ',', num2str(phiE_conf_int(2))])
    fprintf("\n")

end