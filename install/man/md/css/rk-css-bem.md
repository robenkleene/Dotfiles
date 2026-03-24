# Goals

BEM helps with specificity problems, e.g., if someone says `.nav a` means "select all links inside `nav`", but what they really wanted was "select all `nav` menu links (and nothing else)". A class like `nav__link` will never select other links that happen to be inside `nav`. BEM also survives markup restructuring, e.g., a selector like `.nav > ul > li > a` will not work if that structure changes.

# Notes

- **Block**: A standalone entity (`.block`).
- **Element**: Something that is only ever nested inside a block (`.block__elem`).
- **Modifier**: Types of blocks or elements (`.block--mod` or `.block__elem--mod`).

# Rules

- Never nest CSS rules
- You should apply a reset to the element you are styling.
- Avoid tag selectors

# Resets

BEM does not recommend CSS resets because it break independence. If the reset is not applied, then the style will not look right, therefore the styles are not independent.
