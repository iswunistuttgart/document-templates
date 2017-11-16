# ISW LaTeX Templates

[![pipeline status](https://git.isw.uni-stuttgart.de/projekte/eigenentwicklungen/templates/latex/badges/master/pipeline.svg)](https://git.isw.uni-stuttgart.de/projekte/eigenentwicklungen/templates/latex/commits/master)

This is the repository for LaTeX document templates for student theses, reports, and other documents.

If you are just interested in finding the most recent class that you want to use, then look no further but table [1].

| Class | Purpose | Version |
|-------|---------|---------|
| iswartcl | General documents | 1.0.0-rc3 |
| iswdctrt | Doctoral theses | 1.0.0-rc3 |
| iswstud | Student theses | 1.0.0-rc3 |

There are two ways to obtaining the necessary `.cls` and `.tex` files
  1. Copy the respective files from the `dist/` folder to your local working directory
  2. Download the build artifacts from our [GitLab build server](https://git.isw.uni-stuttgart.de/projekte/eigenentwicklungen/templates/latex/-/jobs/artifacts/master/download?job=compile-cls) and unpack them to your local working directory

In the long run this will be the on the only way to obtaining the files

## Development Team

ISW LaTeX Templates was created by [Philipp Tempel](http://www.isw.uni-stuttgart.de/institut/mitarbeiter/Tempel/) who both uses and continues to develop the templates.

## Contributing

Before sending a pull request, be sure to check out the [Contribution Guidelines](CONTRIBUTING.md) first.

## Requirements

### LaTeX Distribution

You need an up-to-date version of a LaTeX distribution on your current operating system. It is generally advised *against* MikTeX, and advised *for* using [TeXlive](https://www.tug.org/texlive/).

### Compiler Engine

As the trend in development of LaTeX related packages and classes is to move away from pdflatex towards xelatex or lualatex, we are not providing support for pdflatex anymore. As such, you will need to compile your document using either XeLaTeX or luaLaTeX (preferably luaLaTeX, as the classes are more thoroughly tested against luaLaTeX).


## Usage

You can use these document classes for a magnitude of documents such as your bachelor's or master's thesis, a simple document, or a doctoral thesis. Please read on to find out more on the general structure of a document in either type.
 

### Doctoral Thesis

Doctoral theses may be typeset in your language of preference (as long as it is either English or German, no other language is officially supported by the document class).


#### English Doctoral Thesis

To have your thesis type set in English, you need the following document class header

```latex
\documentclass[%
  ngerman,% to allow an alternative titlepage and abstract in German
  english,% main document language needs to be loaded last
]{iswdctrt}
```

#### German Doctoral Thesis

```latex
\documentclass[%
  english,% to allow an alternative titlepage and abstract in English
  ngerman,% main document language needs to be loaded last
]{iswdctrt}
```
