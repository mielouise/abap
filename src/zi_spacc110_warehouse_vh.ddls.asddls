@EndUserText.label: 'Warehouse Value Help'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Search.searchable: true

define view entity ZI_SPACC110_WAREHOUSE_VH
  as select from zspacc110_ware
{
  @EndUserText.label: 'Warehouse ID'
  @UI.lineItem: [{ position: 10 }]
  key warehouse_id as WarehouseId,

  @EndUserText.label: 'Warehouse'
  @Search.defaultSearchElement: true
  @UI.lineItem: [{ position: 20 }]
  warehouse_name as WarehouseName,

  @EndUserText.label: 'City'
  @Search.defaultSearchElement: true
  @UI.lineItem: [{ position: 30 }]
  city as City,

  @EndUserText.label: 'Address'
  @UI.lineItem: [{ position: 40 }]
  street_address as StreetAddress
}
