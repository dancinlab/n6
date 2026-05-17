/**
 * tree-sitter grammar for .n6 (knowledge-atlas grammar, v1).
 *
 * Total line model, no external scanner, no regex look-around. Every
 * line token requires a trailing newline → the top-level repeat always
 * progresses (no parser hang). .n6 files are LF-terminated by spec.
 * Exposes `type` + `edge_op` for queries/highlights.scm; quoted prose,
 * `key = expr` continuations and CJK fall through to `body` / `text`.
 */
module.exports = grammar({
  name: 'n6',

  extras: $ => [],

  rules: {
    source_file: $ => repeat($._line),

    _line: $ => choice(
      $.blank,
      $.comment,
      $.header,
      $.edge,
      $.body,
      $.text,
    ),

    blank: $ => token(prec(1, /[ \t]*\n/)),

    comment: $ => token(prec(5, /[ \t]*#[^\n]*\n/)),

    header: $ => seq($.type, $._rest),

    type: $ => token(prec(4, /@[A-Z?]/)),

    edge: $ => seq($._indent, $.edge_op, $._rest),

    body: $ => seq($._indent, $._rest),

    _indent: $ => token(prec(3, /[ \t]+/)),

    // .n6 v1 edge alphabet (7): depends/derives/application/equivalent/
    // converges/verified/breakthrough
    edge_op: $ => token(prec(4, choice(
      '<-', '->', '=>', '==', '~>', '|>', '!!',
    ))),

    _rest: $ => token(prec(1, /[^\n]*\n/)),

    text: $ => token(prec(0, /[^ \t#@\n][^\n]*\n/)),
  },
});
