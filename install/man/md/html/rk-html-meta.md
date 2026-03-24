A minimal set of data for sharing:

``` html
    <meta name="description" content="A website in one part." />
    <meta property="og:description" content="A website in one part." />
    <meta property="og:title" content="Roben Kleene" />
    <meta
      property="og:image"
      content="https://robenkleene.com/assets/img/robenkleene.png"
    />
    <meta name="twitter:card" content="summary" />
    <meta
      property="twitter:image"
      content="https://robenkleene.com/assets/img/robenkleene.png"
    />
```

Twitter won't do descriptions without `og:description` and won't do cards at all without `twitter:card`, and won't do titles without `og:title`.
