% plot transfer rates for one station

clear;

setColours;
setup = setupGlobals();
dirData = fullfile( setup.DirHome, "STUFF/MVO/statusMVOmonitoring/data/transferWget" );

dinfo = dir(fullfile(dirData,'MBLG*opsproc3.txt'));

rightNow = datetime("now") + hours(4);

if strcmp( setup.Mode, "interactive" )
    figure;
else
    figure( 'visible', 'off' );
end

figure_size( 'l' );
hold on;

leg = {};
for i = 1 : length(dinfo)

    fileData = dinfo(i).name;
    chunks = split( fileData, '.' );
    sta = string( chunks(1) );

    T = readmatrix( fullfile( dirData, fileData ) );

    datim = datetime( T(:,1), 'convertfrom', 'posixtime' );
    transferRate = T(:,2);
    transferRate(isnan(transferRate)) = 0.0;

    if numel( transferRate ) ~= sum( isnan( transferRate ) )
        plot( datim, transferRate, 'bo', 'MarkerSize', 4, 'MarkerFaceColor', 'b' );
        hold on;
        idWant = transferRate == 0.0;
        plot( datim(idWant), transferRate(idWant), 'ro', 'MarkerSize', 6, 'MarkerFaceColor', 'r' );
    end


end

title( 'Data transfer rate (using wget) for MBLG seismic station, last 28 days' );
tLimits = [ rightNow-days(28) rightNow ];
xlabel( 'UTC' );
ylabel( 'MB/s' );
%set( gca, 'YScale', 'log' );
grid on;
xlim( tLimits );
%ylim( [-Inf 10] );
box on;

dirPlots = fullfile( setup.DirHome, "STUFF/MVO/statusMVOmonitoring/plots" );
filePlot = fullfile( dirPlots, 'fig-transferWget-MBLG-28d.png' );
saveas( gcf, filePlot );


title( 'Data transfer rate (using wget) for MBLG seismic station, last 2 days' );
tLimits = [ rightNow-days(2) rightNow ];
xlim( tLimits );
filePlot = fullfile( dirPlots, 'fig-transferWget-MBLG-2d.png' );
saveas( gcf, filePlot );