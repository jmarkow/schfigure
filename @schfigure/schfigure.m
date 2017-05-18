classdef schfigure < handle & matlab.mixin.SetGet
	% go schfunk yourself

	properties
		title
		dims
		formats
		style
		renderer
		units
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

			% read in the goddamn defaults

			if ~isa(FIG,'matlab.ui.Figure')
				FIG=figure('visible','off');
			end

			% embed our object in the fig handle, MIND BLOWN, reconstitute when we load a matlab Figure

			function obj = set.title(obj,val)
				if isa(val,'char')
					obj.fig.title=val;
				end
				obj.title=val;
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
				
				pos=obj.fig.positon;
				obj.fig.position=[pos(1:2) pos(1:2)+obj.dims(:)'];

			end

		end



		end

		% function saveobj(obj)
		% end

	end

	methods(Static)

	end
