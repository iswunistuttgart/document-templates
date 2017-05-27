* Schlagwörter/Keywords sind maximal 5 zu nennen, von denen die ersten drei aus dem CIRP oder IEEE-Index zu entnehmen sind
* Abschnitte im Anhang sind mit Lateinischen Buchstaben zu "nummerieren"
* Frontmatter hat kleine römische Seitenzahlen, Mainmatter hat lateinischen Seitenzahlen
* Floating Environments (Abbildungen, Tabellen, Quelltext, Equations bzw. Aligns) werden zwei-stufig nummeriert: Die erste Stufie ist die Abschnittsnummer (bzw. Anhangsbuchstabe), die zweite eine fortlaufende Nummer im aktuellen Abschnitt
* Subfigures muessen in der Bildunterschrift der main figure referenziert werden mittels (i)
* Es ist möglich, ein Intro für jedes Kapitel zu schreiben, welches kursiv, 90% Zeilenbreite, zentriert, zu schreiben ist
* Mathematische Indizes sind im Falle von Variablen kursiv zu schreiben (bzw. nicht anzupassen), im Fall von textuellen Indices (z.B. "SM", "offset", "average", "avg", etc), sind diese als normaler Text zu setzen, welcher mittels ```\mc{avg}´``` gesetzt werden muss
* Mathematische Gleichungen sind in der ```align```-Umgebung zu setzen und müssen mittels ```&``` ausgerichtet werden (vor allem bei mehrzeiligen Formeln notwendig)
* Mehrzeilige Gleichungen, die zusammen gehören, sind entweder mit \begin{subequations} oder \begin{split} zu setzen, jenachdem ob eine Nummerierung der einzelnen Teilgleichungen gewünscht ist oder nicht
* Vektoren sollen über ```\vect{x}```, Matrizen über ```\matr{M}```gesetzt werden.
* Das transponierte mathematischer Dinge kann mittels ```\transp{A}``` angegeben werden
* Mittels ```\of{}``` lässt sich eine schöne Formulierung eines mathematischen Arguments bei Funktionen definieren. Dabei wird ```\of{}``` lediglich zu ```\!\left( #2 \right)``` erweitert. Es gibt auch das Makro ```\of*{}``` welches zu ```\! #2``` erweitert wird
* Trägheitsmatrizen sind mit ```\matr{J}``` zu bezeichnen, Einheitsmatrizen mit ```\matr{I}```, Massematrizen mit ```\matr{M}```.
* Ableitungen einer Variable mit Index sind in der Regel außerhalb der Variablen anzugeben d.h. anstatt ```\dot{x_{q}}``` ist ```\dot{x}_{q}``` anzugeben. So wird vor allem bei breiten lateinischen oder griechischen Buchstaben der Ableitungspunkt korrekt, und nicht verschoben, gesetzt
* Das inverse einer mathematischen Entität kann über ```\inv{M}``` angegeben werden
* Sofern nicht anders möglich (z.B. bei Bodediagrammen) sollten Graphen immer separat erzeugt werden. Ein in MATLAB erstellter plot aus zwei subplots sollte als zwei separate Bilddateien exportiert werden, welche anschließend mittels ```\begin{subfigure}``` eingebunden werden sollten. Dadurch ist eine explizite Beschriftung und Beschribung der Abbildung möglich
* Zum Erstellen von Abbildung in LaTeX wird empfohlen, diese in TikZ-Sprache zu definieren. Für MATLAB gibt es matlab2tikz, für Python gibt es matplotlib2tikz, oder allgemein Inkscape oder GIMP
* Listings haben analog wie Tabellen eine Überschrift, keine Unterschrift
* Es ist generell zu empfehlen, auch in Deutschen Ausführungen, einen Punkt als Dezimaltrennzeichen zu verwenden, da dies mit anderen mathematischen Verwendungen von Kommata als Trenner in Gruppen, Mengen, Vektoren, etc. konform ist
* 
