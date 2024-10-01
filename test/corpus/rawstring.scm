================================================================================
Backquoted String
================================================================================

auto s4 = `abc def
`;
---

(source_file
  (auto_declaration
    (storage_class)
    (identifier)
    (raw_string_literal)))

================================================================================
Empty Backquoted String
================================================================================

auto s4 = ``;
---

(source_file
  (auto_declaration
    (storage_class)
    (identifier)
    (raw_string_literal)))

================================================================================
Backquoted String With Suffix
================================================================================

auto s4 = `abc def`c;
---

(source_file
  (auto_declaration
    (storage_class)
    (identifier)
    (raw_string_literal)))

================================================================================
Raw String
================================================================================

auto s5 = r"
this is some text
";
---

(source_file
  (auto_declaration
    (storage_class)
    (identifier)
    (raw_string_literal)))

================================================================================
Raw String Suffix w
================================================================================

auto s = r"something"w;
---

(source_file
  (auto_declaration
    (storage_class)
    (identifier)
    (raw_string_literal)))

================================================================================
Raw String Suffix Invalid (whitespace)
================================================================================

auto s = r"something" w;
---

(source_file
  (auto_declaration
    (storage_class)
    (identifier)
    (raw_string_literal)
    (ERROR
      (identifier))))
