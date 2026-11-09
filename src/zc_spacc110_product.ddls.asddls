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

  @UI.lineItem: [{ position: 10 }]
  @UI.identification: [{ position: 10 }]
  key ProductId,

  @UI.lineItem: [{ position: 20 }]
  @UI.identification: [{ position: 20 }]
  ProductName,

  @UI.lineItem: [{ position: 30 }]
  @UI.identification: [{ position: 30 }]
  ProductDescription,

  @UI.lineItem: [{ position: 40 }]
  @UI.identification: [{ position: 40 }]
  Category,

  LocalCreatedBy,
  LocalCreatedAt,
  LocalLastChangedBy,
  LocalLastChangedAt,
  LastChangedAt
}
