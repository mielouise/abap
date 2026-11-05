@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Stock Projection View'
@Metadata.ignorePropagatedAnnotations: true

define root view entity ZC_SPACC110_STOCK
  provider contract transactional_query
  as projection on ZR_SPACC110_STOCK
{
  @UI.lineItem: [{ position: 10 }]
  key warehouse_id,

  @UI.lineItem: [{ position: 20 }]
  key product_id,

  @UI.lineItem: [{ position: 30 }]
  amount
}
