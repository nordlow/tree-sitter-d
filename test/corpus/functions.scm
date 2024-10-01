================================================================================
Basic Function
================================================================================

int f() { return 0; }
--------------------------------------------------------------------------------

(source_file
  (function_declaration
    (type
      (identifier))
    (identifier)
    (parameters)
    (function_body
      (block_statement
        (return_statement
          (expression
            (integer_literal)))))))

================================================================================
Single Parameter Function
================================================================================

int f(int c) { return c; }
--------------------------------------------------------------------------------

(source_file
  (function_declaration
    (type
      (identifier))
    (identifier)
    (parameters
      (parameter
        (type
          (identifier))
        (identifier)))
    (function_body
      (block_statement
        (return_statement
          (expression
            (identifier)))))))

================================================================================
Var Args Parameter Function
================================================================================

int f(int c, ...) { return c; }
--------------------------------------------------------------------------------

(source_file
  (function_declaration
    (type
      (identifier))
    (identifier)
    (parameters
      (parameter
        (type
          (identifier))
        (identifier))
      (ellipses))
    (function_body
      (block_statement
        (return_statement
          (expression
            (identifier)))))))

================================================================================
Var Args Only Function
================================================================================

int f(...) { return c; }
--------------------------------------------------------------------------------

(source_file
  (function_declaration
    (type
      (identifier))
    (identifier)
    (parameters
      (ellipses))
    (function_body
      (block_statement
        (return_statement
          (expression
            (identifier)))))))

================================================================================
Var Args Type-Safe Function
================================================================================

int f(int...) { return c; }
--------------------------------------------------------------------------------

(source_file
  (function_declaration
    (type
      (identifier))
    (identifier)
    (parameters
      (parameter
        (type
          (primitive_type))
        (ellipses)))
    (function_body
      (block_statement
        (return_statement
          (return)
          (expression
            (identifier)))))))

================================================================================
Member Function Attributes
================================================================================

int f(int a, int b) @safe pure @myattr { return a+b; }
--------------------------------------------------------------------------------

(source_file
  (function_declaration
    (type
      (identifier))
    (identifier)
    (parameters
      (parameter
        (type
          (identifier))
        (identifier))
      (parameter
        (type
          (identifier))
        (identifier)))
    (member_function_attribute
      (at_attribute
        (identifier)))
    (member_function_attribute
      (pure))
    (member_function_attribute
      (at_attribute
        (identifier)))
    (function_body
      (block_statement
        (return_statement
          (expression
            (add_binary_expression
              (identifier)
              (identifier))))))))

================================================================================
Function literal no parameters
================================================================================

unittest {
	f({return 1;});
}

--------------------------------------------------------------------------------

(source_file
  (unittest_declaration
    (unittest)
    (block_statement
      (expression_statement
        (expression_list
          (call_expression
            (identifier)
            (named_arguments
              (named_argument
                (expression
                  (function_literal
                    (block_statement
                      (return_statement
                        (expression
                          (integer_literal))))))))))))))

================================================================================
Function literal anonymous parameter
================================================================================

unittest {
	f((primitive_type){return 1;});
}

--------------------------------------------------------------------------------

(source_file
  (unittest_declaration
    (unittest)
    (block_statement
      (expression_statement
        (expression_list
          (call_expression
            (identifier)
            (named_arguments
              (named_argument
                (expression
                  (function_literal
                    (type
                      (identifier))
                    (block_statement
                      (return_statement
                        (expression
                          (integer_literal))))))))))))))

================================================================================
Function literal named parameter
================================================================================

unittest {
	f((bool b){return 1;});
}

--------------------------------------------------------------------------------

(source_file
  (unittest_declaration
    (unittest)
    (block_statement
      (expression_statement
        (expression_list
          (call_expression
            (identifier)
            (named_arguments
              (named_argument
                (expression
                  (function_literal
                    (type
                      (identifier))
                    (identifier)
                    (block_statement
                      (return_statement
                        (expression
                          (integer_literal))))))))))))))

================================================================================
Function literal auto ref
================================================================================
auto a = auto ref (int x) => x;
auto b = auto ref (int x) { return x; };
auto c = function auto ref (int x) { return x; };
auto d = delegate auto ref (int x) { return x; };

__EOF__
alias e = auto ref (int x) => x;
alias f = auto ref (int x) { return x; };
alias g = function auto ref (int x) { return x; };
alias h = delegate auto ref (int x) { return x; };
--------------------------------------------------------------------------------

(source_file
  (auto_declaration
    (storage_class
      (auto))
    (identifier)
    (function_literal
      (auto)
      (ref)
      (type
        (identifier))
      (identifier)
      (identifier)))
  (auto_declaration
    (storage_class
      (auto))
    (identifier)
    (function_literal
      (auto)
      (ref)
      (type
        (identifier))
      (identifier)
      (block_statement
        (return_statement
          (expression
            (identifier))))))
  (auto_declaration
    (storage_class
      (auto))
    (identifier)
    (function_literal
      (function)
      (auto)
      (ref)
      (parameters
        (parameter
          (type
            (identifier))
          (identifier)))
      (block_statement
        (return_statement
          (expression
            (identifier))))))
  (auto_declaration
    (storage_class
      (auto))
    (identifier)
    (function_literal
      (delegate)
      (auto)
      (ref)
      (type
        (identifier))
      (identifier)
      (block_statement
        (return_statement
          (expression
            (identifier))))))
  (end_file))

================================================================================
Auto functions
================================================================================
    auto foo1() pure immutable { return 0; }
    auto foo2() pure const { return 0; }
--------------------------------------------------------------------------------

(source_file
  (function_declaration
    (storage_class
      (auto))
    (identifier)
    (parameters)
    (member_function_attribute
      (pure))
    (member_function_attribute)
    (function_body
      (block_statement
        (return_statement
          (expression
            (integer_literal))))))
  (function_declaration
    (storage_class
      (auto))
    (identifier)
    (parameters)
    (member_function_attribute
      (pure))
    (member_function_attribute)
    (function_body
      (block_statement
        (return_statement
          (expression
            (integer_literal)))))))

================================================================================
Qualified lambda functions
================================================================================
    auto lambda1 = () pure immutable { return 0; };
    auto lambda2 = () pure const { return 0; };
--------------------------------------------------------------------------------

(source_file
  (auto_declaration
    (storage_class
      (auto))
    (identifier)
    (function_literal
      (member_function_attribute
        (pure))
      (member_function_attribute)
      (block_statement
        (return_statement
          (expression
            (integer_literal))))))
  (auto_declaration
    (storage_class
      (auto))
    (identifier)
    (function_literal
      (member_function_attribute
        (pure))
      (member_function_attribute)
      (block_statement
        (return_statement
          (expression
            (integer_literal)))))))

================================================================================
Qualifeid delegates
================================================================================
    auto dg1 = delegate () pure immutable { return 0; };
    auto dg2 = delegate () pure const { return 0; };
--------------------------------------------------------------------------------

(source_file
  (auto_declaration
    (storage_class
      (auto))
    (identifier)
    (function_literal
      (delegate)
      (member_function_attribute
        (pure))
      (member_function_attribute)
      (block_statement
        (return_statement
          (expression
            (integer_literal))))))
  (auto_declaration
    (storage_class
      (auto))
    (identifier)
    (function_literal
      (delegate)
      (member_function_attribute
        (pure))
      (member_function_attribute)
      (block_statement
        (return_statement
          (expression
            (integer_literal)))))))

================================================================================
Function Contract Statement
================================================================================
interface Stack {
    int pop()
    out(result) {
    }
}
--------------------------------------------------------------------------------

(source_file
  (interface_declaration
    (interface)
    (identifier)
    (aggregate_body
      (function_declaration
        (type
          (identifier))
        (identifier)
        (parameters)
        (function_body
          (out_statement
            (out)
            (identifier)
            (block_statement)))))))

================================================================================
Variadic argument defaults
================================================================================
int f(int x = 1...) {}
int g(float = 1.3 ...) {}
--------------------------------------------------------------------------------

(source_file
  (function_declaration
    (type
      (identifier))
    (identifier)
    (parameters
      (parameter
        (type
          (identifier))
        (identifier)
        (integer_literal)
        (ellipses)))
    (function_body
      (block_statement)))
  (function_declaration
    (type
      (identifier))
    (identifier)
    (parameters
      (parameter
        (type
          (primitive_type))
        (float_literal)
        (ellipses)))
    (function_body
      (block_statement))))

================================================================================
Auto ref function
================================================================================
void test()
{
    auto ref baz3() { return 1; }
}
--------------------------------------------------------------------------------

(source_file
  (function_declaration
    (type
      (void))
    (identifier)
    (parameters)
    (function_body
      (block_statement
        (function_declaration
          (storage_class
            (auto))
          (storage_class
            (ref))
          (identifier)
          (parameters)
          (function_body
            (block_statement
              (return_statement
                (expression
                  (integer_literal))))))))))

================================================================================
Shortened function body
================================================================================
int f(int x) => x * 2;
--------------------------------------------------------------------------------

(source_file
  (function_declaration
    (type
      (identifier))
    (identifier)
    (parameters
      (parameter
        (type
          (identifier))
        (identifier)))
    (function_body
      (mul_binary_expression
        (identifier)
        (integer_literal)))))

================================================================================
Shorted function body with contract
================================================================================
float recip(float x)in(x != 0) => 1/x;
--------------------------------------------------------------------------------

(source_file
  (function_declaration
    (type
      (identifier))
    (identifier)
    (parameters
      (parameter
        (type
          (identifier))
        (identifier)))
    (function_body
      (in_contract_expression
        (in)
        (assert_arguments
          (expression
            (equal_binary_expression
              (identifier)
              (integer_literal)))))
      (mul_binary_expression
        (integer_literal)
        (identifier)))))

================================================================================
Enum is not a return type (DMD 2.105)
================================================================================
enum x() {}
--------------------------------------------------------------------------------

(source_file
  (ERROR
    (enum)
    (identifier)
    (template_parameters)))

================================================================================
Function call named parameters
================================================================================

unittest {
	f(dryrun: false);
}
--------------------------------------------------------------------------------

(source_file
  (unittest_declaration
    (unittest)
    (block_statement
      (expression_statement
        (expression_list
          (call_expression
            (identifier)
            (named_arguments
              (named_argument
                (identifier)
                (expression)))))))))

================================================================================
Function call multiple named parameters
================================================================================

unittest {
	f(dryrun: false, second: 123);
}
--------------------------------------------------------------------------------

(source_file
  (unittest_declaration
    (unittest)
    (block_statement
      (expression_statement
        (expression_list
          (call_expression
            (identifier)
            (named_arguments
              (named_argument
                (identifier)
                (expression))
              (named_argument
                (identifier)
                (expression
                  (integer_literal))))))))))

================================================================================
Function call multiple named and unnamed parameters
================================================================================

unittest {
	f(dryrun: false, "alpha", second: 123, 'L');
}
--------------------------------------------------------------------------------

(source_file
  (unittest_declaration
    (unittest)
    (block_statement
      (expression_statement
        (expression_list
          (call_expression
            (identifier)
            (named_arguments
              (named_argument
                (identifier)
                (expression))
              (named_argument
                (expression
                  (quoted_string_literal)))
              (named_argument
                (identifier)
                (expression
                  (integer_literal)))
              (named_argument
                (expression
                  (character_literal))))))))))

================================================================================
Function declaration attributes
================================================================================

void foo() pure @property;
--------------------------------------------------------------------------------

(source_file
  (function_declaration
    (type
      (void))
    (identifier)
    (parameters)
    (member_function_attribute
      (pure))
    (member_function_attribute
      (at_attribute
        (identifier)))
    (function_body)))
