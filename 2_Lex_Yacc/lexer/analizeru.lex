%{
#include "parser.tab.h"
#include <stdlib.h>
void yyerror(const char *s);
%}

%%
"număr"        return INT;
"dacă"         return IF;
"altfel"       return ELSE;
"cât"      return WHILE;
"structură"     return STRUCT;
"citește"        return CIN;
"scrie"       return COUT;
"bul"       return BOOL;
"cara"       return CHAR;
"șir"     return STRING;

[0-9]+       { yylval = atoi(yytext); return INT_CONST; }
\"[^\"]*\"   { return STRING_LITERAL; }

[a-zA-Z_ăîșțâ][a-zĂÎȘȚÂA-Z0-9_ăîșțâĂÎȘȚÂ]* return IDENTIFIER;

"{"          return LBRACE;
"}"          return RBRACE;
"("          return LPAREN;
")"          return RPAREN;
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

[ \t\n]+     ; /* Ignore whitespace */

.            { yyerror("nu știu ce ai pus sincer"); }j
%%

/* yywrap() - wraps the above rule section */
int yywrap() {
    return 1;
}