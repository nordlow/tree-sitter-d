================================================================================
Interpolated Raw Strings
================================================================================
auto s1 = i`Hello, $(name)`;
--------------------------------------------------------------------------------

(source_file
  (auto_declaration
    (storage_class)
    (identifier)
    (interpolated_raw_string_literal
      (interpolation_expression
        (identifier)))))

================================================================================
Interpolated Raw Strings Tail $
================================================================================
auto s1 = i`Hello, $(name)$`;
--------------------------------------------------------------------------------

(source_file
  (auto_declaration
    (storage_class)
    (identifier)
    (interpolated_raw_string_literal
      (interpolation_expression
        (identifier)))))

================================================================================
Interpolated Quoted String
================================================================================
auto s1 = i"Hello, $(salutation ~ name)";
--------------------------------------------------------------------------------

(source_file
  (auto_declaration
    (storage_class)
    (identifier)
    (interpolated_quoted_string_literal
      (interpolation_expression
        (add_binary_expression
          (identifier)
          (identifier))))))

================================================================================
Interpolated Token String
================================================================================
auto s1 = iq{"Good "~$(timeofday), salutation ~ name};
--------------------------------------------------------------------------------

(source_file
  (auto_declaration
    (storage_class)
    (identifier)
    (interpolated_token_string_literal
      (quoted_string_literal)
      (interpolation_expression
        (identifier))
      (identifier)
      (identifier))))

================================================================================
Interpolated Quoted String With Escape
================================================================================
auto s1 = i"Good $(timeofday), \$ $(salutation ~ name)";
--------------------------------------------------------------------------------

(source_file
  (auto_declaration
    (storage_class)
    (identifier)
    (interpolated_quoted_string_literal
      (interpolation_expression
        (identifier))
      (interpolated_escape)
      (interpolation_expression
        (add_binary_expression
          (identifier)
          (identifier))))))
