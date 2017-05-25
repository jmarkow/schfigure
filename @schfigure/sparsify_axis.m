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
	AX=findall(gcf,'type','axes');
end

% round off axes, jibber jabber blah blah

for i=1:length(AX)
	box(AX(i),'off');
	axis(AX(i),'manual');

	if contains(lower(XY),'y')
		ycorners=AX(i).YLim*1/PRECISION;
		new_ycorners=[floor(ycorners(1)) floor(ycorners(2))]*PRECISION;

		AX(i).YLim=new_ycorners;
		AX(i).YTick=new_ycorners;
	end

	if contains(lower(XY),'x')
		xcorners=AX(i).XLim*1/PRECISION;
		new_xcorners=[floor(xcorners(1)) floor(xcorners(2))]*PRECISION;

		AX(i).XLim=new_xcorners;
		AX(i).XTick=new_xcorners;
	end
end
