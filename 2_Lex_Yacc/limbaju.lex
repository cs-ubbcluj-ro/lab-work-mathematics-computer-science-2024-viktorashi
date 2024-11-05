/*** Definition Section ***/
%{
#include <string.h>

typedef struct {
    char token[257];
    int symbolTableCode;
}PIF;

typedef struct{
    char token[257];
    int index;
}ST;

ST SymbolTable[100];
int stLength = 0;

PIF ProgramInternalForm[300];
int pifLength = 0;

short errorFound = 0;
int lineNumber = 1;


int addToST(char* token) {
	for(int i = 0; i < stLength; i++) {
		
		if(strcmp(SymbolTable[i].token, token) == 0) {
		  return SymbolTable[i].index;
		}
	}
	strcpy(SymbolTable[stLength].token, token);
	SymbolTable[stLength].index = stLength;
	stLength++;
	
	return stLength - 1;
}

void addToPIF(char* token, int stCode) {
	strcpy(ProgramInternalForm[pifLength].token, token);
	ProgramInternalForm[pifLength].symbolTableCode = stCode;
	
	pifLength++;
}

void showSymbolTable() {
    printf("------ Symbol table ------\n");
    
    for(int i = 0 ; i < stLength; i++) {
        printf(" %s  %d", SymbolTable[i].token, SymbolTable[i].index);
        printf("\n");
    }
    
    printf("------ Gata ST ------\n");
    printf("\n");
}

void showProgramInternalForm() {
    printf("--- PIFU ---\n");
    
    for(int i = 0; i < pifLength; i++) {
    
        printf(" %s  %d ", ProgramInternalForm[i].token, ProgramInternalForm[i].symbolTableCode);
        printf("\n");
    }
    
    printf("--- Gata PIF ---\n");
    printf("\n");
}

%}


NUMAR_REAL  [+-]?(0|[1-9][0-9]*)(\.[0-9]+)?
IDENTIFIER   [a-z][a-z0-9_]*
SIR       \".*\"

/*** Rule Section ***/
%%
 /* yytext is the text in the buffer */
începe_tot                                   { addToPIF(yytext, -1); }
gata_tot					                    { addToPIF(yytext, -1); }
începe					                { addToPIF(yytext, -1); }
oprește					                { addToPIF(yytext, -1); }
dacă                                    	{ addToPIF(yytext, -1); }
cât                                   { addToPIF(yytext, -1); }
pentru                                    	{ addToPIF(yytext, -1); }
scrie                                   { addToPIF(yytext, -1); }
citește                                    { addToPIF(yytext, -1); }
altfel                                    { addToPIF(yytext, -1); }
int                                    	{ addToPIF(yytext, -1); }
real                                    { addToPIF(yytext, -1); }
cara                                    { addToPIF(yytext, -1); }
structură                               { addToPIF(yytext, -1); }
\;                                    	{ addToPIF(yytext, -1); }
\(                                    	{ addToPIF(yytext, -1); }
\)                                    	{ addToPIF(yytext, -1); }
\,                                    	{ addToPIF(yytext, -1); }
\+                                    	{ addToPIF(yytext, -1); }
\-                                    	{ addToPIF(yytext, -1); }
\*                                    	{ addToPIF(yytext, -1); }
\/                                    	{ addToPIF(yytext, -1); }
\%                                    	{ addToPIF(yytext, -1); }
\>                                    	{ addToPIF(yytext, -1); }
\<                                    	{ addToPIF(yytext, -1); }
\>=                                    	{ addToPIF(yytext, -1); }
\<=                                    	{ addToPIF(yytext, -1); }
\=                                    	{ addToPIF(yytext, -1); }
\==                                    	{ addToPIF(yytext, -1); }
\și                                    { addToPIF(yytext, -1); }
\sau                                    { addToPIF(yytext, -1); }
\.                                    	{ addToPIF(yytext, -1); }
\!=                                    	{ addToPIF(yytext, -1); }
{IDENTIFIER}				       { int stCode = addToST(yytext); addToPIF(yytext, stCode); }
{NUMAR_REAL}                       { int stCode = addToST(yytext); addToPIF(yytext, stCode); }
{SIR}				               { int stCode = addToST(yytext); addToPIF(yytext, stCode); }
[\n]					           { ++lineNumber; }
[ \t\n]+             			   { ; /* oricat whitespce ar fi gen */ }
.                			{ errorFound = 1; printf("Nu recunosc tokenul %s la linia %d !", yytext, lineNumber);    
											  printf("\n"); }
%%

/* yywrap() - wraps the above rule section */
int yywrap() {}

int main(int argc, char** argv) {

	FILE *fp;
	fp = fopen(argv[1], "r");
	
	/* yyin - takes the file pointer which contains the input*/
	yyin = fp;

	/* yylex() - this is the main flex function which runs the Rule Section*/ 
	yylex();
	
	if (errorFound == 0) {
    		showSymbolTable();
    		showProgramInternalForm();
	}
  
	return 0;
}
