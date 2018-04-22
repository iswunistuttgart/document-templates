# Developer's Guide

How to contribute your own code to ISW LaTeX templates.

## Development Environment

To develop the templates, you need the following minimum setup on your local system

* TeXLive >= 2017
  * LuaLaTeX
* GNU make >= 3.50
* Python >= 3.4
* rsync > 3.1.*
* Any IDE or LaTeX editor

## Building

Currently, the compiled files are not tracked by git but are being built with every push to `master` using our GitLab server's CI. The build's artifacts i.e., all `.cls`, `.tex`, `.latexmkrc`, and other files, are then published for artifact download using GitLab CI. This requires an account on our GitLab server which is a bit cumbersome. Maybe, at a later time, the file will be available for public download via our GitLab server or will find another way of publishing it elsewhere.

For building the files locally, you can make use of our awesome `Makefile` with the build target `$ make all`. This will build all `.cls` files, publish them with their dependent files to directory `build/`, and write a list of packages of all classes to [PACKAGES.md](PACKAGES.md)

### Build Targets

| Target | Description |
|--------|-------------|
| `all`    | Build all `cls`, `tex`, `latexmkrc` files, create list of packages and list of macros |
| `clean`  | Clean the `build/` directory |
| `build`  | Create the `build/` directory |
| `packages file [file ...]` | Parse given files and create the list of packages of said file(s) `file [file ...]` |
| `macros file [file ...]` | Parse given files and create the list of macros of said file(s) `file [file ...]` |
| `iswartcl` | Build `cls`, `latexmkrc`, `tex` file for only `iswartcl` |
| `iswbook` | Build `cls`, `latexmkrc`, `tex` file for only `iswbook` |
| `iswdctrt` | Build `cls`, `latexmkrc`, `tex` file for only `iswdctrt` |
| `iswstud` | Build `cls`, `latexmkrc`, `tex` file for only `iswstud` |
| `iswmacros` | Copy the file `iswmacros` from `src/` to `build/` |
| `images` | Copy all images from the `src/` directory to `build/` except for `*-converted-to*` images |
| `bbl` | Phony rule for `bbx` and `bib` |
| `bbx` | Copy `*.bbx` from `src/` to `build/` directory |
| `bib` | Copy `*.bib` from `src/` to `build/` directory |
| `patch file [file ...]` | Apply a version number bump for patch release for the given file(s) `file [file ...]` |
| `minor file [file ...]` | Apply a version number bump for minor release for the given file(s) `file [file ...]` |
| `major file [file ...]` | Apply a version number bump for major release for the given file(s) `file [file ...]` |

## Testing

The easiest way of testing your code for errors and avoiding to have to `make all` everytime, is by working inside the `src/` directory. In these folders you'll find sample `.tex` files for each class. These can be used to test your changes for errors or the desired output (luckily, LaTeX doesn't complain about any `\input` or `\include` inside a `.cls` file).

Additionally, you may be a dedicated shell user and run `latexmk` from within the `src/` directory. This will compile all available tex files from said directory.

There are no other or automated ways of testing your edits than above ways.