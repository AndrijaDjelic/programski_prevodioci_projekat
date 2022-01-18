// import section
import java_cup.runtime.*;

%%
// declaration section
%class MPLexer
%cup
%line
%column

%eofval{
	return new Symbol( sym.EOF );
%eofval}


//states
%state COMMENT
//macros
slovo = [a-zA-Z]
cifra = [0-9]
interpunkcije =[\!\@\#\$\%\^\&\*\(\)\_\-\=\+\[\]\{\}\;\:\'\"\|\\\,\<\.\>\/\?\`\~]
octal = 0|[1-7][0-7]*
hex = 0|[1-9a-fA-F][0-9a-fA-F]*
dec = 0|[1-9][0-9]*
integer = 0{octal} | 0x{hex} | {dec}
real =(\+?|\-)(({dec}(\.{cifra}+)?) | 0(\.{cifra}+))((e|E)(\+|\-){cifra}(\.{cifra})?)?
char = '{slovo}' | '{cifra}' | '{interpunkcije}'
const = {integer} | {real} | {char}

%%
// rules section
\(\*			{ yybegin( COMMENT ); }
<COMMENT>\*\)	{ yybegin( YYINITIAL ); }
<COMMENT>.		{ ; }

[\t\r\n ]		{ ; }

//operators
\+				{ return new Symbol( sym.PLUS ); }
\*				{ return new Symbol( sym.MUL );  }
\-             { return new Symbol( sym.SUB );  }
\/             { return new Symbol( sym.DIV );  }

//separators
;				{ return new Symbol( sym.SEMI );	}
,				{ return new Symbol( sym.COMMA );	}
\.				{ return new Symbol( sym.DOT );     }
:				{ return new Symbol( sym.DOTDOT );  }
\(				{ return new Symbol( sym.LEFTPAR ); }
\)				{ return new Symbol( sym.RIGHTPAR );}
\{              { return new Symbol( sym.LEFTCURLY );}
\}              { return new Symbol( sym.RIGHTCURLY );}
\=              { return new Symbol( sym.EQUALS );    }

//keywords
"program"		{ return new Symbol( sym.PROGRAM );	}
"begin"			{ return new Symbol( sym.BEGIN );	}
"end"			{ return new Symbol( sym.END );	    }
"int"	        { return new Symbol( sym.INTEGER );	}
"char"	        { return new Symbol( sym.CHAR );	}
"real"          { return new Symbol( sym.REAL );    }
"read"			{ return new Symbol( sym.READ );	}
"write"			{ return new Symbol( sym.WRITE );	}
"switch"		{ return new Symbol( sym.SWITCH );	}
"case"			{ return new Symbol( sym.CASE );    }
"mod"			{ return new Symbol( sym.MOD );	    }



//id-s
{slovo}({slovo}|{cifra})*	{ return new Symbol( sym.ID ); }

//constants

{const}     { return new Symbol( sym.CONST ); }

//error symbol
.		{ System.out.println( "ERROR: " + yytext() ); }

