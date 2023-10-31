grammar Challenge2_LoxParser;

/* Test Code:
fun fib(x) {
    if (x == 0) {
        return 0;
    } else {
        if (x == 1) {
            return 1;
        } else {
            fib(x - 1) + fib(x - 2);
        }
    }
}

var wuppie = fib(4);
*/

start: statement* EOF;
statement: functionDeclaration | ifStatement | returnStatement | expression STATEMENT_END | assignment STATEMENT_END;
functionDeclaration: FUNCTION_KEYWORD IDENTIFIER OPEN_PARANTHESE parameterList CLOSE_PARANTHESE block;
parameterList: (IDENTIFIER (COMMA IDENTIFIER)*)?;
block: SCOPE_START statement* SCOPE_END;
ifStatement: IF OPEN_PARANTHESE boolExpression CLOSE_PARANTHESE block (ELSE block)?;
boolExpression: IDENTIFIER COMPARISON INTEGER_CONSTANT;
returnStatement: RETURN (IDENTIFIER | INTEGER_CONSTANT) STATEMENT_END;

expression: expression DOT_OPERATOR expression | expression DASH_OPERATOR expression | functionCall | IDENTIFIER | INTEGER_CONSTANT;
functionCall: IDENTIFIER OPEN_PARANTHESE expression CLOSE_PARANTHESE;

assignment: VAR_KEYWORD IDENTIFIER ASIGNMENT expression;

FUNCTION_KEYWORD: 'fun';
VAR_KEYWORD: 'var';

SCOPE_START: '{';
SCOPE_END: '}';
OPEN_PARANTHESE: '(';
CLOSE_PARANTHESE: ')';

ASIGNMENT: '=';
RETURN: 'return';
STATEMENT_END: ';';
COMMA: ',';

DOT_OPERATOR: '*' | '/';
DASH_OPERATOR: '-' | '+';
COMPARISON : '<' | '>' | '<=' | '>=' | '==' | '<>';

// keywords
IF: 'if';
ELSE: 'else';

INTEGER_CONSTANT: DIGIT+;
IDENTIFIER: CHAR [a-zA-Z0-9]*;

WHITESPACE  : [ \t\n]+ -> skip ;
fragment
CHAR   : [a-zA-Z] ;
fragment
DIGIT  : [0-9] ;
