function outify_axis(AX,TICK_LENGTH)
%
%
%

if nargin<2
	TICK_LENGTH=[.025 .025];
end

if nargin<1 | isempty(AX)
	AX=gca;
end

AX.TickDir='out';
AX.TickLength=TICK_LENGTH;
