function H=scatter_density(X,Y,X_DENSITY,Y_DENSITY)
%
%
%
%
%

if nargin<4
	Y_DENSITY=sqrt(numel(Y));
end

if nargin<3 | isempty(X_DENSITY)
	X_DENSITY=sqrt(numel(X));
end

X=X(:);
Y=Y(:);

x_bins=linspace(min(X),max(X),X_DENSITY);
y_bins=linspace(min(Y),max(Y),Y_DENSITY);

hist_mat=zeros(numel(y_bins),numel(x_bins));
bin_idx=zeros(numel(X),2);

[~,bin_idx(:,1)]=histc(Y,y_bins);
[~,bin_idx(:,2)]=histc(X,x_bins);

hist_mat=accumarray(bin_idx,1,size(hist_mat));
hist_mat=imgaussfilt(hist_mat,2);

density=nan(numel(X),1);

for i=1:length(X)
	density(i)=hist_mat(bin_idx(i,1),bin_idx(i,2));
end

scatter(X,Y,10,density(:),'filled')
