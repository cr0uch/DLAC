%option noyywrap
%option prefix="ww"
%{
      #include "../build/iexpr.tab.h"
      #include <stdio.h>
      #include <string.h>
      int wwerror(char *errormsg);
      int wwparse(float *result);
%}
NONZERO [1-9]
ZERO [0]
DIGIT [0]|{NONZERO}
POSINT {NONZERO}{DIGIT}*
FLOAT {POSINT}("."{DIGIT}+)?
%%
{ZERO} {wwlval.intValue = atoi(yytext); return ZERO;}
{POSINT} {wwlval.intValue =atoi(yytext); return POSINT; }
{FLOAT} { wwlval.floatValue =atof(yytext); return FLOAT; }
"+" { 
      //printf("Addition Operator: %s\n", yytext);
      return PLUS; 
}
"*" { 
      //printf("Multiplication Operator: %s\n", yytext);
      return TIMES; 
}
"-" { 
      //printf("Subtraction Operator: %s\n", yytext);
      return MINUS; 
}
"/" { 
      //printf("Divison Operator: %s\n", yytext);
      return DIVIDE; 
}
"(" { 
      //printf("Opening Bracket: %s\n", yytext);
      return LB; 
}
")" { 
      //printf("Closing Bracket: %s\n", yytext); 
      return RB; 
}
[ \t\n]+ {/* Do nothing at whitespace - eat it! */}
. { printf("%c", yytext); wwerror("Unknown char in IExpression"); }
%%

int wwerror(char *errormsg) {
   fprintf(stderr, "%s\n", errormsg);
   exit(1);
}
