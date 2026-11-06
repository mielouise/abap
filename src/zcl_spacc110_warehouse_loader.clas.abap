CLASS zcl_spacc110_warehouse_loader DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

ENDCLASS.


CLASS zcl_spacc110_warehouse_loader IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA warehouses TYPE TABLE OF zspacc110_ware.

    warehouses = VALUE #(
      ( warehouse_id = 1
        warehouse_name = 'Aalborg Warehouse'
        street_address = 'Hadsundvej 45'
        city = 'Aalborg'
        postal_code = '9000' )

      ( warehouse_id = 2
        warehouse_name = 'Aarhus Warehouse'
        street_address = 'Randersvej 120'
        city = 'Aarhus N'
        postal_code = '8200' )

      ( warehouse_id = 3
        warehouse_name = 'Esbjerg Warehouse'
        street_address = 'Stormgade 50'
        city = 'Esbjerg'
        postal_code = '6700' )
    ).

    MODIFY zspacc110_ware FROM TABLE @warehouses.

    out->write(
      |Processed { sy-dbcnt } warehouse entries.|
    ).

  ENDMETHOD.

ENDCLASS.

