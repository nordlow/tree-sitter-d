==================
Typeof expression
==================

auto t = typeof(0);

---

(source_file
  (auto_declaration
    (storage_class)
    (identifier)
    (typeof_expression
      (integer_literal))))

==================
Typeof expression (return)
==================

auto t = typeof (return);

---

(source_file
  (auto_declaration
    (storage_class)
    (identifier)
    (typeof_expression)))
