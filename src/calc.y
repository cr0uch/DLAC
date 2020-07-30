%{
    #include <stdio.h>
    #include <stdlib.h>
    #include <math.h>
    #include <string.h>
    #define INT_LENGTH 12
    #define BUFFER_LENGTH 500
    /**
    *   Calculates the sum of the expression for i from a to b
    */
    float sum(int a, int b, char * expr);

    /**
    *   Calculates the product of the expression for i from a to b
    */
    float prod(int a, int b, char * expr);

    /**
    *   Converts an integer into a char pointer
    */
    char * convert(int a);

    /**
    *   Concatenates three char pointers and returns the new pointer
    */
    char * concat( char * a, char * b, char *c);

    /**
    *   Converts a float into a char pointer
    */
    char *convertfloat(float a);

    /**
    *   Replaces every char 'i' in the input char pointer by the replacement value 
    *   and writes it into the buffer
    */
    void replacechar(char * buffer, char * input, char * replacement);

    /**
    *   Returns i as char pointer
    */
    char * allocVar();
%}

%union {
    int intValue;
    float floatValue;
    char * stringValue;
}

%token <intValue> INT POSINT ZERO
%token <floatValue> FLOAT
%token <stringValue> PLUS MINUS TIMES DIVIDE LB RB COMMA VAR
%token PHI SUM PROD GCD TO 
%token EOL

%type <floatValue> expr term factor function syntax number
%type <stringValue> iexpr iterm ifactor 

%left PLUS MINUS
%left TIMES DIVIDE

%start line

%%
line: line syntax EOL
| syntax EOL
;

syntax: expr {printf("\nResult=%f\n", $1);}
;


expr: expr PLUS term  {$$=$1+$3;}
| expr MINUS term  {$$=$1-$3;}
| term {$$=$1;}
;


term: term TIMES factor {$$= $1 * $3;}    
| term DIVIDE factor { $$= $1 / $3;if($3==0) yyerror("Dividing by zero is not allowed");}
| factor {$$= $1;}    
;

factor: LB expr RB      {$$=$2;}
| FLOAT                 {$$=$1;}
| MINUS FLOAT           {$$=-$2;} 
| number                {$$=$1;}
| function              {$$=$1;}
;

number: POSINT      {$$=$1;}
| MINUS POSINT      {$$=-$2;}
| ZERO              {$$=$1;}
;


function: PHI LB POSINT RB  {$$=phi($3);}
| SUM number TO number LB iexpr RB {$$=sum($2,$4,$6);}
| PROD number TO number LB iexpr RB {$$=prod($2,$4,$6);}
| GCD LB POSINT COMMA POSINT RB {$$=gcd($3,$5);}
;

iexpr: iexpr PLUS iterm         {$$=concat($1,"+",$3);free($1);free($3);}
| iexpr MINUS iterm             {$$=concat($1,"-",$3);free($1);free($3);}
| iterm                         {$$=$1;}
;


iterm: iterm TIMES ifactor      {$$=concat($1,"*",$3);free($1);free($3);}
| iterm DIVIDE ifactor          {$$=concat($1,"/",$3);free($1);free($3);}
| ifactor                       {$$=$1;}
;

ifactor: LB iexpr RB    {$$=concat("(",$2,")"); free($2);}
| FLOAT                 {$$=convertfloat($1);}
| MINUS FLOAT           {$$=convertfloat(-$2);}
| number                {$$=convert($1);}
| VAR                   {$$=allocVar();} 
;



%%
int gcd(int a, int b) {
    int temp;
    while (b!=0) {
        temp = a%b;
        a = b;
        b = temp;
    }
    return a;
}

int phi(int input) {
    int count = 0;
    for(int i = 1; i< input;++i) {
        if(gcd(input, i) == 1) count++;
    }
    return count;
} 


float sum(int a, int b, char *expr) {
    float result=0.0, output;
    char * buffer = (char *) malloc(BUFFER_LENGTH);
    for(int i = a; i <= b; ++i) {
        output = 0.0;        
        for(int j = 0; j < BUFFER_LENGTH; ++j) buffer[j] = 0x0;
        replacechar(buffer, expr, convert(i));

        // enter the second parser
        ww_scan_string(buffer);
        wwparse(&output);
        result += output;        
    }
    free(buffer);
    free(expr);
    return result;

}

void replacechar(char * buffer, char * input, char * replacement) {
    int offset = 0;
    for(int i = 0; i < strlen(input);++i) {
        if(input[i] == 'i') {
            for(int j = 0; j < strlen(replacement); ++j) 
                buffer[i+offset+j] = replacement[j];                
            offset += strlen(replacement)-1;
        }
        else buffer[i+offset] = input[i];
    }
}

float prod(int a, int b, char * expr) {
    float result=0.0, output;
    char * buffer = (char *) malloc(BUFFER_LENGTH);
    for(int i = a; i <= b; ++i) {
        output = 0.0; 
        for(int j = 0; j < BUFFER_LENGTH; ++j) buffer[j] = '\0';
        replacechar(buffer, expr, convert(i));
        // enter the second parser
        ww_scan_string(buffer);
        wwparse(&output);
        if(i!=a) result *= output;
        else result = output;    
    }
    free(buffer);
    free(expr);
    
    return result;
}

char * convert(int a) {    
    char * snum = (char *) malloc(INT_LENGTH);
    for(int i = 0; i < INT_LENGTH; ++i) snum[i] = 0x0;
    snprintf(snum, INT_LENGTH, "%d", a);
    return snum;
}

char *convertfloat(float a) {
    int length = 20;
    char * snum = (char *) malloc(length);
    for(int i = 0; i < length; ++i) snum[i] = 0x0;
    snprintf(snum, length, "%f", a);
    for(int i = length-1; i >0; --i) {
        if(snum[i] == '0'||snum[i] == '\0' ) snum[i] = '\0';
        else break;
    }
    return snum;
}


char * concat(char * a, char * b, char *c) {
    char * concat = (char *) malloc(BUFFER_LENGTH); 
    for(int j = 0; j < BUFFER_LENGTH; ++j) concat[j] = '\0';
    for(int i = 0; i <strlen(a); ++i) {
        concat[i] = a[i];
    }
    for(int i = 0; i < strlen(b); ++i) {
        concat[strlen(a)+i] = b[i];
    }
    for(int i = 0; i<strlen(c); ++i) {
        concat[strlen(a)+strlen(b)+i] = c[i];
    }
    return concat;
}

char * allocVar() {
    char * i = (char *)malloc(2);    
    i[0] = 'i';
    i[1] = '\0'; 
    return i;
}