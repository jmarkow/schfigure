function [H,XDATA,YDATA]=stair_histogram(X,BINS,varargin)
%
%
%

opts=struct(...
	'normalize',false);


nparams=length(varargin);

if mod(nparams,2)>0
	error('Parameters must be specified as parameter/value pairs!');
end

opts_names=fieldnames(opts);
use_params=[];

for i=1:2:nparams
  if any(strcmp(varargin{i},opts_names))
    opts.(varargin{i})=varargin{i+1};
  end
  use_params=[use_params i i+1];
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

H=plot(XDATA,YDATA,varargin{:});
