================================================================================
Class with template, constaint, then base class
================================================================================
class C(T)
if (isTrue(T))
: Base
{
}
--------------------------------------------------------------------------------

(source_file
  (class_declaration
    (identifier)
    (template_parameters
      (template_parameter
        (identifier)))
    (template_constraint
      (call_expression
        (identifier)
        (named_arguments
          (named_argument
            (identifier)))))
    (base_class
      (identifier))
    (aggregate_body)))

================================================================================
Base class can start with dot
================================================================================
class X : Y, .Z {
}
--------------------------------------------------------------------------------

(source_file
  (class_declaration
    (identifier)
    (base_class
      (identifier))
    (base_class
      (identifier))
    (aggregate_body)))

================================================================================
Base class primitive types
================================================================================
class U : int, float , __vector(int[3]) {}
--------------------------------------------------------------------------------

(source_file
  (class_declaration
    (identifier)
    (base_class
      (identifier))
    (base_class
      (identifier))
    (base_class
      (vector_type
        (type
          (identifier)
          (integer_literal))))
    (aggregate_body)))

================================================================================
Base class extended types
================================================================================

class T : typeof(new A), .B, const(C), D!int {}
--------------------------------------------------------------------------------

(source_file
  (class_declaration
    (identifier)
    (base_class
      (typeof_expression
        (new_expression
          (type
            (identifier)))))
    (base_class
      (identifier))
    (base_class
      (type_qualifier)
      (type
        (identifier)))
    (base_class
      (template_instance
        (identifier)
        (template_arguments
          (identifier))))
    (aggregate_body)))

================================================================================
Template class, no body
================================================================================
class Test(T = MyT);
--------------------------------------------------------------------------------

(source_file
  (class_declaration
    (identifier)
    (template_parameters
      (template_parameter
        (identifier)
        (type
          (identifier))))))
