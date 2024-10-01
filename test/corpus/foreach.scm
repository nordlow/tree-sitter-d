================================================================================
Simple foreach
================================================================================

void f() {
	foreach (item; range) {}
}
--------------------------------------------------------------------------------

(source_file
  (function_declaration
    (type)
    (identifier)
    (parameters)
    (function_body
      (compound_statement
        (foreach_statement
          (foreach_type
            (identifier))
          (identifier)
          (scope_statement
            (compound_statement)))))))

================================================================================
Simple foreach reverse
================================================================================

void f() {
	foreach_reverse (item; range) {}
}
--------------------------------------------------------------------------------

(source_file
  (function_declaration
    (type)
    (identifier)
    (parameters)
    (function_body
      (compound_statement
        (foreach_statement
          (foreach_type
            (identifier))
          (identifier)
          (scope_statement
            (compound_statement)))))))

================================================================================
Typed foreach
================================================================================

void f() {
	foreach (int item; range) {}
}
--------------------------------------------------------------------------------

(source_file
  (function_declaration
    (type)
    (identifier)
    (parameters)
    (function_body
      (compound_statement
        (foreach_statement
          (foreach_type
            (type
              (identifier))
            (identifier))
          (identifier)
          (scope_statement
            (compound_statement)))))))

================================================================================
Multiple value foreach
================================================================================

void f() {
	foreach (int key, char value; range) {}
}
--------------------------------------------------------------------------------

(source_file
  (function_declaration
    (type)
    (identifier)
    (parameters)
    (function_body
      (compound_statement
        (foreach_statement
          (foreach_type
            (type
              (identifier))
            (identifier))
          (foreach_type
            (type
              (identifier))
            (identifier))
          (identifier)
          (scope_statement
            (compound_statement)))))))

================================================================================
Range foreach
================================================================================

void f() {
	foreach (i; start .. end) {}
}
--------------------------------------------------------------------------------

(source_file
  (function_declaration
    (type)
    (identifier)
    (parameters)
    (function_body
      (compound_statement
        (foreach_statement
          (foreach_type
            (identifier))
          (identifier)
          (identifier)
          (scope_statement
            (compound_statement)))))))

================================================================================
Range foreach typed
================================================================================

void f() {
	foreach (int i; start .. end) {}
}
--------------------------------------------------------------------------------

(source_file
  (function_declaration
    (type)
    (identifier)
    (parameters)
    (function_body
      (compound_statement
        (foreach_statement
          (foreach_type
            (type
              (identifier))
            (identifier))
          (identifier)
          (identifier)
          (scope_statement
            (compound_statement)))))))

================================================================================
Range foreach numbers
================================================================================

void f() {
	foreach (int i; 0..5) {}
}
--------------------------------------------------------------------------------

(source_file
  (function_declaration
    (type)
    (identifier)
    (parameters)
    (function_body
      (compound_statement
        (foreach_statement
          (foreach_type
            (type
              (identifier))
            (identifier))
          (integer_literal)
          (integer_literal)
          (scope_statement
            (compound_statement)))))))

================================================================================
Foreach scope
================================================================================

void f() {
	foreach(scope string s, scope Node value; nmap2) {
	}
}
--------------------------------------------------------------------------------

(source_file
  (function_declaration
    (type)
    (identifier)
    (parameters)
    (function_body
      (compound_statement
        (foreach_statement
          (foreach_type
            (type
              (identifier))
            (identifier))
          (foreach_type
            (type
              (identifier))
            (identifier))
          (identifier)
          (scope_statement
            (compound_statement)))))))
