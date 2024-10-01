================================================================================
Is expression
================================================================================

void f() {
	return is(primitive_type);
}
--------------------------------------------------------------------------------

(source_file
  (function_declaration
    (type)
    (identifier)
    (parameters)
    (function_body
      (compound_statement
        (return_statement
          (is_expression
            (type
              (identifier))))))))

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
    (type)
    (identifier)
    (parameters)
    (function_body
      (compound_statement
        (return_statement
          (is_expression
            (type
              (identifier))
            (type_specialization)))
        (return_statement
          (is_expression
            (type
              (identifier))
            (type_specialization)))))))

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
    (type)
    (identifier)
    (parameters)
    (function_body
      (compound_statement
        (return_statement
          (is_expression
            (type
              (identifier))
            (identifier)
            (type_specialization)))
        (return_statement
          (is_expression
            (type
              (identifier))
            (type_specialization)))))))

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
    (type)
    (identifier)
    (parameters)
    (function_body
      (compound_statement
        (return_statement
          (is_expression
            (type
              (identifier))
            (identifier)
            (type_specialization)
            (template_parameter
              (identifier))))
        (return_statement
          (is_expression
            (type
              (identifier))
            (type_specialization)))))))

================================================================================
Is identity expression
================================================================================

void f() {
	return x is null;
}
--------------------------------------------------------------------------------

(source_file
  (function_declaration
    (type)
    (identifier)
    (parameters)
    (function_body
      (compound_statement
        (return_statement
          (identity_binary_expression
            (identifier)))))))

================================================================================
Is not identity expression
================================================================================

void f() {
	return x !is null;
}
--------------------------------------------------------------------------------

(source_file
  (function_declaration
    (type)
    (identifier)
    (parameters)
    (function_body
      (compound_statement
        (return_statement
          (identity_binary_expression
            (identifier)
            (not_is)))))))
