/* A Bison parser, made by GNU Bison 2.3.  */

/* Skeleton interface for Bison's Yacc-like parsers in C

   Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor,
   Boston, MA 02110-1301, USA.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     INT = 258,
     IF = 259,
     ELSE = 260,
     WHILE = 261,
     STRUCT_TYPE = 262,
     CIN = 263,
     COUT = 264,
     BOOL = 265,
     CHAR = 266,
     STRING = 267,
     INT_CONST = 268,
     STRING_LITERAL = 269,
     IDENTIFIER = 270,
     LBRACE = 271,
     RBRACE = 272,
     LPAREN = 273,
     RPAREN = 274,
     EQ = 275,
     NEQ = 276,
     LTE = 277,
     GTE = 278,
     LT = 279,
     GT = 280,
     ASSIGN = 281,
     SEMICOLON = 282,
     PLUS = 283,
     MINUS = 284,
     MUL = 285,
     DIV = 286,
     RETURN = 287,
     MAIN = 288,
     SQRT = 289,
     CHAR_LITERAL = 290,
     DOT = 291,
     STREAMIN = 292,
     STREAMOUT = 293,
     DO = 294,
     ADEV = 295,
     FALS = 296
   };
#endif
/* Tokens.  */
#define INT 258
#define IF 259
#define ELSE 260
#define WHILE 261
#define STRUCT_TYPE 262
#define CIN 263
#define COUT 264
#define BOOL 265
#define CHAR 266
#define STRING 267
#define INT_CONST 268
#define STRING_LITERAL 269
#define IDENTIFIER 270
#define LBRACE 271
#define RBRACE 272
#define LPAREN 273
#define RPAREN 274
#define EQ 275
#define NEQ 276
#define LTE 277
#define GTE 278
#define LT 279
#define GT 280
#define ASSIGN 281
#define SEMICOLON 282
#define PLUS 283
#define MINUS 284
#define MUL 285
#define DIV 286
#define RETURN 287
#define MAIN 288
#define SQRT 289
#define CHAR_LITERAL 290
#define DOT 291
#define STREAMIN 292
#define STREAMOUT 293
#define DO 294
#define ADEV 295
#define FALS 296




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;

