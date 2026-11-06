
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Stock Data Definition'
@Metadata.ignorePropagatedAnnotations: true

define root view entity ZR_SPACC110_STOCK
  as select from zspacc110_stock as Stock

  association [0..1] to zspacc110_produc
    as _Product
    on $projection.product_id = _Product.product_id

  association [0..1] to zspacc110_ware
    as _Warehouse
    on $projection.warehouse_id = _Warehouse.warehouse_id

{
  key Stock.warehouse_id,
  key Stock.product_id,
      Stock.amount,

      _Product,
      _Warehouse
}
