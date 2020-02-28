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

# glossaries
push @generated_exts, 'glo', 'gls', 'glg';
add_cus_dep('glo', 'gls', 0, 'run_makeglossaries');
# list of symbols
push @generated_exts, 'slo', 'sls', 'slg';
add_cus_dep('slo', 'sls', 0, 'run_makeglossaries');
# list of notation
push @generated_exts, 'nlo', 'nls', 'nlg';
add_cus_dep('nlo', 'nls', 0, 'run_makeglossaries');
# list of acronyms
push @generated_exts, 'acn', 'acr', 'alg';
add_cus_dep('acn', 'acr', 0, 'run_makeglossaries');

sub run_makeglossaries {
  if ( $silent ) {
    system "makeglossaries -q $_[0]";
  }
  else {
    system "makeglossaries $_[0]";
  };
}
