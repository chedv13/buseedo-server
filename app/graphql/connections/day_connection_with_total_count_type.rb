Connections::PostConnectionWithTotalCountType = PostType.define_connection do
  name "PostConnectionWithTotalCount"
  field :totalCount do
    type types.Int
    resolve ->(obj, args, ctx) { obj.nodes.size }
  end
end