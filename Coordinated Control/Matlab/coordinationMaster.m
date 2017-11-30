%% Coordination Controller for any number of vehicles
% takes the coordination states of up to four vehicles and calculates the required
% correction velocities for each. It is assumed the arguments are entered
% with ascending vehicleID = [1,2,...,4]
function [vcorr] = coordinationMaster(V1, V2, V3, V4)
    
    %% Setup
    % number of vehicles
    n = nargin;
    
    % vehicle types and coordination states of vehicles
    switch n
        case 1
            types = [V1.vehicleType];
            gamma = [V1.gamma];
        case 2
            types = [V1.vehicleType, V2.vehicleType];
            gamma = [V1.gamma, V2.gamma];
        case 3 
            types = [V1.vehicleType, V2.vehicleType, V3.vehicleType];
            gamma = [V1.gamma, V2.gamma, V3.gamma];
        case 4 
            types = [V1.vehicletype, V2.vehicleType, V3.vehicleType, V4.vehicleType];
            gamma = [V1.gamma, V2.gamma, V3.gamma, V4.gamma];
    end
    

    
    %% Loop through vehicles to find correction velocity
    % preallocate
    gammaE = zeros(1,n);
    vcorr  = zeros(1,n);
    
    for i = 1:n
        if types(i) == "UAV"
            % gain values
            ksync = 1.5;
            ks = 0.0;
        else
            % gain values
            ksync = 7.5;
            ks = 0.01;
        end
        % coordination error
        gammaE(1,i) = gamma(1,i) - 1/n * sum(gamma);
        % correction velocity
        vcorr(i) = - ksync * asin(gammaE(1,i) / (abs(gammaE(1,i)) + ks)) * 2/pi;
    end
    
    
    %% TODO, implement below outwith coordinationMaster
%     %% Save to vehicle structures
%     ASV1.coOrd.gammaE = gammaE(1,1);
%     ASV2.coOrd.gammaE = gammaE(1,2);
%     ASV1.coOrd.vcorr  =  vcorr(1,1);
%     ASV2.coOrd.vcorr  =  vcorr(1,2);
%     
%     %% Provide reference values
%     uRef1 = ref1.uRefNominal + vcorr(1,1);
%     uRef2 = ref2.uRefNominal + vcorr(1,2);
end