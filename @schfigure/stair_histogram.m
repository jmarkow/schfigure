function [H,XDATA,YDATA]=stair_histogram(X,BINS,varargin)
%
%
%

opts=struct(...
	'normalize',false,...
    'fill',false);


nparams=length(varargin);

opts_names=fieldnames(opts);
use_params=[];

for i=1:nparams
  if any(strcmp(varargin{i},opts_names))
    opts.(varargin{i})=varargin{i+1};
    use_params=[use_params i i+1];
  end
end

varargin(use_params)=[];

YDATA=histcounts(X,BINS);

if opts.normalize
	YDATA=YDATA/sum(YDATA);
end

YDATA=repmat(YDATA(:)',[2 1]);
YDATA=YDATA(:);


XDATA=[BINS(1:end-1);BINS(2:end)];
XDATA=XDATA(:);

if ~opts.fill
    H=plot(XDATA,YDATA,varargin{:});
else
    H=area(XDATA,YDATA,varargin{:});
end
