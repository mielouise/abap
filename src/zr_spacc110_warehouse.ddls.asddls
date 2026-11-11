@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Warehouse Root View'
@Metadata.ignorePropagatedAnnotations: true

define root view entity ZR_SPACC110_WAREHOUSE
  as select from zspacc110_ware as Warehouse
{
  key Warehouse.warehouse_id as WarehouseId,

      Warehouse.warehouse_name as WarehouseName,
      Warehouse.street_address as StreetAddress,
      Warehouse.city as City,
      Warehouse.postal_code as PostalCode,

      @Semantics.user.createdBy: true
      Warehouse.local_created_by as LocalCreatedBy,

      @Semantics.systemDateTime.createdAt: true
      Warehouse.local_created_at as LocalCreatedAt,

      @Semantics.user.lastChangedBy: true
      Warehouse.local_last_changed_by as LocalLastChangedBy,

      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      Warehouse.local_last_changed_at as LocalLastChangedAt,

      @Semantics.systemDateTime.lastChangedAt: true
      Warehouse.last_changed_at as LastChangedAt
}
