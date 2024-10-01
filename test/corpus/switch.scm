================================================================================
Switch statement
================================================================================

unittest {
	switch (c) {
		case 'A':
			break;
		default:
			break;
	}
}
--------------------------------------------------------------------------------

(source_file
  (unittest_declaration
    (unittest)
    (block_statement
      (switch_statement
        (switch)
        (expression
          (identifier))
        (scope_statement
          (block_statement
            (case_statement
              (case)
              (expression_list
                (character_literal))
              (break_statement
                (break)))
            (case_statement
              (default)
              (break_statement
                (break)))))))))

================================================================================
Case range statement
================================================================================

unittest {
	switch (c) {
		case 'A': .. case 'Z':
			break;
		default:
			break;
	}
}
--------------------------------------------------------------------------------

(source_file
  (unittest_declaration
    (unittest)
    (block_statement
      (switch_statement
        (switch)
        (expression
          (identifier))
        (scope_statement
          (block_statement
            (case_statement
              (case)
              (expression
                (character_literal))
              (case)
              (expression
                (character_literal))
              (break_statement
                (break)))
            (case_statement
              (default)
              (break_statement
                (break)))))))))

================================================================================
Case statement multiple args
================================================================================

unittest {
	switch (c) {
		case 'A', 'B', 'C':
			break;
	}
}
--------------------------------------------------------------------------------

(source_file
  (unittest_declaration
    (unittest)
    (block_statement
      (switch_statement
        (switch)
        (expression
          (identifier))
        (scope_statement
          (block_statement
            (case_statement
              (case)
              (expression_list
                (character_literal)
                (character_literal)
                (character_literal))
              (break_statement
                (break)))))))))

================================================================================
Switch statement with declaration
================================================================================
int f() {
  switch (v) int x = 1;
}
--------------------------------------------------------------------------------

(source_file
  (function_declaration
    (type
      (identifier))
    (identifier)
    (parameters)
    (function_body
      (block_statement
        (switch_statement
          (switch)
          (expression
            (identifier))
          (scope_statement
            (variable_declaration
              (type
                (identifier))
              (declarator
                (identifier)
                (integer_literal)))))))))
