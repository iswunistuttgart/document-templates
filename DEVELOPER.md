# Developer's Guide

How to contribute your own code to ISW LaTeX templates.

## Development Environment

To develop templates, you need the following minimum setup on your local system

* TeXLive >= 2019
  * LuaLaTeX
  * latexmk
  * biber
  * makeglossaries
* GNU make >= 3.50
* Python >= 3.7
  * bump2version
  * Pygments
* rsync > 3.1.*
* Any IDE or LaTeX editor

## Building

Currently, the compiled files are not tracked by git but are being built with every push to `master` using our GitLab server's CI. The build's artifacts i.e., all `.cls`, `.tex`, `.latexmkrc`, and other files, are then published for artifact download using GitLab CI. This requires an account on our GitLab server which is a bit cumbersome. Maybe, at a later time, the file will be available for public download via our GitLab server or will find another way of publishing it elsewhere.

For building the files locally, you can make use of our awesome `Makefile` with the build target `$ make all`. This will build all needed `.cls`, `.sty`, and other files, and will build all demo `pdf`

### Build Targets

| Target | Description | Depends |
|--------|-------------|---------|
| `all` | Build all source files and all source documentations | `ins`, `demos` |
| `ins` | Run `pdflatex` on the installer `ins` file | |
| `demos` | Build demo `tex` files as `pdf` | |
| `clean` | Remove all created `.cls`, `.sty`, `.dict`, ... files | |
| `distclean` | Clean and also remove `dist/` directory | `clean` |
| `dist` | Copy all files into directory `dist/` | `ins`, `dist_article`, `dist_bachelor`, `dist_book`, `dist_master`, `dist_doctorate` |
| `dist_article` | Copy all files for articles into `dist/article/` | |
| `dist_bachelor` | Copy all files for `bachelor` theses into `dist/bachelor/` | |
| `dist_book` | Copy all files for books into `dist/book/` | |
| `dist_doctorate` | Copy all files for `doctorate` theses into `dist/doctorate/` | |
| `dist_master` | Copy all files for `master` theses into `dist/master/` | |
| `install` | Install all created files to global TeX directory `kpsewhich --var-value TEXMFHOME/tex/latex/ustutt/` so that they are available system wide | `ins` |
| `uninstall` | Remove directory `kpsewhich --var-value TEXMFHOME/tex/latex/ustutt/` | |

## Testing

The easiest way of testing your code for errors and avoiding to have to `make all` everytime, is by working inside the `src/` directory. In these folders you'll find sample `.tex` files for each class. These can be used to test your changes for errors or the desired output (luckily, LaTeX doesn't complain about any `\input` or `\include` inside a `.cls` file).

Additionally, you may be a dedicated shell user and run `latexmk` from within the `src/` directory. This will compile all available tex files from said directory.

There are no other or automated ways of testing your edits than above ways.

## Versioning

Automated versioning is configured via [`bumpversion`](https://pypi.org/project/bump2version/). You have to install it e.g. via `pip` or with your package-manager. The versioning format is

```
{major}.{minor}.{patch}
```

To release a new patch, run in your local environment
```sh
bumpversion patch
```
and follow possible instructions on screen.
Automated Git operations are turned off by default for new versions.
You can automatically commit and tag your new version with

```sh
bumpversion --commit --tag {major|minor|patch}
```

The tags and commit messages are already preconfigured.

**Note:** The version number is raised according to the [Git flow model](https://nvie.com/posts/a-successful-git-branching-model/) i.e., `feature/*` branches should lead to new minor versions, `fix/*` branches to patch versions. Bumping the version should always occur in the `master` branch.
