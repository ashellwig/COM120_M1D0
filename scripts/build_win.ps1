<#
 .Synopsis
  Builds LaTeX project.

 .Description
  Builds a LaTeX project using `make4ht`, `latexmk`, and `biber`.

 .Parameter OutputType
  The filetype of the output to be generated when compiling the LaTeX project.

 .Parameter ProjectPath
  The path to the root of the LaTeX project.

 .Example
   # Compile LaTeX into a PDF Document.
   Build-Latex-Project -OutputType pdf -Path . -MainFile main.tex

 .Example
   # Compile LaTeX into an HTML Document.
   Build-Latex-Project -OutputType html -Path . -MainFile main.tex
#>
function Build-Latex-Project {
    param(
        # Specifies a path to one or more locations. Wildcards are permitted.
        [Parameter(Mandatory=$true,
                   Position=0,
                   ParameterSetName="",
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   HelpMessage="Path to one or more locations.")]
        [ValidateNotNullOrEmpty()]
        [SupportsWildcards()]
        [String]
        $ProjectPath,

        [Parameter(Mandatory=$true)]
        [String]
        $MainFile,

        # Determines the output type when compiling the LaTeX project.
        [Parameter(Mandatory=$true)]
        [String]
        $OutputType,

        [Parameter(Mandatory=$false)]
        [String]
        $BibFileName
    )

    $MAKE4HT_EXE = "& 'C:\Program Files\MiKTeX\bin\x64\make4ht.exe'"
    $MAKE4HT_OPTS = $MainFile + ' ",charset=utf-8" "-cunihtf -utf8" "" "-interaction=nonstopmode"'
    $LATEXMK_EXE = "& 'C:\Program Files\MiKTeX\bin\x64\latexmk.exe'"
    $LATEXMK_OPTS = '-pdf -pdflatex="pdflatex -interaction=nonstopmode" -use-make'
    $BIBER_EXE = "C:\Program Files\MiKTeX\bin\x64\biber.exe"

    if ($OutputType -eq "pdf") {
        Invoke-Expression $LATEXMK_MK $LATEXMK_OPTS $MainFile
        if ($BibFileName -isnot $null) {
            Invoke-Expression $LATEXMK_EXE $LATEXMK_OPTS $MainFile
            Invoke-Expression $BIBER_EXE $BibFileName
            Invoke-Expression $LATEXMK_EXE $LATEXMK_OPTS $MainFile
            Invoke-Expression $LATEXMK_EXE $LATEXMK_OPTS $MainFile
        } else {
            Invoke-Expression $LATEXMK_EXE $LATEXMK_OPTS $MainFile
            Invoke-Expression $LATEXMK_EXE $LATEXMK_OPTS $MainFile
        }
    }

    if ($OutputType -eq "html") {
        Invoke-Expression $MAKE4HT_EXE $MAKE4HT_OPTS
        if ($BibFileName -isnot $null) {
            Invoke-Expression $MAKE4HT_EXE $MAKE4HT_OPTS
            Invoke-Expression $BIBER_EXE $BibFileName
            Invoke-Expression $MAKE4HT_EXE $MAKE4HT_OPTS
            Invoke-Expression $MAKE4HT_EXE $MAKE4HT_OPTS
        } else {
            Invoke-Expression $MAKE4HT_EXE $MAKE4HT_OPTS
            Invoke-Expression $MAKE4HT_EXE $MAKE4HT_OPTS
        }
    }
}
