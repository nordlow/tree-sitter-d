================================================================================
Is expression
================================================================================

void f() {
	return is(primitive_type);
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
        (return_statement
          (expression
            (is_expression
              (is)
              (type
                (identifier)))))))))

================================================================================
Is expression specialization
================================================================================

void f() {
	return is(int: shared);
	return is(mytype == enum);
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
        (return_statement
          (expression
            (is_expression
              (is)
              (type
                (identifier))
              (type_specialization))))
        (return_statement
          (expression
            (is_expression
              (is)
              (type
                (identifier))
              (type_specialization
                (enum)))))))))

================================================================================
Is expression identifier
================================================================================

void f() {
	return is(int x: shared);
	return is(mytype == enum);
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
        (return_statement
          (expression
            (is_expression
              (is)
              (type
                (identifier))
              (identifier)
              (type_specialization))))
        (return_statement
          (expression
            (is_expression
              (is)
              (type
                (identifier))
              (type_specialization
                (enum)))))))))

================================================================================
Is expression templated
================================================================================

void f() {
	return is(int x: shared, X);
	return is(mytype == enum);
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
        (return_statement
          (expression
            (is_expression
              (is)
              (type
                (identifier))
              (identifier)
              (type_specialization)
              (template_parameter
                (identifier)))))
        (return_statement
          (expression
            (is_expression
              (is)
              (type
                (identifier))
              (type_specialization
                (enum)))))))))

================================================================================
Is identity expression
================================================================================

void f() {
	return x is null;
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
        (return_statement
          (expression
            (identity_binary_expression
              (identifier)
              (is))))))))

================================================================================
Is not identity expression
================================================================================

void f() {
	return x !is null;
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
        (return_statement
          (expression
            (identity_binary_expression
              (identifier)
              (not_is))))))))
