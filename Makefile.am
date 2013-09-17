bin_PROGRAMS = 42sh

42sh_SOURCES = src/main.c\
               src/main.h\
               src/builtin/cd.c\
               src/builtin/echo.c\
               src/builtin/alias.c\
               src/builtin/export.c\
               src/builtin/source.c\
               src/builtin/continue.c\
               src/builtin/break.c\
               src/builtin/shopt.c\
               src/builtin/shopt_print.c\
               src/builtin/exit.c\
               src/builtin/builtin.h\
               src/evalexpr/eval.c\
               src/evalexpr/arg_ges.c\
               src/evalexpr/astree.c\
               src/evalexpr/error.c\
               src/evalexpr/evalexpr.c\
               src/evalexpr/input.c\
               src/evalexpr/token.c\
               src/evalexpr/evalexpr.h\
               src/exec/env_vars1.c\
               src/exec/env_vars2.c\
               src/exec/spe_param1.c\
               src/exec/spe_param2.c\
               src/exec/ast_printer.c\
               src/exec/read_ast.c\
               src/exec/cmd_exec.c\
               src/exec/tools.c\
               src/exec/manage_var_fun.c\
               src/exec/quoting.c\
               src/exec/ast_printer.h\
               src/exec/cmd_exec.h\
               src/lexer/lexer.c\
               src/lexer/utility.c\
               src/lexer/lexer.h\
               src/parser/check.c\
               src/parser/check.h\
               src/parser/check_cmd.c\
               src/parser/check_cmd.h\
               src/parser/check_cond.c\
               src/parser/check_cond.h\
               src/parser/check_loop.c\
               src/parser/check_loop.h\
               src/parser/check_word.c\
               src/parser/check_word.h\
               src/parser/parser.c\
               src/parser/parser.h\
               src/parser/ast_tree.c\
               src/parser/ast_tree.h\
               src/parser/redirection.c\
               src/parser/redirection.h\
               src/parser/cond.c\
               src/parser/cond.h\
               src/option_parser/option_parser.c\
               src/option_parser/option_parser.h\
               src/option_parser/option_handlers.c\
               src/option_parser/option_handlers.h\
               src/option_parser/option_print.c\
               src/option_parser/option_print.h\
               src/option_parser/option_param.c\
               src/option_parser/option_parsing.h\
               src/prompt/prompt.c\
               src/prompt/advance_prompt.c\
               src/prompt/prompt_tools.c\
               src/prompt/prompt.h\
               src/readline/catch_input.c\
               src/readline/catch_input.h\
               src/readline/cursor_actions.c\
               src/readline/cursor_actions.h\
               src/readline/ctrl_handlers.c\
               src/readline/ctrl_handlers.h\
               src/readline/history.c\
               src/readline/history.h\
               src/readline/printing.c\
               src/readline/printing.h\
               src/readline/readline.c\
               src/readline/readline.h\
               src/alias/alias.c\
               src/alias/alias.h\
               src/alias/func_alias.c\
               src/main_tool.c
.PHONY: doc
doc:
	doxygen doc/Doxyfile
check:
	make -C test/
	./test/check.py
clean-local:
	rm -f *.swp
	rm -f */*.swp
	rm -f */*/*.swp
	rm -f */*/*/*.swp
	rm -f *~
	rm -f */*~
	rm -f */*/*~
	rm -f */*/*/*~
distclean-local:
	rm -rf doc/html doc/latex
	rm -f aclocal.m4
	rm -f Makefile.in
	rm -f Makefile
	rm -rf build-aux
	rm -f configure
	rm -rf build-aux
	rm -rf autom4te.cache
	rm -rf test/test_prg/lexer_test
	rm -rf test/test_prg/option_test
dist-hook:
	rm -rf $(distdir)/aclocal.m4
	rm -rf $(distdir)/build-aux
	rm -rf $(distdir)/configure
	rm -rf $(distdir)/Makefile.in
	cp -R test $(distdir)
	cp -Rf bootstrap $(distdir)
	cp -Rf doc $(distdir)
	rm -rf $(distdir)/doc/html $(distdir)/doc/latex

#program_LDADD=lib.a
#lib_LIBRARIES=mylib.a
#mylib_a_SOURCES=mylib.cc mylib.hh
#TEST=testprogram
#TEST=$(check_PROGRAMS)

