package prettyprinter;

import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.tree.ParseTree;
import org.antlr.v4.runtime.tree.ParseTreeWalker;
import prettyprinter.gen.*;

import java.io.IOException;

public class Main {
    public static void main(String[] args) throws IOException {
        Challenge2_LoxParserLexer lexer = new Challenge2_LoxParserLexer(CharStreams.fromStream(System.in));
        CommonTokenStream tokens = new CommonTokenStream(lexer);
        Challenge2_LoxParserParser parser = new Challenge2_LoxParserParser(tokens);

        ParseTreeWalker walker = new ParseTreeWalker();
        PrettyPrinterListener prettyPrinterListener = new PrettyPrinterListener(4);
        ParseTree tree = parser.start();
        walker.walk(prettyPrinterListener, tree);
        System.out.println(prettyPrinterListener.result);
    }

    private static class ExpressionVisitor extends Challenge2_LoxParserBaseVisitor<String> {

        @Override
        public String visitDash(Challenge2_LoxParserParser.DashContext ctx) {
            return visitExpression(ctx.expression(0)) + " " + ctx.DASH_OPERATOR().getText() + " " + visitExpression(ctx.expression(1));
        }

        @Override
        public String visitDot(Challenge2_LoxParserParser.DotContext ctx) {
            return visitExpression(ctx.expression(0)) + " " + ctx.DOT_OPERATOR().getText() + " " + visitExpression(ctx.expression(1));
        }

        public String visitExpression(Challenge2_LoxParserParser.ExpressionContext ctx) {
            String result = "";
            if (ctx instanceof Challenge2_LoxParserParser.IdentifierContext) {
                result = ctx.getText();
            } else if (ctx instanceof Challenge2_LoxParserParser.DashContext dashContext) {
                result = visitDash(dashContext);
            } else if (ctx instanceof Challenge2_LoxParserParser.DotContext dotContext) {
                result = visitDot(dotContext);
            } else if (ctx instanceof Challenge2_LoxParserParser.IntegerContext) {
                result = ctx.getText();
            } else if (ctx instanceof Challenge2_LoxParserParser.CallContext callContext) {
                result = callContext.functionCall().IDENTIFIER() + "(" + new ExpressionVisitor().visitExpression(callContext.functionCall().expression()) + ")";
            }

            return result;
        }
    }

    private static class PrettyPrinterListener extends Challenge2_LoxParserBaseListener {

        private final int indentation;
        private static final String SPACE = " ";
        private int currentLevel = 0;

        public String result = "";

        private PrettyPrinterListener(int indentation) {
            this.indentation = indentation;
        }

        private String currentPrefix() {
            return SPACE.repeat(currentLevel * indentation);
        }

        @Override
        public void enterFunctionDeclaration(Challenge2_LoxParserParser.FunctionDeclarationContext ctx) {
            result += "fun " +ctx.IDENTIFIER();
        }

        @Override
        public void enterParameterList(Challenge2_LoxParserParser.ParameterListContext ctx) {
            result += "(" + ctx.getText().replace(",", ", ") + ")";
        }

        @Override
        public void enterBlock(Challenge2_LoxParserParser.BlockContext ctx) {
            result += " {\n";
            currentLevel++;
        }

        @Override
        public void exitBlock(Challenge2_LoxParserParser.BlockContext ctx) {
            currentLevel--;
            result += currentPrefix() + "}";
            if (ctx.parent instanceof Challenge2_LoxParserParser.IfStatementContext ifStatementContext) {
                if(ifStatementContext.block(0) == ctx && ifStatementContext.ELSE() != null) {
                    result += " else";
                }
                else {
                    result += "\n";
                }
            }
            else {
                result += "\n";
            }
        }

        @Override
        public void enterIfStatement(Challenge2_LoxParserParser.IfStatementContext ctx) {
           result += "if ("
               + ctx.boolExpression().IDENTIFIER().getText()
               + " "
               + ctx.boolExpression().COMPARISON().getText()
               + " "
               + ctx.boolExpression().INTEGER_CONSTANT().getText()
               + ")";
        }

        @Override
        public void enterReturnStatement(Challenge2_LoxParserParser.ReturnStatementContext ctx) {
            result += "return " + ctx.value.getText();
        }

        @Override
        public void enterStatement(Challenge2_LoxParserParser.StatementContext ctx) {
            result += currentPrefix();
            if(ctx.expression() != null) {
                result += new ExpressionVisitor().visitExpression(ctx.expression());
            }
        }

        @Override
        public void exitStatement(Challenge2_LoxParserParser.StatementContext ctx) {
            if(ctx.ifStatement() == null && ctx.functionDeclaration() == null) {
                result += ";\n";
            }
        }

        @Override
        public void enterAssignment(Challenge2_LoxParserParser.AssignmentContext ctx) {
            result += "var " +  ctx.IDENTIFIER() + " = " + new ExpressionVisitor().visitExpression(ctx.expression());
        }
    }
}
