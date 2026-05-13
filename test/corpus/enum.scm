================================================================================
Untyped enum
================================================================================

enum X { x }

--------------------------------------------------------------------------------

(source_file
  (enum_declaration
    (type_identifier)
    (enum_member_declaration
      (constant_identifier))))

================================================================================
Typed enum
================================================================================

enum X : int { x }

--------------------------------------------------------------------------------

(source_file
  (enum_declaration
    (type_identifier)
    (type
      (identifier))
    (enum_member_declaration
      (constant_identifier))))

================================================================================
Enum with initialized values
================================================================================

enum X { x = 1, y = 2 }

--------------------------------------------------------------------------------

(source_file
  (enum_declaration
    (type_identifier)
    (enum_member_declaration
      (constant_identifier)
      (integer_literal))
    (enum_member_declaration
      (constant_identifier)
      (integer_literal))))

================================================================================
Enum with missing body
================================================================================

enum X;

--------------------------------------------------------------------------------

(source_file
  (enum_declaration
    (type_identifier)))

================================================================================
Enum trailing comma
================================================================================

enum X { x, }

--------------------------------------------------------------------------------

(source_file
  (enum_declaration
    (type_identifier)
    (enum_member_declaration
      (constant_identifier))))

================================================================================
Typed enum with missing body
================================================================================

enum X : Y;

--------------------------------------------------------------------------------

(source_file
  (enum_declaration
    (type_identifier)
    (type
      (identifier))))

================================================================================
Anonymous enum
================================================================================

enum { x }
--------------------------------------------------------------------------------

(source_file
  (anonymous_enum_declaration
    (enum_member_declaration
      (constant_identifier))))

================================================================================
Anonymous trailing comma
================================================================================

enum { x, }
--------------------------------------------------------------------------------

(source_file
  (anonymous_enum_declaration
    (enum_member_declaration
      (constant_identifier))))

================================================================================
Anonymous enum values
================================================================================

enum { x = 1 }
--------------------------------------------------------------------------------

(source_file
  (anonymous_enum_declaration
    (enum_member_declaration
      (constant_identifier)
      (integer_literal))))

================================================================================
Anonymous enum typed values
================================================================================

enum { int x = 1 }
--------------------------------------------------------------------------------

(source_file
  (anonymous_enum_declaration
    (anonymous_enum_member
      (type
        (identifier))
      (constant_identifier)
      (integer_literal))))

================================================================================
Anonymous enum mixed
================================================================================

enum {
	int x = 1,
	d,
	e = 1,
}

--------------------------------------------------------------------------------

(source_file
  (anonymous_enum_declaration
    (anonymous_enum_member
      (type
        (identifier))
      (constant_identifier)
      (integer_literal))
    (enum_member_declaration
      (constant_identifier))
    (enum_member_declaration
      (constant_identifier)
      (integer_literal))))

================================================================================
Anonymous enum with UDAs
================================================================================
@("uda0")
enum
{
    value0,
    @("uda1") value1,
    @("uda2") @("uda3") value2,
    @uda4 value3,
    @uda5 @uda6 value4,
    @("uda7") @uda8 value5,
    @uda9 @("uda10") value6
}
--------------------------------------------------------------------------------

(source_file
  (anonymous_enum_declaration
    (at_attribute
      (quoted_string_literal))
    (enum_member_declaration
      (constant_identifier))
    (enum_member_declaration
      (at_attribute
        (quoted_string_literal))
      (constant_identifier))
    (enum_member_declaration
      (at_attribute
        (quoted_string_literal))
      (at_attribute
        (quoted_string_literal))
      (constant_identifier))
    (enum_member_declaration
      (at_attribute
        (identifier))
      (constant_identifier))
    (enum_member_declaration
      (at_attribute
        (identifier))
      (at_attribute
        (identifier))
      (constant_identifier))
    (enum_member_declaration
      (at_attribute
        (quoted_string_literal))
      (at_attribute
        (identifier))
      (constant_identifier))
    (enum_member_declaration
      (at_attribute
        (identifier))
      (at_attribute
        (quoted_string_literal))
      (constant_identifier))))
