CLASS lhc_Warehouse DEFINITION
  INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS earlynumbering_create FOR NUMBERING
      IMPORTING entities FOR CREATE Warehouse.

ENDCLASS.


CLASS lhc_Warehouse IMPLEMENTATION.

  METHOD earlynumbering_create.

    " Automatisk WarehouseId tilføjes her

  ENDMETHOD.

ENDCLASS.
