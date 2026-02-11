# CSS Tailwind

## Goals

Why utility classes instead of inline CSS? With inline CSS there's no constraints on what values you choose. With utility classes "You can't just pick any value want; you have to choose from a curated list.

Instead of 380 text colors, you end up with 10 or 12."

## CLI

- `npx tailwind init tailwind-full.confg`: Export a full Tailwind config

## Basics

### General

- `sm`: Small
- `md`: Medium
- `lg`: Large
- `xl`: Extra Large
- `p`: Padding
- `max-w`: Max width
- `x`: Horizontal
- `y`: Vertical
- `t`: Top
- `b`: Bottom
- `l`: Left
- `r`: Right

### Text

- `text-sm`: Smaller font size
- `text-2xl`: Large font
- `font-bold`: Bold
- `font-semibold`: Semibold
- `leading-none`: Tight line height
- `leading-loose`: Tallest leading
- `uppercase`: Uppercase
- `tracking-wider`: Wider letter spacing

#### Colors

- `text-indigo-500`: An indigo

### Layout

- `max-w-md`: Set a width
- `inline-block`: Inline block

### Size

- `h` (e.g., `h-10`): Height

### Padding

- `p` (e.g., `p-8`): Padding
- `px` (e.g., `px-8`): Horizontal padding
- `py` (e.g., `py-12`): Vertical padding

### Margins

- `mx-auto`: Set margins to auto
- `mt` (e.g., `mt-6`): Top margin

### Border

- `rounded`: Rounded corners
- `rounded-sm`: Small rounded corners
- `rounded-lg`: Large rounded corners

### Effects

- `shadow`: Shadow
- `shadow-lg`: Large shadow

## Responsive

Just add one of the size prefixes (`sm`, `md`, `lg`, `xl`) to a style to only apply it at that size:

    sm:bg-green-500

This adds a minimum width breakpoint for small sizes.

## Starting New Project

1. In a new directory, e.g., `my-tailwind-project`, run `npm init -y` to create a basic `package.json`
2. Install Tailwind with `npm install postcss-cli autoprefixer`
3. Run `npx tailwind init`, this creates an empty `tailwind.config.js`
4. Edit a new file at the root of the project called `postcss.config.js`, and add the following as its contents:

        module.exports = {
            plugins: [
                require('tailwindcss'),
                require('autoprefixer'),
            ]
        }

5. Create a new file at `css/tailwind.css`, add the following contents:

        @tailwind base;
        @tailwind components;
        @tailwind utilities;

6. Change the default `test` `scripts` entry in `package.json` to the following `build` entry:

        "build": "postcss css/tailwind.css -o public/build/tailwind.css"

7. Run `npm run build`
8. Edit a new HTML file at `public/index.html`, use a basic HTML template and add the following in the `<head>`:

        <link rel="stylesheet" href="/build/tailwind.css">

    And the following in the `<body>`:

        <h1>Hello World!</h1>  

9. Run a simple server from the public directory, e.g., `ruby -run -e httpd public -p 8000` and view the un-styled site at `localhost:8000`.
10. Try adding some utility classes by changing the `<H1>` line to:

        <h1 class="text-4xl font-bold text-center text-blue-500">Hello World!</h1>
