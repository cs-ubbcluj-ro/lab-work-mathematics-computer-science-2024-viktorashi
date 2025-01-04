%{
#include "y.tab.h"
#include <stdlib.h>
void yyerror(const char *s);
%}

%%

"rezulta"     { ECHO; return RETURN; }
"sefu"         { ECHO; return MAIN; }
"numar"        { ECHO; return INT; }
"daca"         { ECHO; return IF; }
"altfel"       { ECHO; return ELSE; }
"fa"           { ECHO; return DO;    }
"cat"      { ECHO; return WHILE; }
"structura"     { ECHO; return STRUCT_TYPE; }
"citeste"        { ECHO; return CIN; }
"scrie"       { ECHO; return COUT; }
"bul"       { ECHO; return BOOL; }
"cara"       { ECHO; return CHAR; }
"sir"     { ECHO; return STRING; }
"sqrt" { ECHO; return SQRT; }
"adevar" { ECHO; return ADEV; }
"minciuna" { ECHO; return FALS; }

[0-9]+       { ECHO; return INT_CONST; }
\"[^\"]*\"   { ECHO; return STRING_LITERAL; }
\'[^\"]\'   { ECHO; return CHAR_LITERAL; }

[a-zA-Z_aîsța][a-zaÎsȚaA-Z0-9_aîsțaaÎsȚa]* { ECHO; return IDENTIFIER; }

"{"          { ECHO; return LBRACE; }
"}"          { ECHO; return RBRACE; }
"("          { ECHO; return LPAREN; }
")"          { ECHO; return RPAREN; }
"."          { ECHO; return DOT; }
"=="         { ECHO; return EQ; }
"!="         { ECHO; return NEQ; }
"<="         { ECHO; return LTE; }
">="         { ECHO; return GTE; }
"<"          { ECHO; return LT; }
">"          { ECHO; return GT; }
"="          { ECHO; return ASSIGN; }
";"          { ECHO; return SEMICOLON; }
"+"          { ECHO; return PLUS; }
"-"          { ECHO; return MINUS; }
"*"          { ECHO; return MUL; }
"/"          { ECHO; return DIV; }
"%"          { ECHO; return MOD; }
"<<"         { ECHO; return STREAMIN; }
">>"         { ECHO; return STREAMOUT; }

[ \t\n]+         /* Ignore whitespace */

.        { ECHO; yyerror("Eroare de lexicc"); }
%%

/* yywrap() - wraps the above rule section */
int yywrap() {
    return 1;
}