# SPDX-License-Identifier: GPL-2.0-or-later
# ComplexesCategories: Category of (co)chain complexes of an additive category
#
# Implementations
#
#
# Visualize LaTeX stings
#
##########################

##
@InstallMethod( Show,
          [ IsString ],
          
  @FunctionWithNamedArguments(
    [
      [ "scale", 1 ],
      [ "width", Immutable( "10in" ) ],
      [ "height", Immutable( "15in" ) ],
    ],
    function( CAP_NAMED_ARGUMENTS, str )
      local dir, filename, string, file, x;
      
      dir = DirectoryTemporary();
      
      filename = Filename( dir, "main.tex" );
      
      string = @Concatenation(
"""
\documentclass[article]
\usepackage[geometry]
% SetGAP custom paper size
\geometry[paperwidth=""", width, ", paperheight=", height, """, margin=1in]
\usepackage[mathtools]
\usepackage[amssymb]
\usepackage[amsthm]
\usepackage[amsmath]
\usepackage[dvipsnames][xcolor]
\setcounter[MaxMatrixCols][100]
\begin[document]
\begin[center]
\scalebox[""",
StringGAP( scale ),
"""][
\(""",
    str,
"""\)
]
\end[center]
\end[document]
"""
    );
      
      file = OutputTextFile( filename, true );
      
      SetPrintFormattingStatus( file, false );
      
      PrintTo( file, string );
      
      str = "";
      
      x = Process(
              dir,
              Filename( DirectoriesSystemPrograms(), "pdflatex" ),
              InputTextNone( ),
              OutputTextNone( ),
              [ "-interaction=nonstopmode", "-halt-on-error", "main.tex" ] );
            
      if (x != 0)
        
        Error( "Something went wrong!, please check the main.tex file at ", filename );
        
      elseif (Filename( DirectoriesSystemPrograms(), "xdg-open" ) != fail)
        
        Exec( @Concatenation( "xdg-open ", Filename( dir, "main.pdf" ), " &" ) );
        
      elseif (Filename( DirectoriesSystemPrograms(), "open" ) != fail)
        
        Exec( @Concatenation( "open ", Filename( dir, "main.pdf" ), " &" ) );
        
      else
        
        Print( Filename( dir, "main.pdf" ) );
        
      end;
      
      return;
    
end )  );

##
@InstallMethod( Show,
          [ IsCapCategoryCell ],
          
  function( c )
    
    Show( LaTeXOutput( c ) );
    
end );

##
@InstallMethod( Show,
          [ IsCapCategoryCell, IsObject ],
          
  function( c, r )
    
    Show( c; ScaleBox = r );
    
end );

##
@InstallMethod( Show,
          [ IsString, IsObject ],
          
  function( c, r )
    
    Show( c; scale = r );
    
end );
