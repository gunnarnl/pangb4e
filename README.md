# pangb4e

Linguists who use LaTeX enjoy a number of packages for numbered examples and interlinear glossing. This support is unfortunately missing from markdown with pandoc, despite using LaTeX as a backend for pdf rendering.

Pangb4e is a [lua filter](lua-filter-url) for pandoc that provides numbered example and glossing support for markdown to LaTeX/pdf conversion using [gb4e](gb4eurl).

The syntax modifies the existing numbered example syntax in pandoc using familiar notions from gb4e (`\gll` tag introduces a gloss.), and supports labeling and referencing examples.

Here's are three quick examples.

    (@) {#example1} This is an example. As you can see **normal** markdown *inline* ~~formatting~~ [works]{.smallcaps} `here`.

    This sentence refers to <#example1>. The following example contains a gloss, notice that it's introduced with `\gll` just like in gb4e.

    (@) {#example2}
        \gll C'est un gloss.
         [dem.cop]{.smallcaps} a gloss
         "This is a gloss."

    (@) {#example3}
        1. {#example3sub1} Enumerations within examples are also possible.

        2. And decently intuitive. Labels aren't required if it's not necessary to refer to the example.

There are more in example.md and you can see for yourself how they render in example.pdf.

Contributions are welcome. A previous version of this filter had HTML support, so I'm working on porting it to this one also.

# Requirements and usage

gb4e must be installed and accessible by the latex compiler of choice. It must also be either included in your latex template or included in your latex header using Pandoc's metadata functionality somehow, as in the following yaml header:

    ---
    header-includes: |
        \usepackage{gb4e}
    ---

Just call the filter like this:

    pandoc -o document.pdf --lua-filter pangb4e.lua document.md
