@default_files = ("iswdctrt.tex");
# Use lualatex
$pdflatex = 'lualatex --shell-escape --synctex=1 %O %S';
# Always create PDFs
$pdf_mode = 1;
# Try 5 times at maximum then give up
$max_repeat = 5;
# File extensions to remove when cleaning
$clean_ext = 'acn bbl fdb_latexmk fls nav pdfsync pyg pytxcode run.xml ' .
             'snm synctex.gz tdo thm upa vrb xdy _minted-%R pythontex-files-%R ' .
             '**/*-eps-converted-to.pdf';

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
