GatsbyJS is a static web page framework where the content is in a GraphQL store which is accessed at render time.

# Components

- Use the `<Link>` component instead of anchor tags (`<a>`), because the `<Link>` component performs intelligent caching, and the links active state can be tracked when the current page is the linked to page.

# Commands

- `gatsby develop`: Run development server:
- `gatsby build`: Creates the site in `public`
- `gatsby serve`: Run a web server that serves the site from `public` (to test the result of compilation)
