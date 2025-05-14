% plot transfer rates

clear;

setColours;
setup = setupGlobals();
dirData = fullfile( setup.DirHome, "STUFF/src/mvo/statusMvoMonitoring/data/transfer" );

dinfo = dir(fullfile(dirData,'*opsproc3.txt'));

rightNow = datetime("now") + hours(4);
tLimits = [ rightNow-days(2) rightNow ];

figure;
figure_size( 'l' );
hold on;

for i = 1 : length(dinfo)

    fileData = dinfo(i).name;
    chunks = split( fileData, '.' );
    sta = string( chunks(1) );

    T = readmatrix( fullfile( dirData, fileData ) );

    datim = datetime( T(:,1), 'convertfrom', 'posixtime' );
    transferRate = T(:,2);
    leg(i) = sta;

    plot( datim, transferRate, '-o', 'LineWidth', 2.0 );

end

title( 'Radian stations data transfer rate' );
xlabel( 'UTC' );
ylabel( 'MB/s' );
legend( leg, 'Location', 'northeast' );
set( gca, 'YScale', 'log' );
grid on;
xlim( tLimits );
ylim( [-Inf 5] );
box on;

dirPlots = fullfile( setup.DirHome, "STUFF/src/mvo/statusMvoMonitoring/plots" );
filePlot = fullfile( dirPlots, 'figTransferWget.png' );
saveas( gcf, filePlot );

