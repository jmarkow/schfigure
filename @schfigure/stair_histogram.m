function [H,XDATA,YDATA]=stair_histogram(X,BINS,varargin)
%
%
%

YDATA=histcounts(X,BINS);
YDATA=repmat(YDATA(:)',[2 1]);
YDATA=YDATA(:);

XDATA=[BINS(1:end-1);BINS(2:end)];
XDATA=XDATA(:);

H=plot(XDATA,YDATA,varargin{:});
