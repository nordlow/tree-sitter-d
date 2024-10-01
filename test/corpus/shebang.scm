==================
Shebang
==================
#!/bin/sh

---

(source_file
  (shebang))

===================
Shebang + Directive
===================
#!/bin/sh

# something
# line 3
---

(source_file
  (shebang)
  (directive)
  (directive))

===
Directive only at start of line
===

auto f() {
    DEBUG!"#SECPOLICY security policy %d created (name %s)"(row.k, name);
}
---

(source_file
  (function_declaration
    (storage_class)
    (identifier)
    (parameters)
    (function_body
      (compound_statement
        (expression_statement
          (expression_list
            (call_expression
              (type
                (template_instance
                  (identifier)
                  (template_arguments
                    (quoted_string_literal))))
              (named_arguments
                (named_argument
                  (property_expression
                    (identifier)
                    (identifier)))
                (named_argument
                  (identifier))))))))))
