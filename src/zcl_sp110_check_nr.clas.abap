CLASS zcl_sp110_check_nr DEFINITION
  PUBLIC FINAL CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
ENDCLASS.

CLASS zcl_sp110_check_nr IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    TRY.
        cl_numberrange_runtime=>number_status(
          EXPORTING
            nr_range_nr = '01'
            object      = 'ZSP110PRD'
          IMPORTING
            number      = DATA(lv_status)
        ).

        out->write(
          |Current Number Range Status: { lv_status }|
        ).

      CATCH cx_number_ranges INTO DATA(lx_error).
        out->write( lx_error->get_text( ) ).
    ENDTRY.

  ENDMETHOD.

ENDCLASS.

