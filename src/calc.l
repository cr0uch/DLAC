%{
#include "../build/calc.tab.h"
#include <stdio.h>
#include <string.h>
int yyerror(char *errormsg);
int yyparse();
%}
NONZERO [1-9]
ZERO [0]
DIGIT [0]|{NONZERO}
POSINT {NONZERO}{DIGIT}*
FLOAT {POSINT}("."{DIGIT}+)?
%%
{ZERO} {yylval.intValue = atoi(yytext); return ZERO;}
{POSINT} {if(atoi(yytext) < 0) yyerror("Input number too big or too small");yylval.intValue =atoi(yytext); return POSINT; }
{FLOAT} { yylval.floatValue =atof(yytext); return FLOAT; }
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
"," { 
      //printf("Comma Separator: %s\n", yytext); 
      return COMMA; 
}
[pP][hH][iI] { 
      //printf("Phi function: %s\n", yytext); 
      return PHI; 
}
[sS][uU][mM] { 
      //printf("Sum function: %s\n", yytext); 
      return SUM; 
}
[pP][rR][oO][dD] { 
      //printf("Prod function: %s\n", yytext); 
      return PROD; 
}
[gG][cC][dD] { 
      //printf("GCD function: %s\n", yytext); 
      return GCD; 
}
[tT][oO] { 
      //printf("TO Separator: %s\n", yytext); 
      return TO; 
}
[i] { 
      //printf("i Variable: %s\n", yytext); 
      return VAR; 
}

[ \t\r]+ {/* Do nothing at whitespace - eat it! */}
[\n] {return EOL;}
"E" {printf("Exiting the calculator.\n"); return 0; }
. { printf("ERROR: %s\n\n", yytext);yyerror("Unknown char in Calculator"); }


%%

int yywrap(void) {
   return 0;
}

int yyerror(char *errormsg) {
   fprintf(stderr, "%s\n", errormsg);
   

   exit(1);
}

int main(int argc, char * argv[]) {
  
   ++argv, --argc;
    if(argc > 0){

      if(!(yyin = fopen(argv[0],"r")) ){
       exit(255);
      }
    }else{
    }
      
    yyparse();

    return 0;
}


