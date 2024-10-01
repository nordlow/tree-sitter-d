================================================================================
Empty for loop
================================================================================

void f() {
	for (;;) {}
}
--------------------------------------------------------------------------------

(source_file
  (function_declaration
    (type
      (void))
    (identifier)
    (parameters)
    (function_body
      (block_statement
        (for_statement
          (scope_statement
            (block_statement)))))))

================================================================================
Empty for loop no step
================================================================================

void f() {
	for (;) {}
}
--------------------------------------------------------------------------------

(source_file
  (function_declaration
    (type
      (void))
    (identifier)
    (parameters)
    (function_body
      (block_statement
        (for_statement
          (scope_statement
            (block_statement)))))))

================================================================================
For loop init only
================================================================================

void f() {
	for (i = 1;) {}
}
--------------------------------------------------------------------------------

(source_file
  (function_declaration
    (type
      (void))
    (identifier)
    (parameters)
    (function_body
      (block_statement
        (for_statement
          (expression_statement
            (expression_list
              (assignment_expression
                (identifier)
                (integer_literal))))
          (scope_statement
            (block_statement)))))))

================================================================================
For loop init declaration
================================================================================

void f() {
	for (int i = 1;) {}
}
--------------------------------------------------------------------------------

(source_file
  (function_declaration
    (type
      (void))
    (identifier)
    (parameters)
    (function_body
      (block_statement
        (for_statement
          (variable_declaration
            (type
              (identifier))
            (declarator
              (identifier)
              (integer_literal)))
          (scope_statement
            (block_statement)))))))

================================================================================
For loop no step
================================================================================

void f() {
	for (i = 1; i < 10) {}
}
--------------------------------------------------------------------------------

(source_file
  (function_declaration
    (type
      (void))
    (identifier)
    (parameters)
    (function_body
      (block_statement
        (for_statement
          (expression_statement
            (expression_list
              (assignment_expression
                (identifier)
                (integer_literal))))
          (expression
            (rel_binary_expression
              (identifier)
              (integer_literal)))
          (scope_statement
            (block_statement)))))))

================================================================================
For loop no test
================================================================================

void f() {
	for (i = 1;; i++) {}
}
--------------------------------------------------------------------------------

(source_file
  (function_declaration
    (type
      (void))
    (identifier)
    (parameters)
    (function_body
      (block_statement
        (for_statement
          (expression_statement
            (expression_list
              (assignment_expression
                (identifier)
                (integer_literal))))
          (expression_list
            (postfix_expression
              (identifier)))
          (scope_statement
            (block_statement)))))))

================================================================================
For loop no init
================================================================================

void f() {
	for (; i; i++) {}
}
--------------------------------------------------------------------------------

(source_file
  (function_declaration
    (type
      (void))
    (identifier)
    (parameters)
    (function_body
      (block_statement
        (for_statement
          (expression
            (identifier))
          (expression_list
            (postfix_expression
              (identifier)))
          (scope_statement
            (block_statement)))))))

================================================================================
For loop step only
================================================================================

void f() {
	for (; ; i++) {}
}
--------------------------------------------------------------------------------

(source_file
  (function_declaration
    (type
      (void))
    (identifier)
    (parameters)
    (function_body
      (block_statement
        (for_statement
          (expression_list
            (postfix_expression
              (identifier)))
          (scope_statement
            (block_statement)))))))

================================================================================
For loop test only
================================================================================

void f() {
	for (; i != 0;) {}
}
--------------------------------------------------------------------------------

(source_file
  (function_declaration
    (type
      (void))
    (identifier)
    (parameters)
    (function_body
      (block_statement
        (for_statement
          (expression
            (equal_binary_expression
              (identifier)
              (integer_literal)))
          (scope_statement
            (block_statement)))))))

================================================================================
For loop test only 2 clause
================================================================================

void f() {
	for (; i != 0) {}
}
--------------------------------------------------------------------------------

(source_file
  (function_declaration
    (type
      (void))
    (identifier)
    (parameters)
    (function_body
      (block_statement
        (for_statement
          (expression
            (equal_binary_expression
              (identifier)
              (integer_literal)))
          (scope_statement
            (block_statement)))))))

================================================================================
For loop 3 clause
================================================================================

void f() {
	for (int i = 100; i != 0; i--) {}
}
--------------------------------------------------------------------------------

(source_file
  (function_declaration
    (type
      (void))
    (identifier)
    (parameters)
    (function_body
      (block_statement
        (for_statement
          (variable_declaration
            (type
              (identifier))
            (declarator
              (identifier)
              (integer_literal)))
          (expression
            (equal_binary_expression
              (identifier)
              (integer_literal)))
          (expression_list
            (postfix_expression
              (identifier)))
          (scope_statement
            (block_statement)))))))

================================================================================
For loop comma expressions
================================================================================

void f() {
	for (int i = 100; i != 0; i--, ++x) {}
}
--------------------------------------------------------------------------------

(source_file
  (function_declaration
    (type
      (void))
    (identifier)
    (parameters)
    (function_body
      (block_statement
        (for_statement
          (variable_declaration
            (type
              (identifier))
            (declarator
              (identifier)
              (integer_literal)))
          (expression
            (equal_binary_expression
              (identifier)
              (integer_literal)))
          (expression_list
            (postfix_expression
              (identifier))
            (unary_expression
              (identifier)))
          (scope_statement
            (block_statement)))))))
