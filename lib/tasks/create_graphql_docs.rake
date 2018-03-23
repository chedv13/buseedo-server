task :create_graphql_docs => :environment do
  GraphQLDocs.build(schema: BuseedoSchema.to_definition, output_dir: 'app/views/docs/graphql', base_url: '/docs/graphql', pipeline_config: {
    pipeline: %i(EmojiFilter TableOfContentsFilter),
    context: {
      gfm: false,
      asset_root: 'https://a248.e.akamai.net/assets.github.com/images/icons'
    }
  })
end
