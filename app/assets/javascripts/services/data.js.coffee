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
  railsResourceFactory { url: 'api/product_summaries', name: 'productSummaries' }
]

Sky.factory 'Order', [ 'railsResourceFactory', (railsResourceFactory) ->
  railsResourceFactory { url: 'api/orders', name: 'order' }
]

Sky.factory 'Account', [ 'railsResourceFactory', (railsResourceFactory) ->
  railsResourceFactory { url: 'api/orders', name: 'account' }
]

Sky.factory 'MerchantAccount', [ 'railsResourceFactory', (railsResourceFactory) ->
  railsResourceFactory { url: 'api/merchant_accounts', name: 'merchant_account' }
]