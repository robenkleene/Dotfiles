;; extends

; Capture header markers separately from the header text, so they can use the
; `Delimiter` color like other punctuation
[
  (atx_h1_marker)
  (atx_h2_marker)
  (atx_h3_marker)
  (atx_h4_marker)
  (atx_h5_marker)
  (atx_h6_marker)
] @markup.heading.marker

; Capture code fence backticks separately from the code, so they can use the
; `Delimiter` color like other punctuation
(fenced_code_block_delimiter) @punctuation.delimiter

; Capture rules and block quote markers, which are otherwise
; `@punctuation.special`, so they can use the `Comment` color like list
; markers. `block_continuation` holds the `>` on every block quote line after
; the first.
(thematic_break) @markup.rule

[
  (block_continuation)
  (block_quote_marker)
] @markup.quote.marker
