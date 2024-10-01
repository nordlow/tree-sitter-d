================================================================================
Alias simple initializer
================================================================================

alias n1 = int;
--------------------------------------------------------------------------------

(source_file
  (alias_declaration
    (alias_initializer
      (identifier)
      (type
        (identifier)))))

================================================================================
Alias initializer with storage class
================================================================================

alias n1 = extern int;
--------------------------------------------------------------------------------

(source_file
  (alias_declaration
    (alias_initializer
      (identifier)
      (storage_class)
      (type
        (identifier)))))

================================================================================
Alias initializer with array type
================================================================================

alias n1 = extern int[6];
--------------------------------------------------------------------------------

(source_file
  (alias_declaration
    (alias_initializer
      (identifier)
      (storage_class)
      (type
        (identifier)
        (integer_literal)))))

================================================================================
Alias initializer with function type
================================================================================

alias n1 = int(primitive_type);
--------------------------------------------------------------------------------

(source_file
  (alias_declaration
    (alias_initializer
      (identifier)
      (type
        (identifier))
      (parameters
        (parameter
          (type
            (identifier)))))))

================================================================================
Alias initializer with function attrs
================================================================================

alias n1 = int(primitive_type) pure;
--------------------------------------------------------------------------------

(source_file
  (alias_declaration
    (alias_initializer
      (identifier)
      (type
        (identifier))
      (parameters
        (parameter
          (type
            (identifier))))
      (member_function_attribute))))

================================================================================
Alias initializer with template type
================================================================================

alias n1 = f!(primitive_type);
--------------------------------------------------------------------------------

(source_file
  (alias_declaration
    (alias_initializer
      (identifier)
      (type
        (template_instance
          (identifier)
          (template_arguments
            (template_argument
              (identifier))))))))

================================================================================
Alias initializer with template function type
================================================================================

alias n1 = f!(primitive_type)(primitive_type);
--------------------------------------------------------------------------------

(source_file
  (alias_declaration
    (alias_initializer
      (identifier)
      (type
        (template_instance
          (identifier)
          (template_arguments
            (template_argument
              (identifier)))))
      (parameters
        (parameter
          (type
            (identifier)))))))

================================================================================
Alias function literal
================================================================================

alias n1 = f => f++;
--------------------------------------------------------------------------------

(source_file
  (alias_declaration
    (alias_initializer
      (identifier)
      (function_literal
        (identifier)
        (postfix_expression
          (identifier))))))

================================================================================
Alias multiple initializers
================================================================================

alias n1 = int,  n2 = char;
--------------------------------------------------------------------------------

(source_file
  (alias_declaration
    (alias_initializer
      (identifier)
      (type
        (identifier)))
    (alias_initializer
      (identifier)
      (type
        (identifier)))))

================================================================================
Alias short
================================================================================

alias int n1;
--------------------------------------------------------------------------------

(source_file
  (alias_declaration
    (type
      (identifier))
    (identifier)))

================================================================================
Alias short function type
================================================================================

alias int n1(primitive_type);
--------------------------------------------------------------------------------

(source_file
  (alias_declaration
    (type
      (identifier))
    (identifier)
    (parameters
      (parameter
        (type
          (identifier))))))

================================================================================
Alias short rename
================================================================================

alias t_old t_new;
--------------------------------------------------------------------------------

(source_file
  (alias_declaration
    (type
      (identifier))
    (identifier)))

================================================================================
Alias symbol
================================================================================

alias id = other.name;
--------------------------------------------------------------------------------

(source_file
  (alias_declaration
    (alias_initializer
      (identifier)
      (type
        (identifier)
        (identifier)))))

================================================================================
Alias this
================================================================================

alias id this;
--------------------------------------------------------------------------------

(source_file
  (alias_this_declaration
    (identifier)))

================================================================================
Alias template function
================================================================================

alias void m(int tp)(char c);

--------------------------------------------------------------------------------

(source_file
  (alias_declaration
    (type)
    (identifier)
    (template_parameters
      (template_parameter
        (type
          (identifier))
        (identifier)))
    (parameters
      (parameter
        (type
          (identifier))
        (identifier)))))

================================================================================
Alias reassignment
================================================================================

template  t(alias F, Args...)
{
   alias A = AliasSeq!();
    static foreach (Arg; Args)
        A = AliasSeq!(A, F!Arg);
}

--------------------------------------------------------------------------------

(source_file
  (template_declaration
    (identifier)
    (template_parameters
      (template_parameter
        (identifier))
      (template_parameter
        (identifier)))
    (alias_declaration
      (alias_initializer
        (identifier)
        (type
          (template_instance
            (identifier)
            (template_arguments)))))
    (static_foreach_declaration
      (foreach_type
        (identifier))
      (identifier)
      (alias_reassign
        (identifier)
        (type
          (template_instance
            (identifier)
            (template_arguments
              (template_argument
                (identifier))
              (template_argument
                (template_instance
                  (identifier)
                  (template_arguments
                    (identifier)))))))))))

================================================================================
Alias with align parameter
================================================================================
alias g_t = align(8) _gg_t[NREG];
--------------------------------------------------------------------------------

(source_file
  (alias_declaration
    (alias_initializer
      (identifier)
      (storage_class
        (align_attribute
          (integer_literal)))
      (type
        (identifier)
        (identifier)))))

================================================================================
Alias this
================================================================================
struct S { int n; alias this = n; }
--------------------------------------------------------------------------------

(source_file
  (struct_declaration
    (identifier)
    (aggregate_body
      (variable_declaration
        (type
          (identifier))
        (declarator
          (identifier)))
      (alias_this_declaration
        (identifier)))))
