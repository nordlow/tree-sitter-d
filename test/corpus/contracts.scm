================================================================================
Function contracts
================================================================================
class C
{
    int foo() out{} in{} out(r){} in(true) out(; true) out(r; true)
    {
        return 2;
    }
}
--------------------------------------------------------------------------------

(source_file
  (class_declaration
    (identifier)
    (aggregate_body
      (function_declaration
        (type
          (identifier))
        (identifier)
        (parameters)
        (function_body
          (out_statement
            (compound_statement))
          (in_statement
            (compound_statement))
          (out_statement
            (identifier)
            (compound_statement))
          (in_contract_expression
            (assert_arguments))
          (out_contract_expression
            (assert_arguments))
          (out_contract_expression
            (identifier)
            (assert_arguments))
          (compound_statement
            (return_statement
              (integer_literal))))))))
