function save_figure(OBJ)
%
%
%
%

% saving that figure like it's a figure to be saved

renderer=sprintf('-%s',OBJ.renderer);
res=sprintf('-r%i',OBJ.resolution);
filename=fullfile(OBJ.working_dir,OBJ.name);

try
	if contains(OBJ.formats,'eps') || contains(OBJ.formats,'all')
		print(OBJ.fig,'-depsc2',renderer,sprintf('%s.eps',filename));
		% yeah MATLAB is REALLY EFFING GREAT AT MAKE NICE EPS files
		epsclean(sprintf('%s.eps',filename),sprintf('%s.eps',filename),false,true);
	end

	if contains(OBJ.formats,'tiffn') || contains(OBJ.formats,'all')
		print(OBJ.fig,'-dtiffn',renderer,sprintf('%s.tif',filename));

		if exist('rsetwrite')>0
			disp('Writing rset...')
			rsetwrite(sprintf('%s.tif',filename),sprintf('%s.rset',filename));
			response=[];
			while isempty(response)
				response=input('(K)eep the original .tiff or (d)elete?  ','s');
				switch lower(response(1))
					case 'k'
						break;
					case 'd'
						delete(sprintf('%s.tif',filename));
					otherwise
						response=[];
				end
			end
		end
	end

	%print(OBJ.fig,'-dtiffn','-r300',fullfile(save_dir,[filename '.tif']));

	if contains(OBJ.formats,'tiff') || contains(OBJ.formats,'all')
		print(OBJ.fig,'-dtiff',renderer,res,sprintf('%s.tiff',filename));
	end

	if contains(OBJ.formats,'pdf') || contains(OBJ.formats,'all')
		print(OBJ.fig,'-dpdf',renderer,res,sprintf('%s.pdf',filename));
	end

	if contains(OBJ.formats,'png') || contains(OBJ.formats,'all')
		print(OBJ.fig,'-dpng',renderer,res,sprintf('%s.png',filename));
	end

	if contains(OBJ.formats,'fig') || contains(OBJ.formats,'all')
		saveas(OBJ.fig,sprintf('%s.fig',filename));
	end


catch

	disp('Save did not work (running in terminal emulation?)...')

	if contains(OBJ.formats,'eps') || contains(OBJ.formats,'all')
		print(OBJ.fig,'-depsc2',renderer,'-r100',sprintf('%s.eps',filename));
	end

	if contains(OBJ.formats,'png') || contains(OBJ.formats,'all')
		print(OBJ.fig,'-dpng',renderer,'-r100',sprintf('%s.png',filename));
	end

	if contains(OBJ.formats,'fig') || contains(OBJ.formats,'all')
		saveas(OBJ.fig,sprintf('%s.fig',filename));
	end

end
