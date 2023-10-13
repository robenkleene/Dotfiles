# `pandoc`

## HTML to Markdown

From a pipe:

	pandoc -f html -t markdown

From a file:

	pandoc testfile.html -o test.md --parse-raw

## Rich Text to Markdown

    cat convert.rtf | pandoc -f rtf -t markdown

## Markdown to Org

	pandoc -f markdown -t org

## Vim

    %w !pandoc -f markdown -o ~/Temp/exports/export.docx
