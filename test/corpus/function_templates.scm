================================================================================
Basic Function
================================================================================

T square(T)(in T x) { return x + x; }
--------------------------------------------------------------------------------

(source_file
  (function_declaration
    (type
      (identifier))
    (identifier)
    (template_parameters
      (template_parameter
        (identifier)))
    (parameters
      (parameter
        (parameter_attribute)
        (type
          (identifier))
        (identifier)))
    (function_body
      (compound_statement
        (return_statement
          (add_binary_expression
            (identifier)
            (identifier)))))))
