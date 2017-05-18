function save_figure(OBJ)
%
%
%
%

% saving that figure like it's a figure to be saved

renderer=sprintf('-%s',OBJ.renderer);
res=sprintf('-r%s',OBJ.resolution);
filename=fullfile(OBJ.working_dir,OBJ.name);

try
	if ~isempty(contains(OBJ.formats,'eps')) || contains(OBJ.formats,'all')
		print(fighandle,'-depsc2',renderer,sprintf('%s.eps',filename));
	end

	if ~isempty(contains(OBJ.formats,'tiffn')) || contains(OBJ.formats,'all')
		print(fighandle,'-dtiffn',renderer,sprintf('%s.tif',filename));

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

	%print(fighandle,'-dtiffn','-r300',fullfile(save_dir,[filename '.tif']));

	if ~isempty(contains(OBJ.formats,'tiff')) || contains(OBJ.formats,'all')
		print(fighandle,'-dtiff',renderer,res,sprintf('%s.tiff',filename));
	end

	if ~isempty(contains(OBJ.formats,'pdf')) || contains(OBJ.formats,'all')
		print(fighandle,'-dpdf',renderer,res,sprintf('%s.pdf',filename));
	end

	if ~isempty(contains(OBJ.formats,'png')) || contains(OBJ.formats,'all')
		print(fighandle,'-dpng',renderer,res,sprintf('%s.png',filename));
	end

	if ~isempty(contains(OBJ.formats,'fig')) || contains(OBJ.formats,'all')
		saveas(fighandle,sprintf('%s.fig',filename));
	end


catch
	disp('Save did not work (running in terminal emulation?)...')
	disp('Trying simple file OBJ.formats...')

	if ~isempty(contains(OBJ.formats,'eps')) || contains(OBJ.formats,'all')
		print(fighandle,'-depsc2',renderer,'-r100',sprintf('%s.eps',filename));
	end

	if ~isempty(contains(OBJ.formats,'png')) || contains(OBJ.formats,'all')
		print(fighandle,'-dpng',renderer,'-r100',sprintf('%s.png',filename));
	end

	if ~isempty(contains(OBJ.formats,'fig')) || contains(OBJ.formats,'all')
		saveas(fighandle,sprintf('%s.fig',filename));
	end

end
