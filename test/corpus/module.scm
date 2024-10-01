================================================================================
Module declaration
================================================================================
module test.blah.bah;
--------------------------------------------------------------------------------

(source_file
  (module_definition
    (module_declaration
      (module_fqn
        (identifier)
        (identifier)
        (identifier)))))

================================================================================
Module deprecated
================================================================================
deprecated module test.blah.bah;
--------------------------------------------------------------------------------

(source_file
  (module_definition
    (module_declaration
      (deprecated_attribute)
      (module_fqn
        (identifier)
        (identifier)
        (identifier)))))

================================================================================
Module deprecated reason
================================================================================
deprecated ("it is too old") module test.blah.bah;
--------------------------------------------------------------------------------

(source_file
  (module_definition
    (module_declaration
      (deprecated_attribute
        (quoted_string_literal))
      (module_fqn
        (identifier)
        (identifier)
        (identifier)))))

================================================================================
Module at-attribute
================================================================================
@uda module test.blah.bah;
--------------------------------------------------------------------------------

(source_file
  (module_definition
    (module_declaration
      (at_attribute
        (identifier))
      (module_fqn
        (identifier)
        (identifier)
        (identifier)))))

================================================================================
Module at-attribute parameter
================================================================================
@uda("something") module test.blah.bah;
--------------------------------------------------------------------------------

(source_file
  (module_definition
    (module_declaration
      (at_attribute
        (identifier)
        (arguments
          (quoted_string_literal)))
      (module_fqn
        (identifier)
        (identifier)
        (identifier)))))

================================================================================
Module multiple attributes
================================================================================
@UDA(1) @UDA(2) module imports.udamodule2;
--------------------------------------------------------------------------------

(source_file
  (module_definition
    (module_declaration
      (at_attribute
        (identifier)
        (arguments
          (integer_literal)))
      (at_attribute
        (identifier)
        (arguments
          (integer_literal)))
      (module_fqn
        (identifier)
        (identifier)))))
