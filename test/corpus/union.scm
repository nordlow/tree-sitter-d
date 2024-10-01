==================
Empty union
==================

union s {}

---

(source_file
  (union_declaration
    (identifier)
    (aggregate_body)))

==================
Union field
==================

union s {
	int x;
}

---

(source_file
  (union_declaration
    (identifier)
    (aggregate_body
      (variable_declaration
        (type
          (identifier))
        (declarator
          (identifier))))))

==================
Union fields
==================

union s {
	int x;
	int y;
}

---

(source_file
  (union_declaration
    (identifier)
    (aggregate_body
      (variable_declaration
        (type
          (identifier))
        (declarator
          (identifier)))
      (variable_declaration
        (type
          (identifier))
        (declarator
          (identifier))))))

==================
Anonymous union
==================

union {
	int x;
}

---

(source_file
  (union_declaration
    (aggregate_body
      (variable_declaration
        (type
          (identifier))
        (declarator
          (identifier))))))

==================
Templated union
==================

union u (something) {
	int x;
}

---

(source_file
  (union_declaration
    (identifier)
    (template_parameters
      (template_parameter
        (identifier)))
    (aggregate_body
      (variable_declaration
        (type
          (identifier))
        (declarator
          (identifier))))))

==================
Templated union with template_constraint
==================

union u (something) if (!something) {
	int x;
}

---

(source_file
  (union_declaration
    (identifier)
    (template_parameters
      (template_parameter
        (identifier)))
    (template_constraint
      (unary_expression
        (identifier)))
    (aggregate_body
      (variable_declaration
        (type
          (identifier))
        (declarator
          (identifier))))))

==================
Named union initialization (DMD 2.108)
==================

union U {
    float asFloat;
    uint asInt;
}

auto u1 = U(asInt: 0x3F800000);
---

(source_file
  (union_declaration
    (identifier)
    (aggregate_body
      (variable_declaration
        (type
          (identifier))
        (declarator
          (identifier)))
      (variable_declaration
        (type
          (identifier))
        (declarator
          (identifier)))))
  (auto_declaration
    (storage_class)
    (identifier)
    (call_expression
      (identifier)
      (named_arguments
        (named_argument
          (identifier)
          (integer_literal))))))
