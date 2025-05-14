
% plot transfer rates

clear;

setColours;
setup = setupGlobals();
dirData = fullfile( setup.DirHome, "STUFF/MVO/statusMVOmonitoring/data/transferWget" );

dinfo = dir(fullfile(dirData,'*opsproc3.txt'));

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

    if numel( transferRate ) ~= sum( isnan( transferRate ) )
        h = plot( datim, transferRate, 'o-', 'LineWidth', 0.5, 'MarkerSize', 4 );
        set(h, 'MarkerFaceColor', get(h,'Color')); 
        leg{end+1} = sta;
    end

    fprintf( "%s  %8.4f\n", sta, mean( transferRate, 'omitnan' ) );

end

title( 'Data transfer rate (using wget) for Radian seismic stations, last 2 days' );
tLimits = [ rightNow-days(2) rightNow ];
xlabel( 'UTC' );
ylabel( 'MB/s' );
legend( leg, 'Location', 'northeast' );
%set( gca, 'YScale', 'log' );
grid on;
xlim( tLimits );
%ylim( [-Inf 10] );
box on;

dirPlots = fullfile( setup.DirHome, "STUFF/MVO/statusMVOmonitoring/plots" );
filePlot = fullfile( dirPlots, 'fig-transferWget-2d.png' );
saveas( gcf, filePlot );

title( 'Data transfer rate (using wget) for Radian seismic stations, last 7 days' );
tLimits = [ rightNow-days(7) rightNow ];
xlim( tLimits );
filePlot = fullfile( dirPlots, 'fig-transferWget-7d.png' );
saveas( gcf, filePlot );

title( 'Data transfer rate (using wget) for Radian seismic stations, last 24 hours' );
tLimits = [ rightNow-hours(12) rightNow ];
xlim( tLimits );
filePlot = fullfile( dirPlots, 'fig-transferWget-1d.png' );
saveas( gcf, filePlot );
