================================================================================
Extern C++
================================================================================
extern(C++) class Foo{}
--------------------------------------------------------------------------------

(source_file
  (class_declaration
    (linkage_attribute)
    (class)
    (identifier)
    (aggregate_body)))

================================================================================
Extern C++ empty namespaces
================================================================================
extern(C++,) class Foo{}
--------------------------------------------------------------------------------

(source_file
  (class_declaration
    (linkage_attribute)
    (class)
    (identifier)
    (aggregate_body)))

================================================================================
Extern C++ namespaces
================================================================================
extern(C++, class)
extern(C++, __traits(getCppNamespaces,C))
extern(C++, (ns))
class ScopeClass { }
--------------------------------------------------------------------------------

(source_file
  (class_declaration
    (linkage_attribute
      (class))
    (linkage_attribute
      (namespace_list
        (expression
          (traits_expression
            (traits)
            (identifier)
            (template_argument
              (identifier))))))
    (linkage_attribute
      (namespace_list
        (expression
          (primary_expression
            (expression_list
              (identifier))))))
    (class)
    (identifier)
    (aggregate_body)))
