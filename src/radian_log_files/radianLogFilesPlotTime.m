logFile = 'MBFL-noClock.txt';
S = readlines( logFile );

datimsOff = NaT(0);
datimsOn = NaT(0);

figure;
hold on;

iGaps = 0;
for i = 1:length(S)

    sLine = S(i);
    offOn = split( sLine, "  -  " );

    if length(offOn) == 2
        iGaps = iGaps+1;
        datimOff = datetime(offOn(1),'InputFormat','uuuu-MM-dd''T''HH:mm:ss.SSS''Z');
        datimsOff(iGaps) = datimOff;
        datimOn = datetime(offOn(2),'InputFormat','uuuu-MM-dd''T''HH:mm:ss.SSS''Z');
        datimsOn(iGaps) = datimOn;

        plot( [datimOff datimOn], [0 0], 'r-', 'LineWidth', 2 );
        
    end

end

ylim( [-1 1] );
grid on;
title( 'MBFL clock off' );
set(gca,'YTick',[])
set(gca,'XMinorTick','on');


