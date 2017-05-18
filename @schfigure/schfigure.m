classdef schfigure < handle & matlab.mixin.SetGet
	% go schfunk yourself

	properties
		name
		dims
		formats
		renderer
		units
		working_dir
	end

	properties (SetAccess=private)
		fig
	end

	properties (Access=private)

	end

	methods

		function obj=schfigure(FIG)

			if nargin<1
				FIG=[];
			end

			% read in the defaults

			if ~isa(FIG,'matlab.ui.Figure')
				FIG=figure('visible','off','paperpositionmode','auto',...
					'inverthardcopy','off');
			end

			obj.fig=FIG;
			obj.use_defaults;

			if exist('~/schfigrectory','file')
				fprintf('Loading schfigurectory...')
				fid=fopen('~/.schfigrectory');
				obj.working_dir=fread(fid,'%s');
				fclose(fid);
			end

			% embed our object in the fig handle, MIND BLOWN, reconstitute when we load a matlab Figure

		end

		function obj = set.title(obj,val)
			if isa(val,'char')
				obj.name=val;
			elseif isnumeric(val)
				obj.name=num2str(val);
			end
		end

		function obj = set.dims(obj,val)

			% the user set it like Bob Villa,
			if isa(val,'char') & contains(lower(val),'x')
				nums=regexp(val,'x','split');
				if length(nums)==2
					% we could add additional checks here but I really don't care
					nums=cellfun(@str2num,nums);
					obj.dims=nums;

				else
					fprintf('Check string formatting [expected nxn]...\n');
					return;
				end
			elseif isnumeric(val) & length(val)==2
				obj.dims=val;
			end

			% set dimensions yo

			pos=obj.fig.Positon;
			obj.fig.Position=[pos(1:2) pos(1:2)+obj.dims(:)'];

		end

		function obj = set.renderer(obj,val)
			obj.fig.Renderer=val;
			obj.renderer=val;
		end

		function obj = set.formats(obj,val)
			obj.formats=val;
		end

		function obj = set.working_dir(obj,val)
			% schfigurate it

			if exist(val,'dir')
				fid=fopen('~/.schfigrectory','wt');
				fprintf(fid,'%s',val);
				fclose(fid);
			end

		end

	end

	methods(Static)

	end
end
