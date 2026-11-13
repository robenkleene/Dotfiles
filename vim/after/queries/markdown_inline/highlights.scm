;; extends

; Capture inline punctuation (e.g., backticks, emphasis markers, link brackets)
; separately from the text it delimits, so it can use the `Comment` color
[
  (code_span_delimiter)
  (emphasis_delimiter)
] @punctuation.delimiter

(inline_link
  [
    "["
    "]"
    "("
    ")"
  ] @punctuation.delimiter)

(image
  [
    "!"
    "["
    "]"
    "("
    ")"
  ] @punctuation.delimiter)

(full_reference_link
  [
    "["
    "]"
  ] @punctuation.delimiter)

(collapsed_reference_link
  [
    "["
    "]"
  ] @punctuation.delimiter)

(shortcut_link
  [
    "["
    "]"
  ] @punctuation.delimiter)
