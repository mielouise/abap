@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Product Projection View'
@Metadata.ignorePropagatedAnnotations: true

@UI.headerInfo: {
  typeName: 'Product',
  typeNamePlural: 'Products',
  title: {
    type: #STANDARD,
    value: 'ProductName'
  }
}

define root view entity ZC_SPACC110_PRODUCT
  provider contract transactional_query
  as projection on ZR_SPACC110_PRODUCT
{
  @UI.facet: [
    {
      id: 'ProductDetails',
      purpose: #STANDARD,
      type: #IDENTIFICATION_REFERENCE,
      label: 'Product Details',
      position: 10
    }
  ]

  @EndUserText.label: 'Product ID'
  @UI.lineItem: [{ position: 10 }]
  @UI.identification: [{ position: 10 }]
  key ProductId,

  @EndUserText.label: 'Product Name'
  @UI.lineItem: [{ position: 20 }]
  @UI.identification: [{ position: 20 }]
  ProductName,

  @EndUserText.label: 'Description'
  @UI.lineItem: [{ position: 30 }]
  @UI.identification: [{ position: 30 }]
  ProductDescription,

  @EndUserText.label: 'Category'
  @UI.lineItem: [{ position: 40 }]
  @UI.identification: [{ position: 40 }]
  Category,

  LocalCreatedBy,
  LocalCreatedAt,
  LocalLastChangedBy,
  LocalLastChangedAt,
  LastChangedAt
}
