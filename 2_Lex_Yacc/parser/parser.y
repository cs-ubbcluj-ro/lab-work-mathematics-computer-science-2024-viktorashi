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

//doar ultimul production ca da buffer overflow nebun rau intra in ce memorie vrea cand fac arryu asta
char * last_production="nimic lol";

int prod_count = 0;

void record_production(char * production_name) {
    last_production = production_name;
}

%}

%token INT IF ELSE WHILE STRUCT_TYPE CIN COUT BOOL CHAR STRING INT_CONST STRING_LITERAL IDENTIFIER LBRACE RBRACE LPAREN RPAREN EQ NEQ LTE GTE LT GT ASSIGN SEMICOLON PLUS MINUS MUL DIV RETURN MAIN SQRT CHAR_LITERAL DOT STREAMIN STREAMOUT DO ADEV FALS MOD

/* ce e mai important */
%start program
%left PLUS MINUS
%left MUL DIV 
%nonassoc LT LTE GT GTE EQ NEQ
%nonassoc ELSE

/* productiile no */
%%

/*     #Start symbol:

program -> "numar sefu () {" multiple_declarations multiple_definitions multiple_statements "rezulta" int_const;  "}" */
program: INT MAIN LPAREN RPAREN LBRACE multiple_declarations multiple_definitions multiple_statements RETURN INT_CONST SEMICOLON RBRACE
    { 
        record_production("program"); 
        printf("\nE bunnnn\n"); 
        printf("Ultima productie buna: %s\n", last_production);
        printf("\n");
    }
;

type: CHAR { record_production("type char"); }
    | INT  { record_production("type int"); }
    | STRING  { record_production("type string"); }
    | BOOL { record_production("type bool"); };

/* math_opp -> "*" | "+" | "-" | "+" | "/" | "%" | "==" */
math_opp: PLUS  { record_production("plus"); }
        | MINUS { record_production("minus"); }
        | MUL  { record_production("mul"); }
        | DIV  { record_production("div"); }
        | EQ { record_production("eq"); };
        | MOD { record_production("mod"); };

/* math_expr -> multiple_math_expr math_opp multiple_math_expr | int */
math_expr : multiple_math_expr math_opp multiple_math_expr  { record_production("math"); }
          | INT_CONST { record_production("int const"); };
          | IDENTIFIER { record_production("identifier in math exp"); };
          | SQRT LPAREN IDENTIFIER RPAREN { record_production("radical identifier"); }
          | SQRT LPAREN INT_CONST RPAREN { record_production("radical const"); }
          ;

/*  multiple_math_expr -> multiple_math_expr math_expr | math_expr */
multiple_math_expr: multiple_math_expr math_expr { record_production("multiple math expr"); }
                  | math_expr { record_production("math_expr"); };

/* relation -> "<" | "<=" | "==" | "!=" | ">=" | ">" */
relation : LT { record_production("<"); }
        | LTE { record_production("<="); }
        | EQ { record_production("=="); }
        | NEQ { record_production("!="); }
        | GTE { record_production(">="); }
        | GT { record_production(">"); };

/* expression -> math_expr | string | "sqrt(" ( identifier | const )  ")" */
expression : math_expr { record_production("expression dar mate"); }
           | STRING_LITERAL { record_production("string literal"); }
           | bool_expression { record_production("bool expression"); }
           ;

/* bool_const -> 'adevar' | 'minciuna' */
bool_const: ADEV { record_production("adev"); }
          | FALS { record_production("minciunicaaaa"); };

/* condition -> expression relation expression | bool */
bool_expression : math_expr relation math_expr { record_production("math expression"); };
                | bool_const { record_production("bool const"); };
                | math_expr { record_production("math expr in bool exp"); };
                | IDENTIFIER relation IDENTIFIER { record_production("identifiers relation"); }
                | IDENTIFIER { record_production("identifier in bool exp"); };

//     char_definition -> "cara" identifier "=" char ";" 
char_definition : CHAR IDENTIFIER ASSIGN CHAR_LITERAL SEMICOLON { record_production("char_definition"); };

// string_definition -> "sir" identifier "=" string ";" 
string_definition : STRING IDENTIFIER ASSIGN STRING_LITERAL SEMICOLON { record_production("string_definition"); };

// int_definition -> "numar" identifier "=" (int_const | math_expr) ";"
int_definition : INT IDENTIFIER ASSIGN INT_CONST SEMICOLON { record_production("int_definition int const"); }
              | INT IDENTIFIER ASSIGN math_expr SEMICOLON { record_production("int def expresie"); };

// bool_definition -> "bul" identifier "=" bool ";"
bool_definition : BOOL IDENTIFIER ASSIGN bool_const SEMICOLON { record_production("bool_definition"); };

//     declaration -> type identifier ";"
declaration : type IDENTIFIER SEMICOLON { record_production("declaration"); };

/*     multiple_declarations -> multiple_declarations declaration | ε */
multiple_declarations : declaration multiple_declarations { record_production("multiple declarations "); }
                      | {};

// struct -> "structura" identifier "{" multiple_declarations "}" 
struct_definition : STRUCT_TYPE IDENTIFIER LBRACE multiple_declarations RBRACE { record_production("struct"); };

//     definition -> char_definition | int_definition | string_definition | struct 
definition : char_definition { record_production("char definition"); }
           | int_definition { record_production("int definition"); }
           | string_definition { record_production("string definition"); }
           | struct_definition { record_production("struct definition"); };
           | bool_definition { record_production("bool definition"); };

//     assignment_int -> identifier "=" int ";"
int_assignment : IDENTIFIER ASSIGN INT_CONST SEMICOLON { record_production("assignment_int"); };
                | IDENTIFIER ASSIGN math_expr SEMICOLON { record_production("assignment_int cu math_expr"); };

// assignment_char -> identifier "=" char ";"
char_assignment : IDENTIFIER ASSIGN CHAR_LITERAL SEMICOLON { record_production("assignment_char");};

// assignment_string -> identifier "=" string ";"  
string_assignment : IDENTIFIER ASSIGN STRING_LITERAL SEMICOLON { record_production("assignment_string"); };

// assignment_struct -> identifier "." identifier "=" expression ";" 
struct_assignment : IDENTIFIER DOT IDENTIFIER ASSIGN expression SEMICOLON { record_production("assignment_struct"); } ;

//bool_assignment -> identifier "=" bool ";"
bool_assignment : IDENTIFIER ASSIGN bool_const SEMICOLON { record_production("bool assignment"); };

//     assignment -> assignment_int | assignment_char | assignment_string | assignment_struct 
assignment : int_assignment { record_production("int assignment"); }
           | char_assignment { record_production("char assignment"); }
           | string_assignment { record_production("string assignment"); }
           | struct_assignment { record_production("struct assignment"); }
           | bool_assignment { record_production("bool assignment"); }
           | IDENTIFIER ASSIGN IDENTIFIER SEMICOLON { record_production("assign from identifier"); }
           ;

// chain_streamin_operator -> ( << identifier | << expression ) chain_streamin_operator | ε
chain_streamin_operator : STREAMIN IDENTIFIER chain_streamin_operator { record_production("streamin op cu id"); }
                        | STREAMIN expression chain_streamin_operator { record_production("streamin op cu expr"); }
                        | {}
                        ;

/*     io_statement -> "citeste" >> identifier | "scrie" << identifier */
io_statement : CIN STREAMOUT IDENTIFIER SEMICOLON { record_production("cin"); }
             | COUT chain_streamin_operator SEMICOLON { record_production("cout statement"); }
             ;

/*     atomic_statement -> definition | assignment | io_statement  */
atomic_statement : definition { record_production("atomic def"); }
                | assignment { record_production("atomic assignment"); }
                | io_statement { record_production("atomic io statement"); }
                ;

/*     multiple_atomic_statements -> multiple_atomic_statements atomic_statement | ε */
multiple_atomic_statements : multiple_atomic_statements atomic_statement { record_production("multiple_atomic_statements"); }
                           | {}
                           ;

/*     if_statement -> "daca" "(" condition ")" "{" multiple_statements "}" else_clause */
if_statement : IF LPAREN bool_expression RPAREN LBRACE multiple_statements RBRACE else_clause { record_production("if_statement"); }
;

/*     else_clause -> "altfel" "{" multiple_statements "}" | ε */
else_clause : ELSE LBRACE multiple_statements RBRACE { record_production("else_clause"); }
            | { record_production("gol din else clause"); }
;

/*     while_statement -> "cat" "(" condition ")" "{" multiple_statements "}" */
while_statement : WHILE LPAREN bool_expression RPAREN LBRACE multiple_statements RBRACE { record_production("while_statement"); }
;

/*     do_while -> "fa" "{" multiple_statements "}" "cat" "(" condition ")" ";" */
do_while : DO LBRACE multiple_statements RBRACE WHILE LPAREN bool_expression RPAREN SEMICOLON { record_production("do_while"); }
;

/*     statement -> atomic_statement | if_statement | while_statement | do_while */
statement : atomic_statement { record_production("atomic statement"); }
          | if_statement { record_production("if statement"); }
          | while_statement { record_production("while statement"); }
          | do_while { record_production("do statement"); }
;

//     multiple_definitions -> multiple_definitions definition | definition
multiple_definitions : definition multiple_definitions { record_production("multiple def 1"); }
                     | definition { record_production("multiple def 2"); }
                     | {}
;
// multiple_statements -> multiple_statements statement | statement 
multiple_statements : statement multiple_statements { record_production("multiple statements"); }
                    | statement { record_production("statement"); }
                    | {}
;



/* sau trebuia sa pun invers toate astea? sincer creca nu  */
%%

void yyerror(const char *s) {
    fprintf(stderr, "EROAREEE: %s\n", s);
    printf("Ultima productie buna: %s\n", last_production);
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
        printf("ok gataa e totu binee ✅✅✅✅\n");
    } else {
        printf("nu stiu cek kt are sincer sa fiu lmao ❌❌❌❌\n");
    }
    return 0;
}