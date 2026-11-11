@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Warehouse Projection View'
@Metadata.ignorePropagatedAnnotations: true

@UI.headerInfo: {
  typeName: 'Warehouse',
  typeNamePlural: 'Warehouses',
  title: {
    type: #STANDARD,
    value: 'WarehouseName'
  },
  description: {
    value: 'City'
  }
}

define root view entity ZC_SPACC110_WAREHOUSE
  provider contract transactional_query
  as projection on ZR_SPACC110_WAREHOUSE
{
  @UI.facet: [{
    id: 'WarehouseDetails',
    purpose: #STANDARD,
    type: #IDENTIFICATION_REFERENCE,
    label: 'Warehouse Details',
    position: 10
  }]

  @EndUserText.label: 'Warehouse ID'
  @UI.lineItem: [{ position: 10 }]
  @UI.identification: [{ position: 10 }]
  key WarehouseId,

  @EndUserText.label: 'Warehouse Name'
  @UI.lineItem: [{ position: 20 }]
  @UI.identification: [{ position: 20 }]
  WarehouseName,

  @EndUserText.label: 'Street Address'
  @UI.lineItem: [{ position: 30 }]
  @UI.identification: [{ position: 30 }]
  StreetAddress,

  @EndUserText.label: 'City'
  @UI.lineItem: [{ position: 40 }]
  @UI.identification: [{ position: 40 }]
  City,

  @EndUserText.label: 'Postal Code'
  @UI.lineItem: [{ position: 50 }]
  @UI.identification: [{ position: 50 }]
  PostalCode,

  @UI.hidden: true
  LocalCreatedBy,

  @UI.hidden: true
  LocalCreatedAt,

  @UI.hidden: true
  LocalLastChangedBy,

  @UI.hidden: true
  LocalLastChangedAt,

  @UI.hidden: true
  LastChangedAt
}
