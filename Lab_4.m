clc
clear

RAW_DATA_14_35 = readmatrix("14_35_RAW.csv");
RAW_DATA_14_55 = readmatrix("14_55_RAW.csv");
RAW_DATA_316_55 = readmatrix("316_55_RAW.csv");
RAW_DATA_316_95 = readmatrix("316_95_RAW.csv");

% Phi convert degrees to radians, make positive
RAW_DATA_14_35(:,4) = deg2rad(RAW_DATA_14_35(:,4));
RAW_DATA_14_55(:,4) = deg2rad(RAW_DATA_14_55(:,4));
RAW_DATA_316_55(:,4) = deg2rad(RAW_DATA_316_55(:,4));
RAW_DATA_316_95(:,4) = deg2rad(RAW_DATA_316_95(:,4));


%% 1/4" OD, 3.5" L sample
D_14 = convlength(0.25, "in", "m") * 1000;
J_14 = pi * (D_14^4) / 32; % Area polar moment of intertia

lin_14_35 = shaft_model(D_14, RAW_DATA_14_35(:,5), 3.5*25.4, RAW_DATA_14_35(:,4));
shaft_model_bootstrap(D_14, RAW_DATA_14_35(:,5), 3.5*25.4, RAW_DATA_14_35(:,4))


%% 1/4" OD, 5.5" L sample
lin_14_55 = shaft_model(D_14, RAW_DATA_14_55(:,5), 5.5*25.4, RAW_DATA_14_55(:,4));
shaft_model_bootstrap(D_14, RAW_DATA_14_55(:,5), 5.5*25.4, RAW_DATA_14_55(:,4))

figure(1)
    plot(RAW_DATA_14_35(:,4), RAW_DATA_14_35(:,5))
    hold on
    plot(RAW_DATA_14_55(:,4), RAW_DATA_14_55(:,5))
    hold on
    plot(RAW_DATA_14_35(:,4), lin_14_35, 'g.')
    hold on
    plot(RAW_DATA_14_55(:,4), lin_14_55, 'y.')
    title("1/4 in OD Teflon Torque vs Angular Dispalcement")
    xlabel("Displacement [rad]")
    ylabel("Torque [N-m]")
    legend("3.5in Sample", "5.5in Sample", "3.5in Linear Regression", "5.5in Linear Regression", "Location","northwest")


%% 3/16" OD, 5.5" L sample
D_316 = convlength(3/16, "in", "m") * 1000;
J_316 = pi * (D_316^4) / 32; % Area polar moment of intertia


lin_316_55 = shaft_model(D_316, RAW_DATA_316_55(:,5), 5.5*25.4, RAW_DATA_316_55(:,4));
shaft_model_bootstrap(D_316, RAW_DATA_316_55(:,5), 5.5*25.4, RAW_DATA_316_55(:,4))

%% 3/16" OD, 9.5" L sample
lin_316_95 = shaft_model(D_316, RAW_DATA_316_95(:,5), 9.5*25.4, RAW_DATA_316_95(:,4));
shaft_model_bootstrap(D_316, RAW_DATA_316_95(:,5), 9.5*25.4, RAW_DATA_316_95(:,4))

figure(2)
    plot(RAW_DATA_316_55(:,4), RAW_DATA_316_55(:,5))
    hold on
    plot(RAW_DATA_316_95(:,4), RAW_DATA_316_95(:,5))
    hold on
    plot(RAW_DATA_316_55(:,4), lin_316_55, 'g.')
    hold on
    plot(RAW_DATA_316_95(:,4), lin_316_95, 'y.')
    title("3/16 in OD Teflon Torque vs Angular Dispalcement")
    xlabel("Displacement [rad]")
    ylabel("Torque [N-m]")
    legend("5.5in Sample", "9.5in Sample", "5.5in Linear Regression", "9.5in Linear Regression", "Location","northwest")

    figure(3)
    plot(RAW_DATA_14_55(:,4), RAW_DATA_14_55(:,5))
    hold on
    plot(RAW_DATA_316_55(:,4), RAW_DATA_316_55(:,5))
    hold on
    plot(RAW_DATA_14_55(:,4), lin_14_55, 'g.')
    hold on
    plot(RAW_DATA_316_55(:,4), lin_316_55, 'y.')
    title("5.5 in Length OD Teflon Torque vs Angular Dispalcement")
    xlabel("Displacement [rad]")
    ylabel("Torque [N-m]")
    legend("1/4 in OD Sample", "3/16 in OD Sample", "1/4in OD Linear Regression", "3/16in OD Linear Regression", "Location","northwest")
