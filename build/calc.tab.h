/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2020 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

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

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

#ifndef YY_YY_BUILD_CALC_TAB_H_INCLUDED
# define YY_YY_BUILD_CALC_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    INT = 258,
    POSINT = 259,
    ZERO = 260,
    FLOAT = 261,
    PLUS = 262,
    MINUS = 263,
    TIMES = 264,
    DIVIDE = 265,
    LB = 266,
    RB = 267,
    COMMA = 268,
    VAR = 269,
    PHI = 270,
    SUM = 271,
    PROD = 272,
    GCD = 273,
    TO = 274,
    EOL = 275
  };
#endif
/* Tokens.  */
#define INT 258
#define POSINT 259
#define ZERO 260
#define FLOAT 261
#define PLUS 262
#define MINUS 263
#define TIMES 264
#define DIVIDE 265
#define LB 266
#define RB 267
#define COMMA 268
#define VAR 269
#define PHI 270
#define SUM 271
#define PROD 272
#define GCD 273
#define TO 274
#define EOL 275

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 45 "src/calc.y"

    int intValue;
    float floatValue;
    char * stringValue;

#line 103 "build/calc.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_BUILD_CALC_TAB_H_INCLUDED  */
