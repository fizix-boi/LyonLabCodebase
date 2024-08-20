function [fitresult, gof] = fitRollOff(RTX, RTVoltageRatio)
%CREATEFIT(RTX,RTVOLTAGERATIO)
%  Create a fit.
%  
%  Data for 'untitled fit 1' fit:
%      X Input: RTX
%      Y Output: RTVoltageRatio
%  Output:
%      fitresult : a fit object representing the fit.
%      gof : structure with goodness-of fit info.
%
%  See also FIT, CFIT, SFIT.
 
%  Auto-generated by MATLAB on 10-Jul-2024 19:33:57
 

%% Fit: 'untitled fit 1'.
[xData, yData] = prepareCurveData( RTX, RTVoltageRatio );

% Set up fittype and options.
ft = fittype( 'a/sqrt((1+x^2/b^2))+c', 'independent', 'x', 'dependent', 'y' );
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.DiffMaxChange = 0.01;
opts.Display = 'Off';
opts.StartPoint = [RTX(1) 20e3 1];

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );

% Plot fit with data.
%figure( 'Name', 'untitled fit 1' );
%h = plot( fitresult, xData, yData );
%legend( h, 'RTVoltageRatio vs. RTX', 'untitled fit 1', 'Location', 'NorthEast', 'Interpreter', 'none' );
% Label axes
%xlabel( 'RTX', 'Interpreter', 'none' );
%ylabel( 'RTVoltageRatio', 'Interpreter', 'none' );
%grid on

