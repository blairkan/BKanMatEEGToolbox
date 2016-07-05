function plotCorrEOG(corrV, corrH)

% plotCorrEOG(corrV, corrH)
% ---------------------
% Plot ICA source correlations with VEOG and HEOG channels.

figure('name', 'EOG Correlation Coefficients', 'numbertitle', 'off')
for i = 1:length(corrV)
   text(corrH(i), corrV(i), num2str(i), 'FontSize', 20, 'linewidth', 3, ...
       'horizontalAlignment', 'center', 'verticalAlignment', 'middle')
end
grid on
xlim([-1 1])
ylim([-1 1])
xlabel('HEOG', 'FontSize', 20, 'linewidth', 3)
ylabel('VEOG', 'FontSize', 20, 'linewidth', 3)