@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Stock Projection View'
@Metadata.ignorePropagatedAnnotations: true

@UI.headerInfo: {
  typeName: 'Stock',
  typeNamePlural: 'Stock Overview',
  title: {
    type: #STANDARD,
    value: 'ProductName'
  },
  description: {
    value: 'WarehouseName'
  }
}

define root view entity ZC_SPACC110_STOCK
  provider contract transactional_query
  as projection on ZR_SPACC110_STOCK
{
  @UI.facet: [
    {
      id: 'StockDetails',
      purpose: #STANDARD,
      type: #IDENTIFICATION_REFERENCE,
      label: 'Stock Details',
      position: 10
    }
  ]

  @EndUserText.label: 'Warehouse'
  @UI.lineItem: [{ position: 10 }]
  @UI.identification: [{ position: 10 }]
  @Consumption.valueHelpDefinition: [{
    entity: {
      name: 'ZI_SPACC110_WAREHOUSE_VH',
      element: 'WarehouseId'
    },
    useForValidation: true
  }]
  key warehouse_id,

  @EndUserText.label: 'Product'
  @UI.lineItem: [{ position: 20 }]
  @UI.identification: [{ position: 20 }]
  @Consumption.valueHelpDefinition: [{
    entity: {
      name: 'ZI_SPACC110_PRODUCT_VH',
      element: 'ProductId'
    },
    useForValidation: true
  }]
  key product_id,

  @EndUserText.label: 'Product Name'
  @UI.lineItem: [{ position: 30 }]
  @UI.identification: [{ position: 30 }]
  _Product.product_name as ProductName,

  @EndUserText.label: 'Description'
  @UI.lineItem: [{ position: 40 }]
  _Product.product_description as ProductDescription,

  @EndUserText.label: 'Category'
  @UI.lineItem: [{ position: 50 }]
  _Product.category as ProductCategory,

  @EndUserText.label: 'Warehouse'
  @UI.lineItem: [{ position: 60 }]
  @UI.identification: [{ position: 40 }]
  _Warehouse.warehouse_name as WarehouseName,

  @EndUserText.label: 'City'
  @UI.lineItem: [{ position: 70 }]
  @UI.identification: [{ position: 50 }]
  _Warehouse.city as WarehouseCity,

  @EndUserText.label: 'Address'
  @UI.lineItem: [{ position: 80 }]
  _Warehouse.street_address as WarehouseAddress,

  @EndUserText.label: 'Postal Code'
  @UI.lineItem: [{ position: 90 }]
  _Warehouse.postal_code as PostalCode,

  @EndUserText.label: 'Stock Amount'
  @UI.lineItem: [{ position: 100 }]
  @UI.identification: [{ position: 60 }]
  amount,

  @UI.hidden: true
  LocalCreatedBy,

  @UI.hidden: true
  LocalCreatedAt,

  @UI.hidden: true
  LocalLastChangedBy,

  @UI.hidden: true
  LocalLastChangedAt,

  @UI.hidden: true
  LastChangedAt,

  _Product,
  _Warehouse
}
