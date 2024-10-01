================================================================================
New builtin type
================================================================================
unittest {
    x = new int;
}
--------------------------------------------------------------------------------

(source_file
  (unittest_declaration
    (compound_statement
      (expression_statement
        (expression_list
          (assignment_expression
            (identifier)
            (new_expression
              (type
                (identifier)))))))))

================================================================================
New array
================================================================================
unittest {
  x = new char[400];
}
--------------------------------------------------------------------------------

(source_file
  (unittest_declaration
    (compound_statement
      (expression_statement
        (expression_list
          (assignment_expression
            (identifier)
            (new_expression
              (type
                (identifier)
                (integer_literal)))))))))

================================================================================
New anonymous class no args
================================================================================
unittest
{
    auto myIota = new class
    {
        int front = 0;
    };
}
--------------------------------------------------------------------------------

(source_file
  (unittest_declaration
    (compound_statement
      (auto_declaration
        (storage_class)
        (identifier)
        (new_expression
          (aggregate_body
            (variable_declaration
              (type
                (identifier))
              (declarator
                (identifier)
                (integer_literal)))))))))

================================================================================
New anonymous class args
================================================================================
unittest {
  x = new class(3) { this(primitive_type) { }};
}
--------------------------------------------------------------------------------

(source_file
  (unittest_declaration
    (compound_statement
      (expression_statement
        (expression_list
          (assignment_expression
            (identifier)
            (new_expression
              (arguments
                (integer_literal))
              (aggregate_body
                (constructor_declaration
                  (parameters
                    (parameter
                      (type
                        (identifier))))
                  (function_body
                    (compound_statement)))))))))))

================================================================================
Explicit instantiation
================================================================================
void main()
{
    auto c = new C;
    c.new N!(c.m);
}
--------------------------------------------------------------------------------

(source_file
  (function_declaration
    (type)
    (identifier)
    (parameters)
    (function_body
      (compound_statement
        (auto_declaration
          (storage_class)
          (identifier)
          (new_expression
            (type
              (identifier))))
        (expression_statement
          (expression_list
            (property_expression
              (identifier)
              (new_expression
                (type
                  (template_instance
                    (identifier)
                    (template_arguments
                      (template_argument
                        (type
                          (identifier)
                          (identifier))))))))))))))
