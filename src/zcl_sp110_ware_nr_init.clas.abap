CLASS zcl_sp110_ware_nr_init DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

ENDCLASS.


CLASS zcl_sp110_ware_nr_init IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    " Kontrollér eksisterende Warehouse ID'er
    SELECT FROM zspacc110_ware
      FIELDS MAX( warehouse_id )
      INTO @DATA(lv_max_id).

    out->write(
      |Highest Warehouse ID: { lv_max_id }|
    ).

    " Stop hvis data er ændret siden kontrollen
    IF lv_max_id <> 3.
      out->write(
        'Warehouse IDs have changed. Interval not created.'
      ).
      RETURN.
    ENDIF.

    " Definér nummerinterval 01
    DATA lt_intervals
      TYPE cl_numberrange_intervals=>nr_interval.

    APPEND VALUE #(
      nrrangenr  = '01'
      fromnumber = '0000000001'
      tonumber   = '2147483647'
      nrlevel    = '0000000003'
      externind  = space
      procind    = 'I'
    ) TO lt_intervals.

    " Opret nummerintervallet
    TRY.

        cl_numberrange_intervals=>create(
          EXPORTING
            object    = 'ZSP110WAR'
            subobject = space
            interval  = lt_intervals

          IMPORTING
            error     = DATA(lv_error)
            error_inf = DATA(ls_error)
            error_iv  = DATA(lt_error_intervals)
            warning   = DATA(lv_warning)
        ).

        IF lv_error = abap_true.

          out->write(
            |Interval creation failed. Message number: { ls_error-msgnr }|
          ).

        ELSE.

          out->write(
            'Warehouse number range interval 01 created.'
          ).

          out->write(
            'Initial number status: 3'
          ).

          IF lv_warning = abap_true.
            out->write(
              'SAP returned a warning. Check interval configuration.'
            ).
          ENDIF.

        ENDIF.

      CATCH cx_number_ranges INTO DATA(lx_error).

        out->write(
          lx_error->get_text( )
        ).

    ENDTRY.

  ENDMETHOD.

ENDCLASS.
