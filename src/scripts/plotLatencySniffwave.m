% plot latency from sniffwave data

clear;

setColours;
setup = setupGlobals();
%dirData = "/mnt/mvofls2/Seismic_Data/monitoring_data/statusMVOmonitoring/data/latencySniffwave";
dirData = "../data/latencySniffwave";

dinfo = dir(fullfile(dirData,'M*'));
ncha = length( dinfo );

rightNow = datetime("now") + hours(4);

tLimits = [ rightNow-days(2) rightNow ];

if strcmp( setup.Mode, "interactive" )
    figure;
else
    figure( 'visible', 'off' );
end

figure_size( 'l' );
t = tiledlayout(ncha,1,'TileSpacing','none');
xLabel = "Data Time (UTC)";

for i = 1 : ncha

    dirinfoData = dinfo(i).name;
    dirDataLatency = fullfile( dirData, dirinfoData );
    dinfo2 = dir(fullfile(dirDataLatency,'*.txt'));

    LL = [];

    fprintf( "%s\n", dirinfoData );
    for j = 1: length( dinfo2 )

        fileDataLatency = dinfo2(j).name;
        %fprintf( "%s\n", fileDataLatency );
        fileDataLatency = fullfile( dirDataLatency, fileDataLatency );
        L = readmatrix( fileDataLatency );
        %fprintf( "%8s  %10d %10d\n", fileDataLatency, size(L) );
        if numel(L) > 0
            LL = [LL; L];
        end

    end

    ax(i) = nexttile(i);
    if numel(LL) > 0
        datimData = datetime( LL(:,1), 'convertfrom', 'posixtime', 'Format', 'yyyy-MM-dd HH:mm:ss.SSS');
        bytesData = LL(:,2);
        latencyData = LL(:,3);
        datimArrived = datetime( LL(:,1) + latencyData, 'convertfrom', 'posixtime', 'Format', 'yyyy-MM-dd HH:mm:ss.SSS');
    else
        datimData = rightNow;
        bytesData = NaN;
        latencyData = NaN;
        datimArrived = rightNow;
    end


    plot( datimData, latencyData, 'b-' );
    grid on;
    box on;
    xlim( tLimits );
    ytix = get(gca, 'YTick');
    ytixlbl = get(gca, 'YTickLabel');
    set(gca, 'YTick',ytix(1:end-1), 'YTickLabel',ytixlbl(1:end-1));
    ylabel( dirinfoData, "Rotation", 0 );
    set(gca,'TickDir','out');
    if i == 1
        set(gca,'xaxisLocation','top');
        xlabel( xLabel );
    elseif i == ncha
        set(gca,'xaxisLocation','bottom');
        xlabel( xLabel );
    else
        set(gca,'Xticklabel',[]);
    end
    ylim( [0 Inf] );

end

linkaxes(ax,'x');
                
tit = 'Data latency (seconds) for seismic stations, last 2 days (data time)';
plotOverTitle( tit );

filePlot = 'fig-latencySniffwave-2d.png';
dirPlots = fullfile( setup.DirHome, "STUFF/MVO/statusMVOmonitoring/plots" );
filePlot = fullfile( dirPlots, filePlot );
saveas( gcf, filePlot );

tLimits = [ rightNow-hours(6) rightNow ];
xlim( tLimits );
tit = 'Data latency (seconds) for seismic stations, last 6 hours (data time)';
plotOverTitle( tit );

filePlot = 'fig-latencySniffwave-6h.png';
dirPlots = fullfile( setup.DirHome, "STUFF/MVO/statusMVOmonitoring/plots" );
filePlot = fullfile( dirPlots, filePlot );
saveas( gcf, filePlot );

