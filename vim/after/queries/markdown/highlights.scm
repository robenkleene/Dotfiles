;; extends

; Capture header markers separately from the header text, so they can use the
; `Comment` color like list markers
[
  (atx_h1_marker)
  (atx_h2_marker)
  (atx_h3_marker)
  (atx_h4_marker)
  (atx_h5_marker)
  (atx_h6_marker)
] @markup.heading.marker

; Capture code fence backticks separately from the code, so they can use the
; `Comment` color like other punctuation
(fenced_code_block_delimiter) @punctuation.delimiter
