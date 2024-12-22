%{
#include "y.tab.h"
#include <stdlib.h>
void yyerror(const char *s);
%}

%%

"rezultă"     return RETURN;
"șefu"         return MAIN;
"număr"        return INT;
"dacă"         return IF;
"altfel"       return ELSE;
"fă"           return DO;   
"cât"      return WHILE;
"structură"     return STRUCT_TYPE;
"citește"        return CIN;
"scrie"       return COUT;
"bul"       return BOOL;
"cara"       return CHAR;
"șir"     return STRING;
"sqrt" return SQRT;
"adevăr" return ADEV;
"minciună" return FALS;

[0-9]+       { return INT_CONST; }
\"[^\"]*\"   { return STRING_LITERAL; }
\'[^\"]\'   { return CHAR_LITERAL; }

[a-zA-Z_ăîșțâ][a-zĂÎȘȚÂA-Z0-9_ăîșțâĂÎȘȚÂ]* return IDENTIFIER;

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