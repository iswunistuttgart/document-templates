# ISW LaTeX Templates

[![pipeline status](https://git.isw.uni-stuttgart.de/projekte/eigenentwicklungen/templates/latex/badges/master/pipeline.svg)](https://git.isw.uni-stuttgart.de/projekte/eigenentwicklungen/templates/latex/commits/master)

This is the repository for LaTeX document templates for student theses, reports, and other documents.

If you are just interested in finding the most recent class that you want to use, then look no further but table [1].

| Class | Purpose | Version |
|-------|---------|---------|
| iswartcl | General documents | 1.5.1 |
| iswbook | Book-like documents | 1.5.1 |
| iswdctrt | Doctoral theses | 1.5.1 |
| iswstud | Student theses | 1.5.1 |

There are three ways to obtaining the necessary `.cls` and `.tex` files
  1. Clone the repository and obtain the files from the `dist/` directory
  1. Download the build artifacts (i.e., only the file necessary and not the whole repository) from our [GitLab build server](https://git.isw.uni-stuttgart.de/projekte/eigenentwicklungen/templates/latex/-/jobs/artifacts/master/download?job=compile-cls) and unpack them to your local working directory
  1. Build the files yourself after cloning this repository. Simply call `$ make all` in the root of this directory

In the long run this will be the on and only way to obtaining the files.

[[_TOC_]]

## Packages

Want to know which packages are loaded automatically by the respective class? Check our file [PACKAGES.md](PACKAGES.md) and find the respective section.
There are also links to CTAN for every package (though not every package actually has a CTAN page...).

## Development Team

ISW LaTeX Templates was created by [Philipp Tempel](http://www.isw.uni-stuttgart.de/institut/mitarbeiter/Tempel/) who both uses and continues developing the templates.

## Contributing

Before sending a pull request, be sure to check out the [Contribution Guidelines](CONTRIBUTING.md) first.

Our repository hosted on our public [GitHub repo](http://github.com/iswunistuttgart/latex-templates) is a mirror of the original code hosted on our [local GitLab repo](https://git.isw.uni-stuttgart.de/projekte/eigenentwicklungen/templates/latex/).
If you check the `.gitlab-ci.yml` file, you can see there is a `git --mirror` command, which will automatically push the master branch to GitHub.

## Requirements

### LaTeX Distribution

You need an up-to-date version of a LaTeX distribution on your current operating system.
It is generally advised **against** MikTeX, and advised **for** using [TeXlive](https://www.tug.org/texlive/).

### Compiler Engine

As the trend in development of LaTeX related packages and classes is to move away from pdflatex towards xelatex or lualatex, we are not providing support for pdflatex anymore.
As such, you will need to compile your document using either XeLaTeX or luaLaTeX (preferably luaLaTeX, as the classes are more thoroughly tested against luaLaTeX).

Additionally, if you want to play it safe, use `latexmk` to build your document.
Our provided `.latexmkrc` files include all the necessary commands to compile everything in the right order.
Only requirement is access to a commandline which has `latexmk` on its path.
Some LaTeX-IDEs also allow using `latexmk` instead of some weird `lualatex + makeindex + ... + dvips` combo.

PS: The developers are solely using `latexmk`, so support for users using `latexmk` will be the best.


## Usage

You can use these document classes for a magnitude of documents such as your bachelor's or master's thesis, a simple document, or a doctoral thesis.
Please read on to find out more on the general structure of a document in either type.

### Doctoral Thesis `iswdctrt`

Doctoral theses may be typeset in your language of preference (as long as it is either English or German, no other language is officially supported by the document class).

### Student Thesis `iswstud`

```latex
\documentclass[%
  english,% to allow an alternative titlepage and abstract in English
  ngerman,% main document language needs to be loaded last
  bachelor, % Bachelor's thesis
  bachelor-description, % Project description of a bachelor's thesis
]{iswstud}
```

#### Thesis types

You have the option to set your thesis type using any of the following keys to the `iswstud` documentclass

| Key                    | Description                                                  |
| :--------------------- | :----------------------------------------------------------- |
| `bachelor`             | Bachelor's Thesis                                            |
| `bachelor-description` | Thesis description (i.e., project expose) for your Bachelor's Thesis |
| `bachelor-project`     | Bachelor's research project i.e., "Bachelorprojektarbeit"    |
| `master`               | Master's thesis                                              |
| `master-description`   | Thesis desription (i.e., project expose) for your Master's Thesis |
| `study-diploma`        | Student research project (i.e., "Studienarbeit") for all students still enrolled in a diploma major |
| `study`                | Student research project (i.e., "Studienarbeit") for master's students |

### Color Space

For some reason you may want to switch from RGB colorspace to CMYK color space.
Simply pass the option `cmyk` to the document class for CMYK color space, otherwise the default `rgb` will be assumed.

### Author Gender

Some parts of the title page are not gender neutral but are available in a male/female version (in most cases this only applies to the German version of the classes).
Per default (don't ask why ;) ), the document author is assumed male.
To alter this and make the titlepage female pass the `female` option to the documentclass, otherwise `male` sets an explicit male document.

### Accepted Thesis

*This applies to both student and doctoral theses - but is of vital importance to doctoral theses.*

Per default, all theses typeset are set as draft versions i.e., they are not accepted and have not been defended (presented).
This type of draft is different than LaTeX's draft setting as it displays "DRAFT" in capital letters on the titlepage no matter the `draft` or `final` option to the documentclass.

If you first hand in your thesis, it must be submitted in non-accepted version.
Only after it has been successfully revised by your supervisor and has been presented, you may add the `accepted` option to your documentclass.
Additionally, you then must set the `\date` of your thesis to the date of your defense.

### Bibliography

Right from the start, bibliography can be included via `biblatex` as known from all other classes e.g., koma.
Include your bib file in the preamble using `\addbibresource{literature.bib}` and towards the end of your document, `\printbibliography` to output the bibliography.
The style is already loaded in the respective class.

### Mathematics-heavy Thesis

If your thesis is highly mathematical, you should pass the `mathematics` option to the documentclass.
This will load some more commonly used mathematics oriented packages and define several commands that can come in handy.

### Code-heavy Thesis

If you fancy adding many source code listings to your thesis, we have built-in support for awesome code highlighting using the `minted` package.
Activate it by simply providing the `code` option to the document class.
While it may require a bit more setup and configuration of your LaTeX environment at first, it will pay off in the long run.
See the [minted documentation](https://ctan.org/pkg/minted) for more information.

### TikZ

Tikz ist kein Zeichenprogramm, but it is very useful for drawing publication quality, camera-ready images (either by hand or using Inkspace with `svg2tex`).
In any way, you can pass the `tikz` option to the documentclass in order to load additional tikzlibraries that are very often used.

### Fancy Cover Page

Fancy a beautiful cover page for your thesis? You can do so, just use the `\coverpage` macro anywhere between `\frontmatter` and `\maketitle`.

Cover pages have two distinct additional macros:

* `\coverpageimage` is the path to the image that should be displayed on your cover page (in the otherwise dark gray area). This should be set like `\coverpageimage{path/to/image}`
* `\coverpagethanks` must be used if the image is not yours and you want to attribute your thanks to someones for the photo. This could for example read `\coverpagethanks{Image courtesy of Elon Musk}`

Above two macros need to be triggered in the document preamble i.e., **before** `\begin{document}`.

### Changing Main Document Language

Writing your thesis in German but requiring an English titlepage or abstract?
Or really going for an all English thesis with a German titlepage and abstract?
Check with your supervisor, which language you may write in.
To have your thesis compile in with the right language, you need to set the correct flags to the `\documentclass`.
The order of languages loaded matters, as the last loaded language is the document's main language (that's LaTex' not the classes' fault).

#### German Document

```latex
\documentclass[
  english,% to allow an alternative titlepage and abstract in English
  ngerman,% main document language needs to be loaded last
]{isw*}
```

#### English Document

```latex
\documentclass[
  ngerman,% to allow an alternative titlepage and abstract in German
  english,% main document language needs to be loaded last
]{isw*}
```

## Development Team

ISW LaTeX Templates was created by [Philipp Tempel](http://philipptempel.de).
It is currently actively maintained by

* [Philipp Tempel](http://philipptempel.de)
* Christoph Hinze
