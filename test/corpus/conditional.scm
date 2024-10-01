================================================================================
Nested conditional declaration
================================================================================
unittest
{
    static if (x == 0)
        enum y = 1;
    else static if (x == 1)
        static if (z == 0)
            char z = 'a';
        else
            char z = 0;
    else static if (x == 2)
        int y = 5;
    else static if (x == 3)
        enum y = 6;
    else
        enum y = 7;
}
--------------------------------------------------------------------------------

(source_file
  (unittest_declaration
    (compound_statement
      (conditional_declaration
        (static_if_condition
          (equal_binary_expression
            (identifier)
            (integer_literal)))
        (manifest_constant
          (manifest_declarator
            (identifier)
            (integer_literal)))
        (conditional_declaration
          (static_if_condition
            (equal_binary_expression
              (identifier)
              (integer_literal)))
          (conditional_declaration
            (static_if_condition
              (equal_binary_expression
                (identifier)
                (integer_literal)))
            (variable_declaration
              (type
                (identifier))
              (declarator
                (identifier)
                (character_literal)))
            (variable_declaration
              (type
                (identifier))
              (declarator
                (identifier)
                (integer_literal))))
          (conditional_declaration
            (static_if_condition
              (equal_binary_expression
                (identifier)
                (integer_literal)))
            (variable_declaration
              (type
                (identifier))
              (declarator
                (identifier)
                (integer_literal)))
            (conditional_declaration
              (static_if_condition
                (equal_binary_expression
                  (identifier)
                  (integer_literal)))
              (manifest_constant
                (manifest_declarator
                  (identifier)
                  (integer_literal)))
              (manifest_constant
                (manifest_declarator
                  (identifier)
                  (integer_literal))))))))))
