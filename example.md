---
header-includes: |
    \usepackage{gb4e, tipa}
---

A simple example:

(@) {#ex1} A screaming comes across the sky.

\LaTeX~ math stuff works as well:

(@) {#ex1:formula} $\exists x[\text{screaming}(x) \wedge \text{comes-across}(x, \textit{sky})]$

An example containing subexamples is presented in <#ex2>. You can also refer to the subexamples, like <#ex2:1>.

(@) {#ex2}
    1. {#ex2:1} A screaming comes across the sky.

    2. It has happened before, but there is nothing to compare it to now.

Glosses work too. The following in <#legate2014:23> is from Legate (2014). Notice that the pandoc small caps syntax works here.

(@) {#legate2014:23}
    \gll Soe (yang) geu-peu-ubat lé dokto?
         Who [comp]{.smallcaps} [3pol-caus]{.smallcaps}-medicine [le]{.smallcaps} doctor
         'Who was treated by the doctor?'

You can also include preambles for glosses and include them in subexamples. The examples in <#payne1997:124> are from Payne (1997). Notice both that numbering of subexamples doesn't matter, just like with Pandoc, and that TIPA works assuming that the package is loaded.

(@) {#payne1997:124} *Turkish*
    1. {#payne1997:124:33a} *Affirmative existential*
    \gll \textipa{k\"osede} bir kahve *var*
    on:corner a book [exist]{.smallcaps}
    "There is a book on the corner."

    1. {#payne1997:124:33a} *Negative existential*
    \gll \textipa{k\"osede} bir kahve *yok*
    on:corner a book [lack]{.smallcaps}
    "There is a book on the corner."
