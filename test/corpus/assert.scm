================================================================================
Assert Expression
================================================================================

void f() {
	assert(0);
}
--------------------------------------------------------------------------------

(source_file
  (function_declaration
    (type)
    (identifier)
    (parameters)
    (function_body
      (compound_statement
        (expression_statement
          (expression_list
            (assert_expression
              (assert_arguments
                (integer_literal)))))))))

================================================================================
Assert Expression Multiple arguments
================================================================================

void f() {
	assert(0, "xyz");
}
--------------------------------------------------------------------------------

(source_file
  (function_declaration
    (type)
    (identifier)
    (parameters)
    (function_body
      (compound_statement
        (expression_statement
          (expression_list
            (assert_expression
              (assert_arguments
                (integer_literal)
                (quoted_string_literal)))))))))

================================================================================
Static Assert Expression Multiple arguments
================================================================================

void f() {
	static assert(0, "xyz");
}
--------------------------------------------------------------------------------

(source_file
  (function_declaration
    (type)
    (identifier)
    (parameters)
    (function_body
      (compound_statement
        (static_assert_statement
          (assert_expression
            (assert_arguments
              (integer_literal)
              (quoted_string_literal))))))))
