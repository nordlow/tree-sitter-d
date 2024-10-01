================================================================================
If expression
================================================================================

unittest {
    if (true) { doit; }
}
--------------------------------------------------------------------------------

(source_file
  (unittest_declaration
    (compound_statement
      (if_statement
        (if_condition)
        (scope_statement
          (compound_statement
            (expression_statement
              (expression_list
                (identifier)))))))))

================================================================================
If-Else expression
================================================================================

unittest {
    if (true) { doit; } else { something; }
}
--------------------------------------------------------------------------------

(source_file
  (unittest_declaration
    (compound_statement
      (if_statement
        (if_condition)
        (scope_statement
          (compound_statement
            (expression_statement
              (expression_list
                (identifier)))))
        (scope_statement
          (compound_statement
            (expression_statement
              (expression_list
                (identifier)))))))))

================================================================================
If declaration as conditional
================================================================================

unittest {
    if (auto x = testit) { }
}
--------------------------------------------------------------------------------

(source_file
  (unittest_declaration
    (compound_statement
      (if_statement
        (if_condition
          (identifier)
          (identifier))
        (scope_statement
          (compound_statement))))))
