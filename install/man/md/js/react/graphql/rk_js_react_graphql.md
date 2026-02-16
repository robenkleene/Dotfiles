# Query

An example of querying for the site metadata description:

```
export const query = graphql`
query HomePageQuery {
    site {
        siteMetadata {
            description
        }
    }
}
`
```

An example retrieving a specific item:

```
query AboutQuery {
  allMarkdownRemark(filter: { frontmatter: { title: { eq: "About" } } }) {
    nodes {
      html
    }
  }
}
```

# Components

An example of accessing data in a component:

```
const HomePage = () => {
const HomePage = ({data}) => {
    return (
        <div>
        Hello!
        {data.site.siteMetadata.description}
        </div>
    )
}
```

`set.siteMetadata.description` is exactly where the data is in the hierarchy in the GraphiQL browser.

Accessing data in a component from an array:

```
const IndexPage = ({ data }) => (
  <Layout>
    <div dangerouslySetInnerHTML={{ __html: data.allMarkdownRemark.nodes[0].html }} />
  </Layout>
)
```

