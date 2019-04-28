# Use lualatex
$pdflatex = 'lualatex --shell-escape --synctex=1 %O %S';
# Always create PDFs
$pdf_mode = 1;
# Try 5 times at maximum then give up
$max_repeat = 5;
# File extensions to remove when cleaning
$clean_ext = 'acn bbl fdb_latexmk fls glo gls nav pdfsync pdf.gls pyg pytxcode run.xml ' .
             'snm synctex.gz tdo thm upa vrb xdy _minted-%R pythontex-files-%R ' .
             '**/*-eps-converted-to.pdf';

# Function for making glossaries
sub run_makeglossaries {
  if ( $silent ) {
    system "makeglossaries -q '$_[0]'";
  }
  else {
    system "makeglossaries '$_[0]'";
  };
}

# Glossaries
push @generated_exts, 'glo', 'gls', 'glg';
$clean_ext .= '%R.glo %R.gls %R.glg';
add_cus_dep('glo', 'gls', 0, 'run_makeglossaries');
# Acronyms
push @generated_exts, 'acn', 'acr', 'alg';
$clean_ext .= '%R.acn %R.acr %R.alg';
add_cus_dep('acn', 'acr', 0, 'run_makeglossaries');
# Symbols
push @generated_exts, 'slo', 'sls', 'slg';
$clean_ext .= '%R.slo %R.sls %R.slg';
add_cus_dep('slo', 'sls', 0, 'run_makeglossaries');
# Notations
push @generated_exts, 'nlo', 'nls', 'nlg';
$clean_ext .= '%R.nlo %R.nls %R.nlg';
add_cus_dep('nlo', 'nls', 0, 'run_makeglossaries');

# Overwrite `unlink_or_move` to support clean directory.
use File::Path 'rmtree';
sub unlink_or_move {
    if ( $del_dir eq '' ) {
        foreach (@_) {
            if (-d $_) {
                rmtree $_;
            } else {
                unlink $_;
            }
        }
    }
    else {
        foreach (@_) {
            if (-e $_ && ! rename $_, "$del_dir/$_" ) {
                warn "$My_name:Cannot move '$_' to '$del_dir/$_'\n";
            }
        }
    }
}
