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

  @EndUserText.label: 'Product Name'
  @UI.lineItem: [{ position: 30 }]
  _Product.product_name as ProductName,

  @EndUserText.label: 'Description'
  @UI.lineItem: [{ position: 40 }]
  _Product.product_description as ProductDescription,

  @EndUserText.label: 'Category'
  @UI.lineItem: [{ position: 50 }]
  _Product.category as ProductCategory,

  @EndUserText.label: 'Warehouse'
  @UI.lineItem: [{ position: 60 }]
  _Warehouse.warehouse_name as WarehouseName,

  @EndUserText.label: 'City'
  @UI.lineItem: [{ position: 70 }]
  _Warehouse.city as WarehouseCity,

  @EndUserText.label: 'Address'
  @UI.lineItem: [{ position: 80 }]
  _Warehouse.street_address as WarehouseAddress,

  @EndUserText.label: 'Postal Code'
  @UI.lineItem: [{ position: 90 }]
  _Warehouse.postal_code as PostalCode,

  @EndUserText.label: 'Stock Amount'
  @UI.lineItem: [{ position: 100 }]
  amount,

  _Product,
  _Warehouse
}
