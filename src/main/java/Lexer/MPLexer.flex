// import section
package Parser;

import java_cup.runtime.*;

%%
// declaration section
%class MPLexer
%function next_token
%line
%column
%debug
%type Symbol
%eofval{
return new Symbol(sym.EOF);
%eofval}

//states
%state COMMENT
//macros
slovo = [a-zA-Z]
cifra = [0-9]

%%
// rules section
\-\-\>			{ yybegin( COMMENT ); }
<COMMENT>\<\-\-	{ yybegin( YYINITIAL ); }
<COMMENT>.		{ ; }

[\s\t\r\n\\s\s+]		{ ; }

//operators
\+				{ return new Symbol( sym.PLUS ); }
\*				{ return new Symbol( sym.PUTA );  }

//separators
;				{ return new Symbol( sym.TACKAZAREZ );	}
,				{ return new Symbol( sym.ZAREZ );	}
\.				{ return new Symbol( sym.TACKA ); }
:				{ return new Symbol( sym.DVETACKE ); }
=				{ return new Symbol( sym.JEDNAKO ); }
\(				{ return new Symbol( sym.OTVORENAZAGRADA ); }
\)				{ return new Symbol( sym.ZATVORENAZAGRADA ); }
\[              {return new Symbol(sym.OTVORENAVELIKA);}
\]              {return new Symbol(sym.ZATVORENAVELIKA);}
\-              {return new Symbol(sym.CRTICA);}
\>              {return new Symbol(sym.KOMPOCETAK);}
\<              {return new Symbol(sym.KOMKRAJ);}

//keywords
"pocetak"       {return new Symbol( sym.POCETAK);}
"prom"		    { return new Symbol( sym.PROM );	}
"broj"			{ return new Symbol( sym.BROJ );	}
"slovo"			{ return new Symbol( sym.SLOVO );	}
"citaj"			{ return new Symbol( sym.ULAZ );	}
"ispis"			{ return new Symbol( sym.IZLAZ );	}
"je"            {return new Symbol( sym.JE );}



//id-s
{slovo}+ { return new Symbol(sym.ID); }

//constants
{cifra}+ { return new Symbol( sym.KONST); }
0\.{cifra}+(E[+\-]{cifra}+)? { return new Symbol( sym.KONST);}


//error symbol
. { if (yytext() != null && yytext().length() > 0) System.out.println( "ERROR: " + yytext() ); }

