# UStutt LaTeX Templates

[![pipeline status](https://git.isw.uni-stuttgart.de/projekte/eigenentwicklungen/templates/latex/badges/master/pipeline.svg)](https://git.isw.uni-stuttgart.de/projekte/eigenentwicklungen/templates/latex/commits/master)
[![GitHub issues](https://img.shields.io/github/issues/iswunistuttgart/latex-templates)](https://github.com/iswunistuttgart/latex-templates/issues)
[![GitHub forks](https://img.shields.io/github/forks/iswunistuttgart/latex-templates)](https://github.com/iswunistuttgart/latex-templates/network)
[![GitHub stars](https://img.shields.io/github/stars/iswunistuttgart/latex-templates)](https://github.com/iswunistuttgart/latex-templates/stargazers)
[![GitHub license](https://img.shields.io/github/license/iswunistuttgart/latex-templates)](https://github.com/iswunistuttgart/latex-templates/blob/master/LICENSE.txt)
![GitHub All Releases](https://img.shields.io/github/downloads/iswunistuttgart/latex-templates/total)
[![Maintenance](https://img.shields.io/badge/Maintained%3F-yes-green.svg)](https://github.com/iswunistuttgart/latex-templates/graphs/commit-activity)
[![made-with-latex](https://img.shields.io/badge/Made%20with-LaTeX-1f425f.svg)](https://github.com/iswunistuttgart/latex-templates)


This is the nonofficial repository of LaTeX document classes, styles, packages, and templates for documents at the University of Stuttgart.
If you are interested in just finding the most recent files you need for writing code, please refer to the releases page:

[Download most recent release](https://github.com/iswunistuttgart/latex-templates)

> **Note:** If you are a student writing your thesis at ISW, please use the newer student template. You can find it on <https://github.com/iswunistuttgart/latex_template_students> or directly write on [Overleaf](https://www.overleaf.com/latex/templates/isw-student-thesis/xjwkfntnwrwc) (account needed).

## Requirements

### LaTeX Distribution

You need an up-to-date version of a LaTeX distribution on your current operating system.
We generally advise **against** MikTeX, and advise **for** using [TeXlive](https://www.tug.org/texlive/).

### Compiler Engine

As the trend in development of LaTeX related packages and classes is to move away from `pdflatex` towards `xelatex` or `lualatex`, we are not providing support for `pdflatex` anymore.
As such, you will need to compile your document using either `XeLaTeX` or `luaLaTeX` (preferably `luaLaTeX`, as the classes are more thoroughly tested against `luaLaTeX`).

Additionally, if you want to play it safe, use `latexmk` to build your document. Our provided `.latexmkrc` files include all the necessary commands to compile everything in the right order. Only requirement is access to a command line with `latexmk` on your path. Some LaTeX-IDEs also allow using `latexmk` instead of some weird `lualatex + makeindex + ... + dvips` combo.

PS: The developers are solely using `latexmk`, so support for users using `latexmk` will be the best.

## Usage

If you download the files from the respective released archives (article, book, or thesis), you have all needed files as well as a template file. Simply open the contained `.tex` file and get going.

## Contributing

Before sending a pull request, be sure to check out the [Contribution Guidelines](CONTRIBUTING.md) first.

Our repository hosted on our public [GitHub repo](http://github.com/iswunistuttgart/latex-templates) is a mirror of the original code hosted on our [local GitLab repo](https://git.isw.uni-stuttgart.de/projekte/eigenentwicklungen/templates/latex/). Any member (staff, student) of the University of Stuttgart can request access to the repo, fork it, and create a merge request.

## Development Team

UStutt LaTeX Templates was created by [Philipp Tempel](http://www.isw.uni-stuttgart.de/institut/mitarbeiter/Tempel/) who both uses and continues developing the templates.

* [Philipp Tempel](http://philipptempel.de)
* Christoph Hinze
