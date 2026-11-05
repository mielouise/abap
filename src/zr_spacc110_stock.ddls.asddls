@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Stock Data Definition'
@Metadata.ignorePropagatedAnnotations: true

define root view entity ZR_SPACC110_STOCK
  as select from zspacc110_stock
{
  key warehouse_id,
  key product_id,
      amount
}
