grammar Challenge2_LoxLexer;

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
/* Output
[@0,0:2='fun',<'fun'>,1:0]
[@1,4:6='fib',<NAME>,1:4]
[@2,7:9='(x)',<PARAMETER_LIST>,1:7]
[@3,11:11='{',<'{'>,1:11]
[@4,17:18='if',<'if'>,2:4]
[@5,20:20='(',<'('>,2:7]
[@6,21:21='x',<NAME>,2:8]
[@7,23:24='==',<'=='>,2:10]
[@8,26:26='0',<INTEGER_CONSTANT>,2:13]
[@9,27:27=')',<')'>,2:14]
[@10,29:29='{',<'{'>,2:16]
[@11,39:44='return',<'return'>,3:8]
[@12,46:46='0',<INTEGER_CONSTANT>,3:15]
[@13,47:47=';',<';'>,3:16]
[@14,53:53='}',<'}'>,4:4]
[@15,55:58='else',<'else'>,4:6]
[@16,60:60='{',<'{'>,4:11]
[@17,70:71='if',<'if'>,5:8]
[@18,73:73='(',<'('>,5:11]
[@19,74:74='x',<NAME>,5:12]
[@20,76:77='==',<'=='>,5:14]
[@21,79:79='1',<INTEGER_CONSTANT>,5:17]
[@22,80:80=')',<')'>,5:18]
[@23,82:82='{',<'{'>,5:20]
[@24,96:101='return',<'return'>,6:12]
[@25,103:103='1',<INTEGER_CONSTANT>,6:19]
[@26,104:104=';',<';'>,6:20]
[@27,114:114='}',<'}'>,7:8]
[@28,116:119='else',<'else'>,7:10]
[@29,121:121='{',<'{'>,7:15]
[@30,135:137='fib',<NAME>,8:12]
[@31,138:138='(',<'('>,8:15]
[@32,139:139='x',<NAME>,8:16]
[@33,141:141='-',<'-'>,8:18]
[@34,143:143='1',<INTEGER_CONSTANT>,8:20]
[@35,144:144=')',<')'>,8:21]
[@36,146:146='+',<'+'>,8:23]
[@37,148:150='fib',<NAME>,8:25]
[@38,151:151='(',<'('>,8:28]
[@39,152:152='x',<NAME>,8:29]
[@40,154:154='-',<'-'>,8:31]
[@41,156:156='2',<INTEGER_CONSTANT>,8:33]
[@42,157:157=')',<')'>,8:34]
[@43,158:158=';',<';'>,8:35]
[@44,168:168='}',<'}'>,9:8]
[@45,174:174='}',<'}'>,10:4]
[@46,176:176='}',<'}'>,11:0]
[@47,179:181='var',<'var'>,13:0]
[@48,183:188='wuppie',<NAME>,13:4]
[@49,190:190='=',<'='>,13:11]
[@50,192:194='fib',<NAME>,13:13]
[@51,195:195='(',<'('>,13:16]
[@52,196:196='4',<INTEGER_CONSTANT>,13:17]
[@53,197:197=')',<')'>,13:18]
[@54,198:198=';',<';'>,13:19]
[@55,200:199='<EOF>',<EOF>,14:0]
*/

start   : (FUNCTION_KEYWORD
| VAR_KEYWORD
| SCOPE_START
| SCOPE_END
| OPEN_PARANTHESE
| CLOSE_PARANTHESE
| ASIGNMENT
| RETURN
| STATEMENT_END
| MINUS
| PLUS
| LESS_THAN
| MORE_THAN
| LESS_OR_EQUAL
| MORE_OR_EQUAL
| EQUALS
| IS_DIFFERENT
| IF
| ELSE
| NAME
| INTEGER_CONSTANT
            )+ ;

FUNCTION_KEYWORD: 'fun';
VAR_KEYWORD: 'var';

SCOPE_START: '{';
SCOPE_END: '}';
OPEN_PARANTHESE: '(';
CLOSE_PARANTHESE: ')';

ASIGNMENT: '=';
RETURN: 'return';
STATEMENT_END: ';';

// math
MINUS: '-';
PLUS: '+';

// comparison operators
LESS_THAN : '<';
MORE_THAN : '>';
LESS_OR_EQUAL : '<=';
MORE_OR_EQUAL : '>=';
EQUALS : '==';
IS_DIFFERENT : '<>';

// keywords
IF: 'if';
ELSE: 'else';

//others
NAME: IDENTIFIER;
INTEGER_CONSTANT: DIGIT+;

WHITESPACE  : [ \t\n]+ -> skip ;
fragment
IDENTIFIER: CHAR [a-zA-Z0-9]*;
fragment
CHAR   : [a-zA-Z] ;
fragment
DIGIT  : [0-9] ;
