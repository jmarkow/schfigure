function sparsify_axis(AX,PRECISION,XY)
%
%

% YA DUDE SPARSIFY THE AX

if nargin<3
	XY='xy';
end

if nargin<2 | isempty(PRECISION)
	PRECISION=1e-2;
end

if nargin<1 | isempty(AX)
	AX=gca;
end

% round off axes, jibber jabber blah blah

box off;
axis(AX,'manual');

if contains(lower(XY),'y')
	ycorners=AX.YLim*1/PRECISION;
	new_ycorners=[floor(ycorners(1)) floor(ycorners(2))]*PRECISION;

	AX.YLim=new_ycorners;
	AX.YTick=new_ycorners;
end

if contains(lower(XY),'x')
	xcorners=AX.XLim*1/PRECISION;
	new_xcorners=[floor(xcorners(1)) floor(xcorners(2))]*PRECISION;

	AX.XLim=new_xcorners;
	AX.XTick=new_xcorners;
end
