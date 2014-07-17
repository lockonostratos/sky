#Sky.factory 'Product', ($resource)-> $resource 'api/products/:id', {id: '@id'}, {update: {method: 'PUT'}}

#Sky.factory "Product", ($resource) ->
#  $resource "/api/products/:id", { id: "@id" },
#    'create': { method: 'POST' }
#    'index': { method: 'GET', isArray: true }
#    'show': { method: 'GET', isArray: false }
#    'update': { method: 'PUT' }
#    'destroy': { method: 'DELETE' }

Sky.factory 'Product', [ 'railsResourceFactory', (railsResourceFactory) ->
  railsResourceFactory { url: 'api/products', name: 'product' }
]

Sky.factory 'ProductSummary', [ 'railsResourceFactory', (railsResourceFactory) ->
  railsResourceFactory { url: 'api/product_summaries', name: 'product_summary' }
]