CLASS zcl_spacc110_product_loader DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

ENDCLASS.


CLASS zcl_spacc110_product_loader IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA products TYPE TABLE OF zspacc110_produc.

    products = VALUE #(
      ( product_id = 1
        product_name = 'Wireless Mouse'
        product_description = 'Ergonomic wireless computer mouse'
        category = 'Accessories' )

      ( product_id = 2
        product_name = 'Mechanical Keyboard'
        product_description = 'Mechanical keyboard with RGB lighting'
        category = 'Accessories' )

      ( product_id = 3
        product_name = 'USB-C Hub'
        product_description = 'Multiport USB-C adapter'
        category = 'Accessories' )

      ( product_id = 4
        product_name = 'Monitor 27 Inch'
        product_description = '27-inch Full HD computer monitor'
        category = 'Displays' )

      ( product_id = 5
        product_name = 'Laptop Stand'
        product_description = 'Adjustable aluminium laptop stand'
        category = 'Accessories' )
    ).

    MODIFY zspacc110_produc FROM TABLE @products.

    out->write(
      |Processed { sy-dbcnt } product entries.|
    ).

  ENDMETHOD.

ENDCLASS.

