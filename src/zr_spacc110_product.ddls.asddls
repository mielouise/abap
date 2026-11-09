@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Product Root View'
@Metadata.ignorePropagatedAnnotations: true

define root view entity ZR_SPACC110_PRODUCT
  as select from zspacc110_produc as Product
{
  key Product.product_id as ProductId,

      Product.product_name as ProductName,

      Product.product_description as ProductDescription,

      Product.category as Category,

      @Semantics.user.createdBy: true
      Product.local_created_by as LocalCreatedBy,

      @Semantics.systemDateTime.createdAt: true
      Product.local_created_at as LocalCreatedAt,

      @Semantics.user.lastChangedBy: true
      Product.local_last_changed_by as LocalLastChangedBy,

      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      Product.local_last_changed_at as LocalLastChangedAt,

      @Semantics.systemDateTime.lastChangedAt: true
      Product.last_changed_at as LastChangedAt
}
