@EndUserText.label: 'Product Value Help'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Search.searchable: true

define view entity ZI_SPACC110_PRODUCT_VH
  as select from zspacc110_produc
{
  @EndUserText.label: 'Product ID'
  @UI.lineItem: [{ position: 10 }]
  key product_id as ProductId,

  @EndUserText.label: 'Product Name'
  @Search.defaultSearchElement: true
  @UI.lineItem: [{ position: 20 }]
  product_name as ProductName,

  @EndUserText.label: 'Category'
  @UI.lineItem: [{ position: 30 }]
  category as Category
}
