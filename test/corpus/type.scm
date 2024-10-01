================================================================================
Simple type
================================================================================
int x;
--------------------------------------------------------------------------------

(source_file
  (variable_declaration
    (type
      (identifier))
    (declarator
      (identifier))))

================================================================================
User type
================================================================================
myType x;
--------------------------------------------------------------------------------

(source_file
  (variable_declaration
    (type
      (identifier))
    (declarator
      (identifier))))

================================================================================
User qualified type
================================================================================
myType.subType x;
--------------------------------------------------------------------------------

(source_file
  (variable_declaration
    (type
      (identifier)
      (identifier))
    (declarator
      (identifier))))

================================================================================
Simple type in block
================================================================================
unittest {
	int x;
}
--------------------------------------------------------------------------------

(source_file
  (unittest_declaration
    (compound_statement
      (variable_declaration
        (type
          (identifier))
        (declarator
          (identifier))))))

================================================================================
User type in block
================================================================================
unittest {
	myType x;
}
--------------------------------------------------------------------------------

(source_file
  (unittest_declaration
    (compound_statement
      (variable_declaration
        (type
          (identifier))
        (declarator
          (identifier))))))

================================================================================
User qualified type in block
================================================================================
unittest {
myType.subType x;
}
--------------------------------------------------------------------------------

(source_file
  (unittest_declaration
    (compound_statement
      (variable_declaration
        (type
          (identifier)
          (identifier))
        (declarator
          (identifier))))))

================================================================================
Nested user types
================================================================================

x.y z;
--------------------------------------------------------------------------------

(source_file
  (variable_declaration
    (type
      (identifier)
      (identifier))
    (declarator
      (identifier))))

================================================================================
Primitive array type
================================================================================
int[3] z;
--------------------------------------------------------------------------------

(source_file
  (variable_declaration
    (type
      (identifier)
      (integer_literal))
    (declarator
      (identifier))))

================================================================================
Dynamic array of primitives
================================================================================
int[] z;
--------------------------------------------------------------------------------

(source_file
  (variable_declaration
    (type
      (identifier))
    (declarator
      (identifier))))

================================================================================
Dynamic array of user types
================================================================================
ZZZ[] z;
--------------------------------------------------------------------------------

(source_file
  (variable_declaration
    (type
      (identifier))
    (declarator
      (identifier))))

================================================================================
Dynamic array of nested types
================================================================================
Z.Z[] z;
--------------------------------------------------------------------------------

(source_file
  (variable_declaration
    (type
      (identifier)
      (identifier))
    (declarator
      (identifier))))

================================================================================
Dynamic array of fixed arrays types
================================================================================
Z[4].Z[] z;
--------------------------------------------------------------------------------

(source_file
  (variable_declaration
    (type
      (identifier)
      (integer_literal)
      (identifier))
    (declarator
      (identifier))))

================================================================================
Vector type primary expr
================================================================================
void f()
{
        enum E2 : __vector(float[2]) { a = __vector(float[2]).init, }
}
--------------------------------------------------------------------------------

(source_file
  (function_declaration
    (type)
    (identifier)
    (parameters)
    (function_body
      (compound_statement
        (enum_declaration
          (identifier)
          (type
            (vector_type
              (type
                (identifier)
                (integer_literal))))
          (enum_member
            (identifier)
            (primary_expression
              (vector_type
                (type
                  (identifier)
                  (integer_literal)))
              (identifier))))))))
