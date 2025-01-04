%{
#include "y.tab.h"
#include <stdlib.h>
void yyerror(const char *s);
%}

%%

"rezulta"     return RETURN;
"sefu"         return MAIN;
"numar"        return INT;
"daca"         return IF;
"altfel"       return ELSE;
"fa"           return DO;   
"cat"      return WHILE;
"structura"     return STRUCT_TYPE;
"citeste"        return CIN;
"scrie"       return COUT;
"bul"       return BOOL;
"cara"       return CHAR;
"sir"     return STRING;
"sqrt" return SQRT;
"adevar" return ADEV;
"minciuna" return FALS;

\d+       { return INT_CONST; }
\"[^\"]*\"   { return STRING_LITERAL; }
\'[^\"]\'   { return CHAR_LITERAL; }

[a-zA-Z_aîsța][a-zaÎsȚaA-Z0-9_aîsțaaÎsȚa]* return IDENTIFIER;

"{"          return LBRACE;
"}"          return RBRACE;
"("          return LPAREN;
")"          return RPAREN;
"."          return DOT;
"=="         return EQ;
"!="         return NEQ;
"<="         return LTE;
">="         return GTE;
"<"          return LT;
">"          return GT;
"="          return ASSIGN;
";"          return SEMICOLON;
"+"          return PLUS;
"-"          return MINUS;
"*"          return MUL;
"/"          return DIV;
"<<"         return STREAMIN;
">>"         return STREAMOUT;

[ \t\n]+         /* Ignore whitespace */

.        { yyerror("nu stiu ce ai pus sincer"); }
%%

/* yywrap() - wraps the above rule section */
int yywrap() {
    return 1;
}