==================
Typeid expression
==================

auto t = typeid (0);

---

(source_file
  (auto_declaration
    (storage_class)
    (identifier)
    (typeid_expression
      (integer_literal))))

==================
Typeid expression (type)
==================

auto t = typeid (shared(myType));

---

(source_file
  (auto_declaration
    (storage_class)
    (identifier)
    (typeid_expression
      (type
        (type_qualifier)
        (type
          (identifier))))))
