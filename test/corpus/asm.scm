================================================================================
Inline assembler
================================================================================
int f() {
  asm{
        db 5,6,0x83;   // insert bytes 0x05, 0x06, and 0x83 into code
  }
}
--------------------------------------------------------------------------------

(source_file
  (function_declaration
    (type
      (identifier))
    (identifier)
    (parameters)
    (function_body
      (compound_statement
        (asm_statement
          (asm_inline
            (identifier)
            (integer_literal)
            (integer_literal)
            (integer_literal))
          (comment))))))

================================================================================
Inline assember - empty
================================================================================
int f() {
  asm{}
}
--------------------------------------------------------------------------------

(source_file
  (function_declaration
    (type
      (identifier))
    (identifier)
    (parameters)
    (function_body
      (compound_statement
        (asm_statement)))))

================================================================================
Inline assember with attributes
================================================================================
int f() {
  asm pure @uda {
    mov EAX,x;
  }
}
--------------------------------------------------------------------------------

(source_file
  (function_declaration
    (type
      (identifier))
    (identifier)
    (parameters)
    (function_body
      (compound_statement
        (asm_statement
          (at_attribute
            (identifier))
          (asm_inline
            (identifier)
            (identifier)
            (identifier)))))))

================================================================================
Inline assembler braces
================================================================================
int f() {
  asm {
    ds "right brace}"; // the } is ignored
  }
}
--------------------------------------------------------------------------------

(source_file
  (function_declaration
    (type
      (identifier))
    (identifier)
    (parameters)
    (function_body
      (compound_statement
        (asm_statement
          (asm_inline
            (identifier)
            (quoted_string_literal))
          (comment))))))
