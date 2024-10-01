================================================================================
Extern C++
================================================================================
extern(C++) class Foo{}
--------------------------------------------------------------------------------

(source_file
  (class_declaration
    (linkage_attribute)
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
    (linkage_attribute)
    (linkage_attribute
      (namespace_list
        (traits_expression
          (identifier)
          (template_argument
            (identifier)))))
    (linkage_attribute
      (namespace_list
        (primary_expression
          (expression_list
            (identifier)))))
    (identifier)
    (aggregate_body)))
