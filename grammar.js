/*
 * Grammar for D code for use by Tree-Sitter.
 *
 * Copyright 2024 Garrett D'Amore
 *
 * Distributed under the MIT License.
 * (See accompanying file LICENSE.txt or https://opensource.org/licenses/MIT)
 * SPDX-License-Identifier: MIT
 */

module.exports = grammar({
  name: "d",

  // must match members in `TokenType` in `src/scanner.c`
  externals: $ => [
    $.directive,
    $.integer_literal,
    $.float_literal,
    $.regular_string_literal,
    $.not_in,
    $.not_is,
    $._after_eof,
    $.error_sentinel,
  ],

  extras: $ => [/[ \t\r\n\u2028\u2029]/, $.comment, $.directive],

  inline: $ => [
    $._identifier_or_template_instance,
    $._for1,
    $._for2,
    $._for3,
    $._template_value_parameter,
    $._template_alias_parameter,
    $._template_sequence_parameter,
    $._template_type_parameter,
    $._declarator_identifier_list,
    $._non_void_initializer,
    $._parameter,
    $.body,
    $.consequence,
    $.alternative,
  ],

  precedences: _$ => [
    // in expressions, we want to have the following
    [
      "unary",
      "power",
      "multiply",
      "add",
      "shift",
      "compare",
      "bitwise_and",
      "exclusive_or",
      "inclusive_or",
      "logical_or",
      "logical_and",
      "ternary",
      "assignment",
    ],
  ],

  word: $ => $.identifier,

  // The order of these rules very roughly corresponds to the order
  // they are defined in the D grammar on the D website.

  rules: {
    /**
     *
     * 3.1 LEXER
     *
     * See also the scanner.c, for some external symbols.
     */

    source_file: $ =>
      seq(
        optional(choice($._bom, $.shebang)),
        choice($.module_definition, repeat($._declaration)),
        optional(seq($.end_file, $._after_eof)),
      ),

    _bom: _$ => token.immediate("\uFEFF"), // kind of like a special form of whitespace
    shebang: $ => token.immediate(/#![^\n]*\n/),

    escape_sequence: $ =>
      choice(
        token.immediate(/\\['"?\\abfnrtv]/),
        token.immediate(/\\x[0-9A-Fa-f][0-9A-Fa-f]/),
        token.immediate(/\\[0-7]{1,3}/),
        token.immediate(/\\u[0-9A-Fa-f]{4}/),
        token.immediate(/\\U[0-9A-Fa-f]{8}/),
      ),

    htmlentity: $ => token.immediate(/\\&[a-zA-Z_]+;/),

    end_file: (_) => token(seq(prec(100, choice(/\x1a/, /__EOF__/)))),

    comment: (_) =>
      token(
        choice(
          seq("//", /(\\+(.|\r?\n)|[^\\\n])*/),
          seq("/*", /[^*]*\*+([^/*][^*]*\*+)*/, "/"),
          // nesting comments, we "only" support 5 levels of nesting
          seq(
            "/+",
            repeat(
              choice(
                /[^+]/,
                /\+[^\/]/,
                seq(
                  "/+",
                  repeat(
                    choice(
                      /[^+]/,
                      /\+[^\/]/,
                      seq(
                        "/+",
                        repeat(
                          choice(
                            /[^+]/,
                            /\+[^\/]/,
                            seq(
                              "/+",
                              repeat(
                                choice(
                                  /[^+]/,
                                  /\+[^\/]/,
                                  seq(
                                    "/+",
                                    repeat(choice(/[^+]/, /\+[^\/]/)),
                                    /[\+]+\//,
                                  ),
                                ),
                              ),
                              /[\+]+\//,
                            ),
                          ),
                        ),
                        /[\+]+\//,
                      ),
                    ),
                  ),
                  /[\+]+\//,
                ),
              ),
            ),
            /[\+]+\//,
          ),
        ),
      ),

    identifier: _$ => /[_\p{XID_Start}][\p{XID_Continue}]*/,

    token_string_literal: ($) => seq("q{", optional($._token_string_tokens), "}"),

    // we aren't tokenizing this yet
    _token_string_tokens: $ => repeat1($._token_string_token),

    _token_string_token: $ =>
      choice(
        seq('{', optional($._token_string_tokens), '}'),
        $._token_no_braces,
      ),

    _token_no_braces: $ =>
      choice(
        $.identifier,
        $._string_literal,
        $.character_literal,
        $.integer_literal,
        $.float_literal,
        $._keyword,
        '/',
        '/=',
        '.',
        '..',
        '...',
        '&',
        '&=',
        '&&',
        '|',
        '|=',
        '||',
        '-',
        '-=',
        '--',
        '+',
        '+=',
        '++',
        '<',
        '<=',
        '<<',
        '<<=',
        '>',
        '>=',
        '>>=',
        '>>>=',
        '>>',
        '>>>',
        '!',
        '!=',
        '(',
        ')',
        '[',
        ']',
        '?',
        ',',
        ';',
        ':',
        '$',
        '=',
        '==',
        '*',
        '*=',
        '%',
        '%=',
        '^',
        '^=',
        '^^',
        '^^=',
        '~',
        '~=',
        '@',
        '=>',
        '#',
        '!in',
        '!is',
      ),

    _keyword: $ =>
      choice(
        'abstract',
        'alias',
        'align',
        'asm',
        'assert',
        'auto',
        'break',
        'case',
        'cast',
        'catch',
        'class',
        'continue',
        'debug',
        'default',
        'delegate',
        'delete',
        'deprecated',
        'do',
        'else',
        'enum',
        'export',
        'extern',
        'final',
        'finally',
        'for',
        'foreach',
        'foreach_reverse',
        'function',
        'goto',
        'if',
        'import',
        'in',
        'interface',
        'invariant',
        'is',
        'lazy',
        'mixin',
        'module',
        'new',
        'nothrow',
        'out',
        'override',
        'package',
        'pragma',
        'private',
        'protected',
        'public',
        'pure',
        'ref',
        'return',
        'scope',
        'static',
        'struct',
        'super',
        'switch',
        'synchronized',
        'template',
        'this',
        'throw',
        'try',
        'typeid',
        'typeof',
        'union',
        'unittest',
        'version',
        'while',
        'with',
        '__gshared',
        'traits',
        'vector',
        '__parameters',
        $.special_keyword,
        'false',
        'true',
        'null',
        $.primitive_type,
        'void',
        $.type_qualifier,
      ),

    module_definition: $ => seq($.module_declaration, repeat($._declaration)),

    module_declaration: $ =>
      seq(
        // deprecated attribute can only appear once
        repeat($.at_attribute),
        optional(seq($.deprecated_attribute, repeat($.at_attribute))),
        'module',
        $.module_fqn,
        ';',
      ),

    module_fqn: $ => seq($.identifier, repeat(seq('.', $.identifier))),

    // Import Declarations
    // Note that 'static import' is not provided for here, because it is
    // ambiguous with the attribute_specifiers. Technically we probably
    // prefer the static to be more tightly bound to the import, but for
    // syntax tree analysis it probably does not matter much.
    import_declaration: $ =>
      seq(repeat($._attribute), 'import', $._import_list, ';'),

    _import_list: $ =>
      choice(
        seq($.imported, optional(seq(',', $._import_list))),
        seq($.imported, ':', commaSep1($.import_bind)),
      ),

    // libdparse calls this single_import
    imported: $ =>
      choice(
        $.module_fqn,
        seq(field('alias', $.identifier), '=', $.module_fqn),
      ),

    import_bind: $ => seq($.identifier, optional(seq('=', $.identifier))),

    mixin_declaration: $ =>
      seq(repeat($._attribute), $.mixin_expression, ';'),

    _declaration: $ =>
      choice(
        seq($._declaration2),
        // seq(repeat1($._attribute), $._declaration2),
        seq(repeat1($._attribute), '{', repeat($._declaration), '}'),
      ),

    _declaration2: $ =>
      prec.left(
        choice(
          $.alias_declaration,
          $.alias_this_declaration,
          $.anonymous_enum_declaration,
          $.attribute_declaration,
          $.class_declaration,
          $.conditional_declaration,
          $.constructor_declaration,
          $.debug_specification,
          $.destructor_declaration,
          $.postblit_declaration,
          $.function_declaration,
          $.enum_declaration,
          $.import_declaration,
          $.interface_declaration,
          $.invariant_declaration,
          $.mixin_declaration,
          $.mixin_template_declaration,
          $.pragma_declaration,
          $.struct_declaration,
          $.template_declaration,
          $.template_mixin,
          $.union_declaration,
          $.unittest_declaration,
          $.variable_declaration,
          $.manifest_constant,
          $.version_specification,
          $.static_assert_statement,
          $.auto_declaration,
          $.static_foreach_declaration,
          $.alias_reassign, // only valid really inside a template declaration
          ';', // NB: this is deprecated, and is really an empty statement
        ),
      ),

    variable_declaration: $ =>
      seq(
        repeat($._attribute),
        repeat($.storage_class),
        $.type,
        commaSep1(choice($.declarator, $.bitfield_declarator)),
        ';',
      ),

    _declarator_identifier_list: $ => prec.right(commaSep1($.identifier)),

    declarator: $ =>
      prec.right(
        seq(
          $.identifier,
          optional(seq(optional($.template_parameters), '=', $._initializer)),
        ),
      ),

    bitfield_declarator: $ =>
      prec.right(
        choice(
          seq(':', $._expr),
          seq($.identifier, ':', $._expr, optional(seq('=', $._initializer))),
        ),
      ),

    manifest_constant: $ =>
      seq(
        repeat($._attribute),
        repeat($.storage_class),
        'enum',
        repeat($.storage_class),
        optional($.type),
        commaSep1($.manifest_declarator),
        ';',
      ),

    manifest_declarator: $ =>
      choice(
        seq($.identifier, '=', $._initializer),
        seq($.identifier, $.template_parameters, '=', $._initializer),
      ),

    storage_class: $ =>
      choice(
        $.linkage_attribute,
        $.align_attribute,
        $.at_attribute,
        $.type_qualifier,
        'deprecated',
        'static',
        'extern',
        'abstract',
        'final',
        'override',
        'synchronized',
        'auto',
        'scope',
        '__gshared',
        'ref',
        $._function_attribute_kwd,
      ),

    _initializer: $ => prec.left(choice($._non_void_initializer, 'void')),

    _non_void_initializer: $ => choice($._expr, $.aggregate_initializer),

    auto_declaration: $ => prec.right(seq(repeat($._attribute), repeat1($.storage_class), commaSep1($._auto_assignment), ';')),

    _auto_assignment: $ => seq(field('variable', $.identifier), optional($.template_parameters), '=', field('value', $._initializer)),

    alias_declaration: $ =>
      seq(
        repeat($._attribute),
        'alias',
        choice(
          seq(commaSep1($.alias_initializer), ';'),
          seq(repeat($.storage_class), $.type, $._declarator_identifier_list, ';'),
          seq(repeat($.storage_class), $.type, $.identifier, optional($.template_parameters), $.parameters, repeat($.member_function_attribute), ';'),
        ),
      ),

    alias_initializer: $ =>
      choice(
        seq($.identifier, optional($.template_parameters), '=', repeat($.storage_class), $.type),
        seq($.identifier, optional($.template_parameters), '=', repeat($.storage_class), $.function_literal),
        seq($.identifier, optional($.template_parameters), '=', repeat($.storage_class), $.type, $.parameters, repeat($.member_function_attribute)),
      ),

    alias_assign: $ => seq($.identifier, '=', $.type),

    // TODO: limit to inside template declarations only
    alias_reassign: $ =>
      seq(
        repeat($._attribute),
        prec.dynamic(
          -1,
          choice(
            seq($.identifier, '=', repeat($.storage_class), $.type, ';'),
            seq($.identifier, '=', $.function_literal, ';'),
            seq(
              $.identifier,
              '=',
              repeat($.storage_class),
              $.type,
              $.parameters,
              repeat($.member_function_attribute),
              ';',
            ),
          ),
        ),
      ),

    type: $ => prec.right(seq(repeat($.type_qualifier), $._type2, repeat($._type_suffix))),

    type_qualifier: $ => choice('const', 'immutable', 'inout', 'shared'),

    _type2: $ =>
      prec.right(
        choice(
          'void',
          $.primitive_type,
          $._qualified_id,
          seq('.', $._qualified_id),
          $.typeof_expression,
          seq($.typeof_expression, '.', $._qualified_id),
          seq($.type_qualifier, '(', $.type, ')'),
          $.vector_type,
          $.traits_expression,
          $.mixin_expression,
        ),
      ),

    // dparse says the type is optional, but that seems nonsensical.
    vector_type: $ => seq('__vector', '(', $.type, ')'),

    // aka {primitive|builtin|fundamental} type
    primitive_type: $ => token(choice(
        'bool',
        'byte',
        'ubyte',
        'char',
        'short',
        'ushort',
        'int',
        'uint',
        'long',
        'ulong',
        'cent', // deprecated
        'ucent', // deprecated
        'wchar',
        'dchar',
        'float',
        'double',
        'real',
        'ifloat', // deprecated
        'idouble', // deprecated
        'ireal', // deprecated
        'cfloat', // deprecated
        'cdouble', // deprecated
        'creal', // deprecated
        'size_t',
        'ptrdiff_t',
        'string',
        'cstring',
        'dstring',
        'wstring',
        'noreturn',
      )),

    // we call out void specially because it is not always a basic type
    void: _$ => token('void'),

    _type_suffix: $ =>
      prec.right(
        choice(
          '*',
          seq('[', ']'),
          seq('[', $._expression, ']'),
          seq('[', $._expression, '..', $._expression, ']'),
          seq('[', $.type, ']'),
          seq('delegate', $.parameters, repeat($.member_function_attribute)),
          seq('function', $.parameters, repeat($._function_attribute)),
        ),
      ),

    _identifier_or_template_instance: $ =>
      choice($.identifier, $.template_instance),

    // NB: we have inlined some of the forms of the type suffixes
    // here, in order to avoid some of the problems that can occur
    // with conflicts between the suffix forms (always at the end)
    // and the intermediate forms.
    _qualified_id: $ =>
      prec.right(
        choice(
          seq($.identifier),
          seq($.identifier, '.', $._qualified_id),
          seq($.identifier, '[', ']'),
          seq($.identifier, '[', $._expression, '..', $._expression, ']'),
          seq($.identifier, '[', $.type, ']'),
          seq($.identifier, '[', $._expression, ']'),
          seq($.identifier, '[', $._expression, ']', '.', $._qualified_id),
          seq($.template_instance),
          seq($.template_instance, '.', $._qualified_id),
        ),
      ),

    typeof_expression: $ =>
      seq('typeof', '(', choice($._expression, 'return'), ')'),

    // Mixin Type replaced by mixin_expression (evaluates identically)

    //
    // 3.5 ATTRIBUTES
    //

    attribute_declaration: $ => seq(repeat1($._attribute), ':'),

    align_attribute: $ =>
      prec.right(seq('align', optional(seq('(', $._expression, ')')))),

    deprecated_attribute: $ =>
      prec.right(seq('deprecated', optional(seq('(', $._expression, ')')))),

    _attribute: $ =>
      prec.right(
        choice(
          $.linkage_attribute,
          $.align_attribute,
          $.deprecated_attribute,
          $.pragma_expression,
          $.type_qualifier,
          'private',
          'package',
          seq('package', '(', $.module_fqn, ')'),
          'protected',
          'public',
          'export',
          'static',
          'extern',
          'abstract',
          'final',
          'override',
          'synchronized',
          'auto',
          'scope',
          '__gshared',
          $.at_attribute,
          $._function_attribute_kwd,
          'ref',
          'return',
        ),
      ),

    at_attribute: $ =>
      prec.right(
        choice(
          seq('@', $.identifier),
          seq('@', $.identifier, $.arguments),
          seq('@', $.template_instance),
          seq('@', $.template_instance, $.arguments),
          seq('@', '(', $._argument_list, ')'),
        ),
      ),

    _function_attribute_kwd: $ => choice('nothrow', 'pure'),

    linkage_attribute: $ =>
      prec.right(
        seq(
          'extern',
          '(',
          choice(
            'C',
            'D',
            'Windows',
            'System',
            seq('Objective', '-', 'C'),
            seq('C', '++'),
            // this tecnically permits assignment operations, which is wrong, but simpler
            seq(
              'C',
              '++',
              ',',
              optional(alias($._argument_list, $.namespace_list)),
            ),
            seq('C', '++', ',', 'class'),
            seq('C', '++', ',', 'struct'),
          ),
          ')',
        ),
      ),

    _argument_list: $ => prec.right(commaSep1Comma($._expression)),

    arguments: $ => seq('(', optional($._argument_list), ')'),

    named_argument: $ =>
      choice($._expression, seq($.identifier, ':', $._expression)),

    _named_argument_list: $ => prec.right(commaSep1Comma($.named_argument)),

    named_arguments: $ => seq('(', optional($._named_argument_list), ')'),

    // 3.6 PRAGMAS

    pragma_declaration: $ =>
      seq(
        repeat($._attribute), // how is this useful for pragma?
        choice(
          seq($.pragma_expression, ';'),
          seq($.pragma_expression, $._declaration),
          seq($.pragma_expression, '{', repeat($._declaration), '}'),
        ),
      ),

    pragma_statement: $ =>
      choice(
        seq($.pragma_expression, $._statement), // covers compound_statement as well
        seq($.pragma_expression, ';'),
      ),

    pragma_expression: $ =>
      choice(
        seq('pragma', '(', $.identifier, ')'),
        seq('pragma', '(', $.identifier, ',', $._argument_list, ')'),
      ),

    // 3.7 EXPRESSIONS

    // in statements, most uses of expressions can use comma form
    expression_list: $ => prec.right(commaSep1($._expr)),

    // formally this is AssignExpression, but we use a different
    // structure.  This is just a single _expression term, and
    // cannot be used in a comma _expression. Expression is
    // used where comma separated expressions are valid.
    //
    // The formal D grammar permits _expression lists in many places,
    // but then the compiler rejects almost any attempt to use them.
    // We are electing to reject these in the syntax, rather than
    // in the semantic.  This makes our grammar simpler, and has
    // zero effect on any actual legal code.
    _expression: $ => $._expr,
    _expr: $ =>
      prec.left(
        choice(
          $.assignment_expression,
          $.ternary_expression,
          $._binary_expression,
          $.ternary_expression,
          $._unary_expr,
        ),
      ),

    ternary_expression: $ =>
      prec.right(
        'ternary',
        seq(
          field('condition', $._expr),
          '?',
          field('consequence', $.expression_list),
          ':',
          field('alternative', $._expr),
        ),
      ),

    call_expression: $ =>
      prec.left(
        choice(
          seq($._unary_expr, $.named_arguments),
          prec(2, seq($.primitive_type, $.named_arguments)),
          prec(1, seq($.identifier, $.named_arguments)),
          seq($.type, $.named_arguments),
        ),
      ),

    primary_expression: $ =>
      choice(
        seq('(', $.type, ')', '.', $.identifier),
        seq('(', $.type, ')', '.', $.template_instance),
        seq($.primitive_type, '.', $.identifier),
        seq('void', '.', $.identifier),
        seq('(', $.expression_list, ')'),
        seq($.type_qualifier, '(', $.type, ')', '.', $.identifier),
        seq($.vector_type, '.', $.identifier),
      ),

    _primary_expr: $ =>
      choice(
        $._identifier_or_template_instance,
        seq('.', $._identifier_or_template_instance),
        $.primary_expression,
        $.typeof_expression,
        $.typeid_expression,
        $.array_literal,
        $.is_expression,
        $.function_literal,
        $.traits_expression,
        $.mixin_expression,
        $.import_expression,
        'this',
        'super',
        'null',
        'true',
        'false',
        '$',
        $._string_literal,
        $.integer_literal,
        $.float_literal,
        $.character_literal,
        $.special_keyword,
      ),

    // also covers slicing (we renamed from slice,
    // and deleted the old index _expression as it was redundant)
    slice_expression: $ =>
      choice(
        seq($._unary_expr, '[', ']'),
        seq($._unary_expr, '[', commaSep1Comma($.slice_expression_range), ']'),
      ),

    slice_expression_range: $ => seq($._expression, optional(seq('..', $._expression))),

    assignment_expression: $ =>
      prec.right(
        -1,
        binaryOp(
          $._expr,
          choice(
            '=',
            '+=',
            '-=',
            '*=',
            '/=',
            '%=',
            '&=',
            '|=',
            '^=',
            '~=',
            '<<=',
            '>>=',
            '>>>=',
            '^^=',
          ),
          $._expr,
        ),
      ),

    // TODO: Compare with tree-sitter-c's implementation instead
    _binary_expression: $ =>
      choice(
        $.logical_or_binary_expression,
        $.logical_and_binary_expression,
        $.bitwise_or_binary_expression,
        $.bitwise_xor_binary_expression,
        $.bitwise_and_binary_expression,
        $.equal_binary_expression,
        $.rel_binary_expression,
        $.identity_binary_expression,
        $.add_binary_expression,
        $.mul_binary_expression,
        $.shift_binary_expression,
        $.power_binary_expression,
      ),

    logical_or_binary_expression: $ =>
      prec.left('logical_or', binaryOp($._expr, '||', $._expr)),

    logical_and_binary_expression: $ =>
      prec.left('logical_and', binaryOp($._expr, '&&', $._expr)),

    bitwise_or_binary_expression: $ =>
      prec.left('inclusive_or', binaryOp($._expr, '|', $._expr)),

    bitwise_xor_binary_expression: $ =>
      prec.left('exclusive_or', binaryOp($._expr, '^', $._expr)),

    bitwise_and_binary_expression: $ =>
      prec.left('bitwise_and', binaryOp($._expr, '&', $._expr)),

    equal_binary_expression: $ =>
      prec.left('compare', binaryOp($._expr, choice('==', '!='), $._expr)),

    rel_binary_expression: $ =>
      prec.left(
        'compare',
        binaryOp($._expr, choice('<=', '<', '>', '>='), $._expr),
      ),

    identity_binary_expression: $ =>
      prec.left(
        'compare',
        seq($._expr, choice($.not_is, $.not_in, 'in', 'is'), $._expr),
      ),

    add_binary_expression: $ =>
      prec.left('add', binaryOp($._expr, choice('+', '-', '~'), $._expr)),

    mul_binary_expression: $ =>
      prec.left('multiply', binaryOp($._expr, choice('*', '/', '%'), $._expr)),

    shift_binary_expression: $ =>
      prec.left('shift', binaryOp($._expr, choice('<<', '>>', '>>>'), $._expr)),

    power_binary_expression: $ =>
      prec.left('power', binaryOp($._expr, '^^', $._unary_expr)),

    postfix_expression: $ =>
      prec.left(seq($._unary_expr, field('operator', choice('++', '--')))),

    _unary_expr: $ =>
      choice(
        $._primary_expr,
        $.unary_expression,
        $.new_expression,
        $.delete_expression,
        $.assert_expression,
        $.cast_expression,
        $.throw_expression,
        $.call_expression,
        $.slice_expression,
        $.postfix_expression,
        $.property_expression,
      ),

    unary_expression: $ =>
      prec.right(
        'unary',
        seq(
          field('operator', choice('~', '+', '-', '!', '*', '&', '++', '--')),
          $._unary_expr,
        ),
      ),

    property_expression: $ =>
      choice(
        seq('(', $.type, ')', '.', $._identifier_or_template_instance),
        prec.left(seq($._unary_expr, '.', $._identifier_or_template_instance)),
        prec.left(seq($._unary_expr, '.', $.new_expression)),
      ),

    cast_expression: $ =>
      prec.right(
        choice(
          seq('cast', '(', ')', field('operand', $._unary_expr)),
          seq('cast', '(', $.type, ')', field('operand', $._unary_expr)),
          seq('cast', '(', $.type_cast_qualifier, ')', $._unary_expr),
        ),
      ),

    // these are only allowed in specific combinations
    type_cast_qualifier: $ =>
      choice(
        'const',
        seq('const', 'shared'),
        'immutable',
        'inout',
        seq('inout', 'shared'),
        'shared',
        seq('shared', 'const'),
        seq('shared', 'inout'),
      ),

    delete_expression: $ => prec.left(seq('delete', $._unary_expr)),

    throw_expression: $ => prec.left(seq('throw', $._unary_expr)),

    assert_expression: $ => seq('assert', '(', $.assert_arguments, ')'),
    assert_arguments: $ =>
      seq(
        $._expression,
        optional(seq(',', commaSep1($._expression))),
        optional(','),
      ),

    mixin_expression: $ => seq('mixin', '(', $._argument_list, ')'),

    import_expression: $ => seq('import', '(', $._expression, ')'),

    new_expression: $ =>
      prec.left(
        choice(
          seq('new', $.type),
          seq('new', $.type, '[', $._expression, ']'),
          seq('new', $.type, $.arguments),
          seq(
            'new',
            'class',
            optional($.arguments),
            optional($._base_class_list),
            $.aggregate_body,
          ),
        ),
      ),

    typeid_expression: $ =>
      seq('typeid', '(', choice($.type, $._expression), ')'),

    is_expression: $ =>
      prec.right(
        seq(
          'is',
          '(',
          $.type,
          optional($.identifier),
          optional(
            seq(
              choice('==', ':'),
              $.type_specialization,
              optional(seq(',', $._template_parameter_list)),
            ),
          ),
          ')',
        ),
      ),

    type_specialization: $ =>
      choice(
        $.type,
        'struct',
        'union',
        'class',
        'interface',
        'enum',
        '__vector',
        'function',
        'delegate',
        'super',
        'const',
        'immutable',
        'inout',
        'shared',
        'return',
        '__parameters',
        'module',
        'package',
      ),

    raw_string_literal: ($) =>
      choice(
        seq('`', token.immediate(prec(1, /[^`]*/)), token.immediate(/`[cdw]?/)),
        seq(
          'r"',
          token.immediate(prec(1, /[^"]*/)),
          token.immediate(/"[cdw]?/),
        ),
      ),

    hex_string_literal: ($) =>
      seq(
        'x"',
        token.immediate(prec(1, /[0-9A-Fa-f\s]*/)),
        token.immediate(/"[cdw]?/),
      ),

    // TODO: _unescaped_string_content: (_) => token.immediate(/[^"\\]+/),

    quoted_string_literal: ($) =>
      seq(
        '"',
        repeat(
          choice(
            token.immediate(prec(1, /[^"\\]+/)),
            $.escape_sequence,
            $.htmlentity,
          ),
        ),
        token.immediate(/"[cdw]?/),
      ),

    interpolation_expression: $ => seq('$(', $._expression, ')'),

    interpolated_raw_string_literal: ($) =>
      seq(
        'i`',
        repeat(choice(/[^`$]+/, /\$[^(`]/, $.interpolation_expression)),
        choice('`', '$`'), // tailing "$" special
      ),

    interpolated_escape: $ => '\\$',

    interpolated_quoted_string_literal: ($) =>
      seq(
        'i"',
        repeat(
          choice(
            /[^"$\\]+/,
            /\$[^(]/,
            $.escape_sequence,
            $.htmlentity,
            $.interpolated_escape,
            $.interpolation_expression,
          ),
        ),
        choice('"', '$"'), // tailing "$" special
      ),

    interpolated_token_string_literal: ($) =>
      seq("iq{", optional($._interpolated_token_string_tokens), "}"),

    // we aren't tokenizing this yet
    _interpolated_token_string_tokens: $ =>
      repeat1(choice($._token_string_token, $.interpolation_expression)),

    _interpolated_token_string_token: $ =>
      choice(
        seq('{', optional($._interpolated_token_string_tokens), '}'),
        choice($._token_no_braces, $.interpolation_expression),
      ),

    boolean_literal: $ => token(choice('false', 'true')),

    _string_literal: ($) =>
      choice(
        $.regular_string_literal,
        $.raw_string_literal,
        $.hex_string_literal,
        $.quoted_string_literal,
        $.token_string_literal,
        $.interpolated_raw_string_literal,
        $.interpolated_quoted_string_literal,
        $.interpolated_token_string_literal,
      ),

    character_literal: $ =>
      choice(
        /'[^\\']'/,
        seq("'", choice($.escape_sequence, $.htmlentity), "'"),
      ),

    // NB: array_literals are a super set of associative array literals,
    // and grammatically the two are not distinguishable.
    array_literal: $ =>
      seq('[', optional(commaSep1Comma($._array_member_init)), ']'),

    _array_member_init: $ =>
      choice(
        seq(
          optional(seq(field('key', $._expression), ':')),
          field('value', $._non_void_initializer),
        ),
      ),

    function_literal: $ =>
      prec.right(
        choice(
          seq(
            'function',
            optional(seq(optional('auto'), 'ref')),
            optional($.type),
            optional($._parameter_with_attributes),
            $._specified_function_body,
          ),
          seq(
            'function',
            optional(seq(optional('auto'), 'ref')),
            optional($.type),
            $._parameter_with_attributes,
            '=>',
            $._expr,
          ),
          seq(
            'delegate',
            optional(seq(optional('auto'), 'ref')),
            optional($.type),
            optional($._parameter_with_member_attributes),
            $._specified_function_body,
          ),
          seq(
            'delegate',
            optional(seq(optional('auto'), 'ref')),
            optional($.type),
            $._parameter_with_member_attributes,
            '=>',
            $._expr,
          ),
          seq(
            optional(seq(optional('auto'), 'ref')),
            $._parameter_with_member_attributes,
            $._specified_function_body,
          ),
          seq(
            optional(seq(optional('auto'), 'ref')),
            $._parameter_with_member_attributes,
            '=>',
            $._expr,
          ),
          $._specified_function_body,
          seq($.identifier, '=>', $._expr),
        ),
      ),

    _parameter_with_attributes: $ =>
      seq($.parameters, repeat($._function_attribute)),

    _parameter_with_member_attributes: $ =>
      seq($._parameters, repeat($.member_function_attribute)),

    special_keyword: _$ => token(choice(
        '__DATE__',
        '__FILE__',
        '__FILE_FULL_PATH__',
        '__FUNCTION__',
        '__LINE__',
        '__MODULE__',
        '__PRETTY_FUNCTION__',
        '__TIME__',
        '__TIMESTAMP__',
        '__VENDOR__',
        '__VERSION__',
      )),

    // this does not include the empty statement - that usage is deprecated
    _statement: $ =>
      choice($._statement_no_case_no_default, $.case_statement),

    _declarations_and_statements: $ => repeat1($._declaration_or_statement),

    _declaration_or_statement: $ => choice($._declaration, $._statement),

    scope_statement: $ => $._declaration_or_statement,
    body: $ => field('body', $.scope_statement),
    consequence: $ => field('consequence', $.scope_statement),
    alternative: $ => field('alternative', $.scope_statement),

    _statement_no_case_no_default: $ =>
      choice(
        $.labeled_statement,
        $.expression_statement,
        $.compound_statement,
        $.if_statement,
        $.while_statement,
        $.do_statement,
        $.for_statement,
        $.foreach_statement,
        $.switch_statement,
        $.final_switch_statement,
        $.continue_statement,
        $.break_statement,
        $.return_statement,
        $.goto_statement,
        $.with_statement,
        $.synchronized_statement,
        $.try_statement,
        $.scope_guard_statement,
        $.pragma_statement,
        $.asm_statement,
        $.static_conditional_statement,
        $.static_assert_statement,
        $.static_foreach_statement,
        $.version_specification,
        $.debug_specification,
      ),

    labeled_statement: $ => prec.left(seq($.label, $.body)),

    // a label can appear at the end of the a scope, otherwise  it must be followed by a decl or statement.
    label: $ => seq($.identifier, ':'),

    compound_statement: $ =>
      seq(
        '{',
        optional($._declarations_and_statements),
        optional($.label),
        '}',
      ),

    expression_statement: $ => seq($.expression_list, ';'),

    if_statement: $ => prec.right(seq(
      'if',
      field('condition', $.if_condition),
      field('consequence', $.consequence),
      optional(seq('else', $.alternative)),
    )),

    if_condition: $ =>
      seq(
        '(',
        choice(
          $._expr,
          seq('auto', $.identifier, '=', $._expression),
          seq('scope', $.identifier, '=', $._expression),
          seq(repeat1($.type_qualifier), $.identifier, '=', $._expression),
          seq($.type, $.identifier, '=', $._expression), // type constructors already bound to type
        ),
        ')',
      ),

    while_statement: $ => seq('while', $.if_condition, $.body),

    do_statement: $ =>
      seq('do', $.body, 'while', '(', field('condition', $._expression), ')'),

    for_statement: $ =>
      seq(
        'for',
        '(',
        $._for1,
        optional($._for2),
        optional(seq(';', optional($._for3))),
        ')',
        $.body,
      ),

    _for1: $ =>
      choice(
        field('init', $._declaration2),
        field('init', $._statement_no_case_no_default),
        ';',
      ),
    _for2: $ => field('test', $._expression),
    _for3: $ => field('step', $.expression_list),

    _foreach: $ => choice('foreach', 'foreach_reverse'),

    foreach_statement: $ =>
      choice(
        seq(
          $._foreach,
          '(',
          commaSep1($.foreach_type),
          ';',
          $._expression,
          ')',
          $.body,
        ),
        seq(
          $._foreach,
          '(',
          $.foreach_type,
          ';',
          $._expression,
          '..',
          $._expression,
          ')',
          $.body,
        ),
      ),

    foreach_type: $ =>
      seq(
        repeat(choice('ref', 'alias', 'enum', 'scope', $.type_qualifier)),
        optional($.type),
        $.identifier,
      ),

    switch_statement: $ => seq('switch', '(', $._expression, ')', $.body),

    case_statement: $ =>
      prec.right(
        choice(
          seq(
            'case',
            $.expression_list,
            optional(','),
            ':',
            repeat(choice($._declaration, $._statement_no_case_no_default)),
          ),
          seq(
            'case',
            $._expression,
            ':',
            '..',
            'case',
            $._expression,
            ':',
            repeat(choice($._declaration, $._statement_no_case_no_default)),
          ),
          seq(
            'default',
            ':',
            repeat(choice($._declaration, $._statement_no_case_no_default)),
          ),
        ),
      ),

    final_switch_statement: $ => seq('final', $.switch_statement),

    continue_statement: $ => seq('continue', optional($.identifier), ';'),

    break_statement: $ => seq('break', optional($.identifier), ';'),

    return_statement: $ => seq('return', optional($._expression), ';'),

    goto_statement: $ =>
      choice(
        seq('goto', $.identifier, ';'),
        seq('goto', 'default', ';'),
        seq('goto', 'case', ';'),
        seq('goto', 'case', $._expression, ';'),
      ),

    with_statement: $ =>
      seq('with', '(', $._expression, ')', $.scope_statement),

    synchronized_statement: $ =>
      prec.left(
        seq(
          'synchronized',
          optional(seq('(', $._expression, ')')),
          $.scope_statement,
        ),
      ),

    try_statement: $ =>
      prec.right(
        seq(
          'try',
          $.body,
          repeat($.catch_statement),
          optional($.finally_statement),
        ),
      ),

    catch_statement: $ =>
      seq('catch', seq('(', $.type, optional($.identifier), ')'), $.body),

    finally_statement: $ => seq('finally', $.body),

    scope_guard_statement: $ =>
      seq('scope', '(', choice('exit', 'success', 'failure'), ')', $.body),

    asm_statement: $ =>
      seq(
        'asm',
        repeat($._function_attribute),
        '{',
        optional($.asm_inline),
        '}',
      ),

    asm_inline: $ => repeat1($._token_no_braces),

    mixin_statement: $ => seq('mixin', '(', $._argument_list, ')', ';'),

    struct_declaration: $ =>
      seq(
        repeat($._attribute),
        choice(
          seq('struct', $.aggregate_body), // anonymous struct
          seq('struct', $.identifier, ';'),
          seq('struct', $.identifier, $.aggregate_body),
          seq(
            'struct',
            $.identifier,
            $.template_parameters,
            optional($.template_constraint),
            ';',
          ),
          seq(
            'struct',
            $.identifier,
            $.template_parameters,
            optional($.template_constraint),
            $.aggregate_body,
          ),
        ),
      ),

    // AnonStructDeclaration inlined above

    union_declaration: $ =>
      seq(
        repeat($._attribute),
        choice(
          seq('union', $.aggregate_body), // anonymous union
          seq('union', $.identifier, ';'),
          seq('union', $.identifier, $.aggregate_body),
          seq(
            'union',
            $.identifier,
            $.template_parameters,
            optional($.template_constraint),
            ';',
          ),
          seq(
            'union',
            $.identifier,
            $.template_parameters,
            optional($.template_constraint),
            $.aggregate_body,
          ),
        ),
      ),

    // AnonUnionDeclaration inlined above

    aggregate_body: $ => seq('{', repeat($._declaration), '}'),

    //
    // Struct Initializer
    //
    // renamed to aggregate initializer, as this is used for
    // all aggregate types (classes, enums, interfaces, structs)
    // also struct_member_initializers is inlined here
    aggregate_initializer: $ =>
      seq('{', optional(commaSep1Comma($.member_initializer)), '}'),

    // struct_member_initializer shortened to member_initializer
    member_initializer: $ =>
      seq(optional(seq($.identifier, ':')), $._initializer),

    postblit_declaration: $ =>
      seq(
        repeat($._attribute),
        'this',
        '(',
        'this',
        ')',
        repeat($.member_function_attribute),
        $.function_body,
      ),

    invariant_declaration: $ =>
      seq(
        repeat($._attribute),
        choice(
          seq('invariant', '(', ')', $.compound_statement),
          seq('invariant', $.compound_statement),
          seq('invariant', '(', $.assert_arguments, ')', ';'),
        ),
      ),

    class_declaration: $ =>
      seq(
        repeat($._attribute),
        choice(
          seq('class', $.identifier, optional($.template_parameters), ';'),
          seq('class', $.identifier, $.aggregate_body),
          seq('class', $.identifier, ':', $._base_class_list, $.aggregate_body),
          seq(
            'class',
            $.identifier,
            $.template_parameters,
            optional($.template_constraint),
            $.aggregate_body,
          ),
          seq(
            'class',
            $.identifier,
            $.template_parameters,
            optional($.template_constraint),
            ':',
            $._base_class_list,
            optional($.template_constraint),
            $.aggregate_body,
          ),
          seq(
            'class',
            $.identifier,
            $.template_parameters,
            ':',
            $._base_class_list,
            $.template_constraint,
            $.aggregate_body,
          ),
        ),
      ),

    _base_class_list: $ => commaSep1($.base_class),
    base_class: $ => $._type2,

    // Invariant was listed in 3.9 above already.

    // Use a single form with optional shared static prefixes instead of separate expansions.
    constructor_declaration: $ =>
      seq(
        repeat($._attribute),
        choice(
          seq(
            'this',
            $.parameters,
            repeat($.member_function_attribute),
            $.function_body,
          ),
          seq(
            'this',
            $.template_parameters,
            $.parameters,
            repeat($.member_function_attribute),
            optional($.template_constraint),
            $.function_body,
          ),
          seq(
            optional('shared'),
            'static',
            'this',
            '(',
            ')',
            repeat($.member_function_attribute),
            $.function_body,
          ),
        ),
      ),

    destructor_declaration: $ =>
      seq(
        repeat($._attribute),
        optional(seq(optional('shared'), 'static')),
        '~',
        'this',
        '(',
        ')',
        repeat($.member_function_attribute),
        $.function_body,
      ),

    alias_this_declaration: $ =>
      seq(repeat($._attribute),
        'alias',
        choice(
          seq($.identifier, 'this'),
          seq('this', '=', $.identifier)),
        ';'),

    interface_declaration: $ =>
      seq(
        repeat($._attribute),
        choice(
          seq('interface', $.identifier, ';'),
          seq('interface', $.identifier, $.aggregate_body),
          seq(
            'interface',
            $.identifier,
            ':',
            $._base_class_list,
            $.aggregate_body,
          ),
          seq(
            'interface',
            $.identifier,
            $.template_parameters,
            $.aggregate_body,
          ),
          seq(
            'interface',
            $.identifier,
            $.template_parameters,
            ':',
            $._base_class_list,
            $.aggregate_body,
          ),
          seq(
            'interface',
            $.identifier,
            $.template_parameters,
            ':',
            $._base_class_list,
            $.template_constraint,
            $.aggregate_body,
          ),
          seq(
            'interface',
            $.identifier,
            $.template_parameters,
            $.template_constraint,
            $.aggregate_body,
          ),
          seq(
            'interface',
            $.identifier,
            $.template_parameters,
            $.template_constraint,
            ':',
            $._base_class_list,
            $.aggregate_body,
          ),
        ),
      ),

    enum_declaration: $ =>
      seq(
        repeat($._attribute),
        choice(
          seq('enum', $.identifier, ';'),
          seq('enum', $.identifier, $._enum_body),
          seq('enum', $.identifier, ':', $.type, ';'),
          seq('enum', $.identifier, ':', $.type, $._enum_body),
        ),
      ),

    _enum_body: $ => seq('{', commaSep1Comma($.enum_member), '}'),

    _enum_member_attribute: $ =>
      choice($.deprecated_attribute, $.at_attribute),

    enum_member: $ =>
      seq(
        repeat($._enum_member_attribute),
        $.identifier,
        optional(seq('=', $._expr)),
      ),

    anonymous_enum_declaration: $ =>
      seq(
        repeat($._attribute),
        'enum',
        optional(seq(':', $.type)),
        '{',
        commaSep1Comma(choice($.anonymous_enum_member, $.enum_member)),
        '}',
      ),

    anonymous_enum_member: $ => seq($.type, $.identifier, '=', $._expr),

    function_declaration: $ =>
      seq(
        repeat($._attribute),
        prec.right(
          choice(
            seq(
              $.type,
              $.identifier,
              $.parameters,
              repeat($.member_function_attribute),
              $.function_body,
            ),
            seq(
              $.type,
              $.identifier,
              $.template_parameters,
              $.parameters,
              repeat($.member_function_attribute),
              optional($.template_constraint),
              $.function_body,
            ),
            seq(
              repeat1($.storage_class),
              $.identifier,
              $.parameters,
              repeat($.member_function_attribute),
              $.function_body,
            ),
            seq(
              repeat1($.storage_class),
              $.identifier,
              $.template_parameters,
              $.parameters,
              repeat($.member_function_attribute),
              optional($.template_constraint),
              $.function_body,
            ),
          ),
        ),
      ),

    parameters: $ =>
      prec.right(
        choice(
          seq('(', ')'),
          seq('(', commaSep1Comma($.parameter), ')'),
          seq('(', commaSep1($.parameter), ',', $.ellipses, ')'),
          seq(
            '(',
            commaSep1($.parameter),
            ',',
            $._variadic_arguments_attributes,
            $.ellipses,
            ')',
          ),
          seq('(', $.ellipses, ')'),
          seq('(', $._variadic_arguments_attributes, $.ellipses, ')'),
        ),
      ),

    _parameters: $ =>
      prec.right(
        choice(
          seq('(', ')'),
          seq('(', commaSep1Comma($._parameter), ')'),
          seq('(', commaSep1($._parameter), ',', $.ellipses, ')'),
          seq(
            '(',
            commaSep1($._parameter),
            ',',
            $._variadic_arguments_attributes,
            $.ellipses,
            ')',
          ),
          seq('(', $.ellipses, ')'),
          seq('(', $._variadic_arguments_attributes, $.ellipses, ')'),
        ),
      ),

    parameter: $ => prec.right($._parameter),

    _parameter: $ =>
      prec.right(
        choice(
          seq(repeat($.parameter_attribute), $.type),
          seq(repeat($.parameter_attribute), $.type, $.ellipses),
          seq(
            repeat($.parameter_attribute),
            $.type,
            '=',
            $._expr,
            optional($.ellipses),
          ),
          seq(repeat($.parameter_attribute), $.type, $.identifier),
          seq(repeat($.parameter_attribute), $.type, $.identifier, $.ellipses),
          seq(
            repeat($.parameter_attribute),
            $.type,
            $.identifier,
            '=',
            $._expr,
            optional($.ellipses),
          ),
        ),
      ),

    parameter_attribute: $ =>
      choice(
        $.at_attribute,
        $.type_qualifier,
        'final',
        'in',
        'lazy',
        'out',
        'ref',
        'scope',
        'auto',
        'return',
      ),

    ellipses: _$ => '...',

    _variadic_arguments_attributes: $ =>
      repeat1($.variadic_arguments_attribute),

    variadic_arguments_attribute: $ =>
      choice('const', 'immutable', 'return', 'scope', 'shared'),

    _function_attribute: $ =>
      choice($._function_attribute_kwd, $.at_attribute),

    member_function_attribute: $ =>
      choice(
        'const',
        'immutable',
        'inout',
        'return',
        'scope',
        'shared',
        $._function_attribute,
      ),

    function_body: $ =>
      choice(
        seq(optional($._in_out_contract_expressions), '=>', $._expr, ';'),
        seq(repeat($._function_contract), optional('do'), $.compound_statement),
        seq(repeat($._function_contract), ';'),
        seq(repeat($._function_contract), $._in_out_statement),
      ),

    _specified_function_body: $ =>
      seq(repeat($._function_contract), optional('do'), $.compound_statement),

    _function_contract: $ =>
      choice($._in_out_contract_expression, $._in_out_statement),

    _in_out_contract_expressions: $ => repeat1($._in_out_contract_expression),

    _in_out_contract_expression: $ =>
      choice($.in_contract_expression, $.out_contract_expression),

    _in_out_statement: $ => choice($.in_statement, $.out_statement),

    in_contract_expression: $ => seq('in', '(', $.assert_arguments, ')'),

    out_contract_expression: $ =>
      seq('out', '(', optional($.identifier), ';', $.assert_arguments, ')'),

    in_statement: $ => seq('in', $.compound_statement),

    out_statement: $ =>
      seq('out', optional(seq('(', $.identifier, ')')), $.compound_statement),

    template_declaration: $ =>
      seq(
        repeat($._attribute),
        'template',
        $.identifier,
        $.template_parameters,
        optional($.template_constraint),
        '{',
        repeat($._declaration),
        '}',
      ),

    template_instance: $ =>
      prec.left(seq($.identifier, $.template_arguments)),

    template_arguments: $ =>
      prec.right(
        seq(
          '!',
          choice(
            seq('(', optional($._template_argument_list), ')'),
            $._template_single_arg,
          ),
        ),
      ),

    template_argument: $ => choice($.type, $._expr),

    _template_argument_list: $ => commaSep1Comma($.template_argument),

    _template_single_arg: $ =>
      choice(
        $.identifier,
        'void',
        $.primitive_type,
        $.boolean_literal,
        $.character_literal,
        $._string_literal,
        $.integer_literal,
        $.float_literal,
        'null',
        'this',
        $.special_keyword,
      ),

    template_parameter: $ =>
      prec.right(
        choice(
          $._template_type_parameter,
          $._template_value_parameter,
          $._template_alias_parameter,
          $._template_sequence_parameter,
        ),
      ),

    template_parameters: $ =>
      seq('(', optional($._template_parameter_list), ')'),

    _template_parameter_list: $ =>
      prec.right(commaSep1Comma($.template_parameter)),

    _template_type_parameter: $ =>
      prec.right(
        seq(
          optional('this'),
          $.identifier,
          optional(seq(':', $.type)),
          optional(seq('=', $.type)),
        ),
      ),

    _template_value_parameter: $ =>
      prec.right(
        seq(
          $.type,
          $.identifier,
          optional(seq(':', $._expr)),
          optional(seq('=', $._expr)),
        ),
      ),

    _template_sequence_parameter: $ => seq($.identifier, '...'),

    _template_alias_parameter: $ =>
      prec.right(
        seq(
          'alias',
          optional($.type),
          $.identifier,
          optional(seq(':', choice($.type, $._expr))),
          optional(seq('=', choice($.type, $._expr))),
        ),
      ),

    template_constraint: $ => seq('if', '(', $._expression, ')'),

    mixin_template_declaration: $ =>
      seq(repeat($._attribute), 'mixin', $.template_declaration),

    template_mixin: $ =>
      seq(
        repeat($._attribute),
        'mixin',
        optional(seq(optional($.typeof_expression), '.')),
        sep1($._identifier_or_template_instance, '.'),
        optional($.template_arguments),
        optional($.identifier),
        ';',
      ),

    // Conditional Compilation:

    // Note: this syntax with colons is one of the more hare-brained schemes.
    // It makes one want to take the colon and punch someone in the nose with it.
    conditional_declaration: $ =>
      seq(
        repeat($._attribute),
        prec.right(
          choice(
            seq($._static_condition, $._declaration),
            seq(
              $._static_condition,
              $._declaration,
              'else',
              ':',
              repeat($._declaration),
            ),
            seq($._static_condition, $._declaration, 'else', $._declaration),
            seq(
              $._static_condition,
              $._declaration,
              'else',
              '{',
              repeat($._declaration),
              '}',
            ),
            seq($._static_condition, '{', repeat($._declaration), '}'),
            seq(
              $._static_condition,
              '{',
              repeat($._declaration),
              '}',
              'else',
              ':',
              repeat($._declaration),
            ),
            seq(
              $._static_condition,
              '{',
              repeat($._declaration),
              '}',
              'else',
              $._declaration,
            ),
            seq(
              $._static_condition,
              '{',
              repeat($._declaration),
              '}',
              'else',
              '{',
              repeat($._declaration),
              '}',
            ),
            seq($._static_condition, ':', repeat1($._declaration)),
          ),
        ),
      ),

    static_conditional_statement: $ =>
      prec.right(
        seq($._static_condition, $.consequence, optional(seq('else', $.alternative))),
      ),

    _static_condition: $ =>
      choice($.static_version_condition, $.static_debug_condition, $.static_if_condition),

    static_version_condition: $ =>
      prec.left(
        seq(
          'version',
          '(',
          choice($.integer_literal, $.identifier, 'unittest', 'assert'),
          ')',
        ),
      ),

    version_specification: $ =>
      seq('version', '=', choice($.integer_literal, $.identifier), ';'),

    static_debug_condition: $ =>
      prec.right(
        seq(
          'debug',
          optional(seq('(', choice($.integer_literal, $.identifier), ')')),
        ),
      ),

    debug_specification: $ =>
      seq('debug', '=', choice($.integer_literal, $.identifier), ';'),

    static_if_condition: $ => seq('static', 'if', '(', $._expression, ')'),

    static_foreach_statement: $ => seq('static', $.foreach_statement),

    static_foreach_declaration: $ =>
      choice(
        seq(
          'static',
          $._foreach,
          '(',
          commaSep1($.foreach_type),
          ';',
          $._expression,
          ')',
          '{',
          repeat($._declaration),
          '}',
        ),
        seq(
          'static',
          $._foreach,
          '(',
          commaSep1($.foreach_type),
          ';',
          $._expression,
          ')',
          $._declaration,
        ),
        seq(
          'static',
          $._foreach,
          '(',
          $.foreach_type,
          ';',
          $._expression,
          '..',
          $._expression,
          ')',
          '{',
          repeat($._declaration),
          '}',
        ),
        seq(
          'static',
          $._foreach,
          '(',
          $.foreach_type,
          ';',
          $._expression,
          '..',
          $._expression,
          ')',
          $._declaration,
        ),
      ),

    static_assert_statement: $ => seq('static', $.assert_expression, ';'),

    traits_expression: $ =>
      seq(
        '__traits',
        '(',
        $.identifier,
        optional(seq(',', $._traits_argument_list)),
        ')',
      ),

    // adheres to `tree-sitter-cpp`'s `template_argument_list`
    _traits_argument_list: $ => commaSep1Comma($.template_argument),

    unittest_declaration: $ =>
      seq(repeat($._attribute), 'unittest', $.compound_statement),
  },

  // It is unfortunate, but many constructs in D require look-ahead
  // to resolve conflicts.
  conflicts: $ => [
    [$.type_qualifier, $.type_cast_qualifier],
    [$.storage_class, $._attribute],
    [$.parameter_attribute, $.variadic_arguments_attribute],
    [$.parameter_attribute, $.type],
    [$.compound_statement, $.aggregate_initializer],
    [$.storage_class, $.linkage_attribute],
    [$.deprecated_attribute, $.storage_class],
    [$.type_qualifier, $.variadic_arguments_attribute],
    [$._attribute, $.storage_class, $.type],
    [$.foreach_type, $.type],
    [$._specified_function_body],
    [$._statement_no_case_no_default, $._specified_function_body],
    [$._declaration2, $._statement_no_case_no_default],
    [$._declaration_or_statement, $.conditional_declaration],
    [$.storage_class, $.type],
    [$.type_qualifier, $.constructor_declaration, $.destructor_declaration],
    [$.label, $.member_initializer],
    [$.compound_statement, $.conditional_declaration],
    [$.compound_statement, $.static_foreach_declaration],
    [$._declaration_or_statement, $.static_foreach_declaration],
    [$.expression_list, $._expression],
    [$.primary_expression, $.property_expression],
    [$.parameter, $.template_parameter],
    [$._primary_expr, $.constructor_declaration, $.postblit_declaration],
    [$._primary_expr, $.mixin_declaration],
    [$._primary_expr, $.destructor_declaration],
    [$.template_instance, $.template_mixin],
    [$._qualified_id, $._primary_expr],
    [$._type2, $._primary_expr],
    [$._qualified_id, $.template_parameter],
    [$.pragma_declaration, $.compound_statement],
    [$.pragma_declaration, $._declaration_or_statement],
    [$.pragma_declaration, $._declaration2],
    [$.pragma_declaration, $.pragma_statement, $._declaration2],
    [$.alias_reassign, $._primary_expr],
    [$.function_literal, $.parameter_attribute],
    [$.module_declaration, $.storage_class, $._attribute],
    [$.function_body, $._function_contract],
    [$.storage_class, $.function_literal],
    [$.storage_class, $.function_literal, $._attribute],
    [$.storage_class, $.synchronized_statement, $._attribute],
    [$.storage_class, $._type2],
  ],
});

function commaSep1(rule) {
  return seq(rule, repeat(seq(',', rule)));
}

// commaSep1Comma is like commaSep1, but allows for an optional trailing comment
function commaSep1Comma(rule) {
  return seq(rule, repeat(seq(',', rule)), optional(','));
}

function commaSep(rule) {
  return optional(commaSep1(rule));
}

function sep1(rule, delim) {
  return seq(rule, repeat(seq(delim, rule)));
}

function binaryOp(left, op, right) {
  return seq(left, field('operator', op), right);
}
