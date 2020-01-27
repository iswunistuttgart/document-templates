# Use lualatex
$pdflatex = 'lualatex --shell-escape --synctex=1 %O %S';

# Always create PDFs
$pdf_mode = 1;

# Try 5 times at maximum then give up
$max_repeat = 5;

# File extensions to remove when cleaning
$clean_ext .= 'acn acr alg aux bbl fdb_latexmk fls glg* glo* gls* idx ilg ' .
              'ind ist nlo nls nlg lof lot log out pyg pytxcode run.xml slo ' .
              'sls slg snm synctex.gz tdo thm toc upa vrb xdy _minted-%R ' .
              'pythontex-files-%R *-eps-converted-to.pdf *.gnuplot';
