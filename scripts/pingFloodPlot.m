% plot pingFlood

clear;

setColours;
setup = setupGlobals();
dirData = fullfile( setup.DirHome, "STUFF/src/mvo/statusMVOmonitoring/data/pingFlood" );

dinfo = dir(fullfile(dirData,'*.txt'));
ntargets = length( dinfo );

rightNow = datetime("now") + hours(4);


if strcmp( setup.Mode, "interactive" )
    figure;
else
    figure( 'visible', 'off' );
end

tiledlayout( 'vertical', 'TileSpacing', 'none' );
figure_size( 'l' );


leg = {};
for i = 1 : ntargets

    fileData = dinfo(i).name;
    chunks = split( fileData, '-' );
    machine = string( chunks(1) );
    ip = string( chunks(2) );
    chunk = string( chunks(3) );
    chunks = split( chunk, '.' );
    host = string( chunks(1) );
    ipb = strjoin( ['(', ip, ')'], '' );
    label = strjoin( [machine, ipb, 'from', host], ' ' );

    T = readmatrix( fullfile( dirData, fileData ) );
    if numel(T) == 0
        continue
    end

    datimPosix = T(:,1);
    datim = datetime( datimPosix, 'convertfrom', 'posixtime', 'Format', 'dd-MMM-uuuu HH:mm:ss.SSS');

    if size(T,2) == 1
        timePing = NaN( numel(T),1 );
    else
        timePing = T(:,2);
    end

    idFail = isnan( timePing );
    timePing( idFail ) = 0.1;
    ax(i) = nexttile;
    plot( datim, timePing, 'k.' );
    hold on;
    plot( datim(idFail), timePing(idFail), 'r.' );
    set( gca, 'YScale', 'log' );
    set(gca,'Yticklabel',[]);
    ax(i).XGrid = 'on';

    if i == ntargets
        xlabel( 'UTC' );
    else
        set(gca,'Xticklabel',[]);
    end
    ylabel( machine,"Rotation",0 );



end

linkaxes(ax,'x');

plotOverTitle( 'Ping flood from opsproc3 (y axes are logarithmic)' );
