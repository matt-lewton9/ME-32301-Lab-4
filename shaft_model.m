function [linRegress] = shaft_model(D, T, L, phi)
    % Define data vectors. For example:
    J = pi * (D^4) / 32; % Area polar moment of intertia
    % Initial guess for shear modulus G and error in angle of twist phiE
    G0 = .1;
    phiE0 = 0;
    
    % Define objective function
    objfun = @(x) sum((T - (J*x(1)/L) .* (phi-x(2))).^2);
    % Define constraints for G (G > 0)
    options = optimoptions(@fmincon,'Algorithm','interior-point','Display','off');
    lb = [0, -Inf]; % lower bound
    ub = [Inf, Inf]; % upper bound
    % Call fmincon to minimize objective function
    x = fmincon(objfun, [G0, phiE0], [], [], [], [], lb, ub, [], options);
    
    G_opt = num2str(x(1));
    phiE_opt = num2str(x(2));
   
    linRegress = (phi - x(2)) .* (J .* x(1)) ./ L ;

    % Display the optimal value of G and phiE
    disp(['Optimal value of G: ', G_opt]);
    disp(['Optimal value of phiE: ', phiE_opt]);
end

