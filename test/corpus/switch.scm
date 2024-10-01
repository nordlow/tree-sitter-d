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
    (compound_statement
      (switch_statement
        (identifier)
        (scope_statement
          (compound_statement
            (case_statement
              (expression_list
                (character_literal))
              (break_statement))
            (case_statement
              (break_statement))))))))

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
    (compound_statement
      (switch_statement
        (identifier)
        (scope_statement
          (compound_statement
            (case_statement
              (character_literal)
              (character_literal)
              (break_statement))
            (case_statement
              (break_statement))))))))

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
    (compound_statement
      (switch_statement
        (identifier)
        (scope_statement
          (compound_statement
            (case_statement
              (expression_list
                (character_literal)
                (character_literal)
                (character_literal))
              (break_statement))))))))

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
      (compound_statement
        (switch_statement
          (identifier)
          (scope_statement
            (variable_declaration
              (type
                (identifier))
              (declarator
                (identifier)
                (integer_literal)))))))))
