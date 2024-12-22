%{
#include <stdio.h>
#include <stdlib.h>
#define YYDEBUG 1
#define TIP_INT 1
#define TIP_REAL 2
#define TIP_CAR 3

extern int yylex();
extern int yyparse();
extern FILE *yyin;
extern int yydebug; 


void yyerror(const char *s);

int productions_used[1000];
int prod_count = 0;

void record_production(unsigned short num) {
    productions_used[prod_count++] = num; 
}

%}

%token INT IF ELSE WHILE STRUCT_TYPE CIN COUT BOOL CHAR STRING INT_CONST STRING_LITERAL IDENTIFIER LBRACE RBRACE LPAREN RPAREN EQ NEQ LTE GTE LT GT ASSIGN SEMICOLON PLUS MINUS MUL DIV RETURN MAIN SQRT CHAR_LITERAL DOT STREAMIN STREAMOUT DO ADEV FALS

/* ce e mai important */
%start program
%left PLUS MINUS
%left MUL DIV 
%nonassoc LT LTE GT GTE EQ NEQ
%nonassoc ELSE

/* productiile no */
%%

/*     #Start symbol:
program -> "număr șefu () {" multiple_definitions multiple_statements "rezultă" int_const  "}" */
program: INT MAIN LPAREN RPAREN LBRACE multiple_declarations multiple_definitions multiple_statements RETURN INT_CONST SEMICOLON RBRACE
    { 
        record_production(70); 
        printf("E bun\n"); 
        printf("Productiile sunt: ");
        for (int i = 0; i < prod_count; i++) {
            printf("%d ", productions_used[i]);
        }
        printf("\n");
    }
;

type: CHAR { record_production(1); }
    | INT  { record_production(2); }
    | STRING  { record_production(3); }
    | BOOL { record_production(4); };

/* math_opp -> "*" | "+" | "-" | "+" | "/" | "%" | "==" */
math_opp: PLUS  { record_production(5); }
        | MINUS { record_production(6); }
        | MUL  { record_production(7); }
        | DIV  { record_production(8); }
        | EQ { record_production(9); };

/* math_expr -> multiple_math_expr math_opp multiple_math_expr | int */
math_expr : multiple_math_expr math_opp multiple_math_expr  { record_production(10); }
          | INT_CONST { record_production(11); };

/*  multiple_math_expr -> multiple_math_expr math_expr | math_expr */
multiple_math_expr: multiple_math_expr math_expr { record_production(12); }
                  | math_expr { record_production(13); };

/* relation -> "<" | "<=" | "=" | "!=" | ">=" | ">" */
relation : LT { record_production(14); }
        | LTE { record_production(15); }
        | EQ { record_production(16); }
        | NEQ { record_production(17); }
        | GTE { record_production(18); }
        | GT { record_production(19); };

/* expression -> math_expr | string | "sqrt(" ( identifier | const )  ")" */
expression : math_expr { record_production(20); }
           | STRING_LITERAL { record_production(21); }
           | SQRT LPAREN IDENTIFIER RPAREN { record_production(22); }
           | SQRT LPAREN INT_CONST RPAREN { record_production(23); };

/* condition -> expression relation expression | bool */
condition : expression relation expression { record_production(24); }
          | bool_const { record_production(25); };

//     char_definition -> "cara" identifier "=" char ";" 
char_definition : CHAR IDENTIFIER ASSIGN CHAR_LITERAL SEMICOLON { record_production(26); };

// string_definition -> "șir" identifier "=" string ";" 
string_definition : STRING IDENTIFIER ASSIGN STRING_LITERAL SEMICOLON { record_production(27); };

// int_definition -> "număr" identifier "=" (int | math_expr) ";"
int_definition : INT IDENTIFIER ASSIGN INT_CONST SEMICOLON { record_production(28); }
              | INT IDENTIFIER ASSIGN math_expr SEMICOLON { record_production(29); };

// bool_definition -> "bul" identifier "=" bool ";"
bool_definition : BOOL IDENTIFIER ASSIGN bool_const SEMICOLON { record_production(30); };

//     declaration -> type identifier ";"
declaration : type IDENTIFIER SEMICOLON { record_production(31); };

/*     multiple_declarations -> multiple_declarations declaration | ε */
multiple_declarations : declaration multiple_declarations { record_production(32); }
                      | { record_production(33); };

// struct -> "structură" identifier "{" multiple_declarations "}" 
struct : STRUCT_TYPE IDENTIFIER LBRACE multiple_declarations RBRACE { record_production(34); };

//     definition -> char_definition | int_definition | string_definition | struct 
definition : char_definition { record_production(35); }
           | int_definition { record_production(36); }
           | string_definition { record_production(37); }
           | struct { record_production(38); };
           | bool_definition { record_production(39); };

//     assignment_int -> identifier "=" int ";"
assignment_int : IDENTIFIER ASSIGN INT_CONST SEMICOLON { record_production(40); };

// assignment_char -> identifier "=" char ";"
assignment_char : IDENTIFIER ASSIGN CHAR_LITERAL SEMICOLON { record_production(41); };

// assignment_string -> identifier "=" string ";"  
assignment_string : IDENTIFIER ASSIGN STRING_LITERAL SEMICOLON { record_production(42); };

// assignment_struct -> identifier "." identifier "=" expression ";" 
assignment_struct : IDENTIFIER DOT IDENTIFIER ASSIGN expression SEMICOLON { record_production(43); }
;

//     assignment -> assignment_int | assignment_char | assignment_string | assignment_struct 
assignment : assignment_int { record_production(44); }
           | assignment_char { record_production(45); }
           | assignment_string { record_production(46); }
           | assignment_struct { record_production(47); }
           ;

/*     io_statement -> "citește" >> identifier | "scrie" << identifier */
io_statement : CIN STREAMOUT IDENTIFIER { record_production(48); }
             | COUT STREAMIN IDENTIFIER { record_production(49); }
             ;

/*     atomic_statement -> definition | assignment | io_statement  */
atomic_statement : definition { record_production(50); }
                | assignment { record_production(51); }
                | io_statement { record_production(51); }
                ;

/*     multiple_atomic_statements -> multiple_atomic_statements atomic_statement | ε */
multiple_atomic_statements : multiple_atomic_statements atomic_statement { record_production(53); }
                           | { record_production(54); }
                           ;

/*     if_statement -> "dacă" "(" condition ")" "{" multiple_atomic_statements "}" else_clause */
if_statement : IF LPAREN condition RPAREN LBRACE multiple_atomic_statements RBRACE else_clause { record_production(55); }
;

/*     else_clause -> "altfel" "{" multiple_atomic_statements "}" | ε */
else_clause : ELSE LBRACE multiple_atomic_statements RBRACE { record_production(56); }
            | { record_production(57); }
;

/*     while_statement -> "cât" "(" condition ")" "{" multiple_atomic_statements "}" */
while_statement : WHILE LPAREN condition RPAREN LBRACE multiple_atomic_statements RBRACE { record_production(58); }
;

/*     do_while -> "fă" "{" multiple_atomic_statements "}" "cât" "(" condition ")" ";" */
do_while : DO LBRACE multiple_atomic_statements RBRACE WHILE LPAREN condition RPAREN SEMICOLON { record_production(59); }
;

/*     statement -> atomic_statement | if_statement | while_statement | do_while */
statement : atomic_statement { record_production(60); }
          | if_statement { record_production(61); }
          | while_statement { record_production(62); }
          | do_while { record_production(63); }
;

//     multiple_definitions -> multiple_definitions definition | definition
multiple_definitions : definition multiple_definitions { record_production(64); }
                     | definition { record_production(65); }
                     | {}
;
// multiple_statements -> multiple_statements statement | statement 
multiple_statements : statement multiple_statements { record_production(66); }
                    | statement { record_production(67); }
                    | {}
;
bool_const: ADEV { record_production(68); }
    | FALS { record_production(69); };


/* sau trebuia sa pun invers toate astea? */
%%

void yyerror(const char *s) {
    fprintf(stderr, "EROAREEE: %s\n", s);
    if (prod_count > 0) {
        // productia cu eroarea
        int last_prod = productions_used[prod_count - 1];
        printf("Ultima productie buna: %d\n", last_prod);
    } else {
        printf("Nici n-am apucat sa reduc vreun product pana a aparut eroarea \n");
    }
    exit(1);
}

int main(int argc, char **argv) {
   yydebug = 1; 
    if (argc > 1) {
        yyin = fopen(argv[1], "r");
        if (!yyin) {
            perror("fopen");
            return 1;
        }
    } else {
        yyin = stdin;
    }

    if (!yyparse()) {
        // adica nu cred ca e nevoie ca gen deja sa dat print ca e ok
    } else {
        // yyerror o sa si dea call oricum
    }
    return 0;
}