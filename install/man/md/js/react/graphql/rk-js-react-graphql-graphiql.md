GraphiQL is a GraphQL IDE. To access it in your Gatsby project:

1. Start the development server if it's not already running (`gatsby develop`).
2. Visit `http://localhost:8000/___graphql` in a browser

# Tips

- Hover a field to see it's parameters, and click for more details in the sidebar

# Explorer

You can explore the data in GraphQL by using the sidebar. For example, if you've added Markdown with `gatsby-transformer-remark` then that data will appear under `markdownRemark`. E.g., to see the compiled HTML by clicking the "`markdownRemark` > `html`" checkbox (ignore the `html:` with a disclosure triangle), and then running the resulting query:

    query MyQuery {
        markdownRemark {
            html
        }
    }

## Data

For each entry in the graph, there's two entries, e.g.:

- `allMarkdownReact`
- `markdownReact`

The first entry is how you access all of the data.

### Queries

You can construct complex queries by clicking in the sidebar, for example to fetch the `allMarkdownRemark` item that has the `frontmatter` `title` `"about"`:

1. Click open `allMarkdownRemark`
2. Click `filter`
3. Click `frontmatter`
4. Click `title`
5. Click `eq:` and enter `"About"`

This constructs a query like this:

    query MyQuery {
      allMarkdownRemark(filter: {frontmatter: {title: {eq: "About"}}}) {
        edges {
          node {
            id
          }
        }
      }
    }
