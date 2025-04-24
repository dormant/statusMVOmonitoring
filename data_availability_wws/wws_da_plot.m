% wws_da_plot.m
%
% Reads and plots data availability data
%
% R.C. Stewart 21 June 2021

T = readtable( 'wws_da.csv' );

sta = T.Var1;
tmp = T.Var2;
dat = datetime( tmp, 'ConvertFrom', 'yyyymmdd' );
per = T.Var3;

stas = unique( sta );
nstas = length( stas );

plotYear = 2025;
plotTimeLimits = [ datetime( plotYear, 1, 1, 0, 0, 0 ) datetime( plotYear+1, 1, 1, 0, 0, 0 ) ];
plotTimeTicks = datetime(plotYear,1:13,1);

datNumSta = (plotTimeLimits(1):1:plotTimeLimits(2));
numSta = zeros( 1, length(datNumSta) );


figure( 'Position', [10 10 1200 1100] );

for ista = 1:nstas
    
    plotSta = stas( ista );
    
    idx = find( strcmp( sta, plotSta ) );
    plotDate = dat( idx );
    plotPerc = per( idx );
   
    for idate = 1:length(plotDate)
        idd = find( datNumSta == plotDate(idate) );
        numSta(idd) = numSta(idd) + plotPerc(idate)/100.0;
    end
    
    subplot( nstas+1, 1, ista);
    bar( plotDate, plotPerc, 1, 'b' );
    xlim( plotTimeLimits );
    ylim( [0 100] );
    ax = gca;
    ax.XTick = plotTimeTicks;
    datetick( 'x', 'mmm', 'keepticks' );
    if ista == 1
        set( gca, 'xaxislocation', 'top' );
    else
        set( gca, 'Xticklabel', [] );
    end
    set( gca, 'TickDir', 'out' );
    grid on;
    ylabel( plotSta ); 
    
end

% Save number of stations to mat file
save( '/mnt/mvofls2/Seismic_Data/monitoring_data/status/data_availability_wws/daily_nsta.mat', 'datNumSta', 'numSta' );

subplot( nstas+1, 1, nstas+1 );
bar( datNumSta, numSta, 1, 'r' );
xlim( plotTimeLimits );
ylim( [0 12] );
ax=gca;
ax.XTick = plotTimeTicks;
datetick( 'x', 'mmm', 'keepticks' );
ylabel( {'Number of';'stations'} );
grid on;

winx = 0.13;
winl = 0.80;
winy = 0.02;
winh = (1-0.2)/(nstas+1);
ha = get(gcf,'children');
for iha = 1:length(ha)
    set(ha(iha), 'position', [winx winy+iha*winh winl winh*0.9] );
end

plotOverTitle( sprintf( '%s %4d', ...
    'Daily Seismic Data Availability (%):', plotYear ) );
plotDir = '/mnt/mvofls2/Seismic_Data/monitoring_data/status/data_availability_wws';
plotFileName = fullfile( plotDir, sprintf( 'fig-data_availability_wws-%4d.png', plotYear ) );
%exportgraphics( gcf, plotFileName, 'Resolution', 300 );
saveas( gcf, plotFileName );
