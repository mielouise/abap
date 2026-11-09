CLASS zcl_sp110_create_nr DEFINITION
  PUBLIC FINAL CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

ENDCLASS.

CLASS zcl_sp110_create_nr IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    "Find the highest existing product ID
    SELECT SINGLE
      FROM zspacc110_produc
      FIELDS MAX( product_id )
      INTO @DATA(lv_max_id).

    out->write(
      |Highest existing Product ID: { lv_max_id }|
    ).

    "Prepare number range interval 01
    DATA lt_intervals
      TYPE cl_numberrange_intervals=>nr_interval.

    DATA ls_interval
      TYPE cl_numberrange_intervals=>nr_nriv_line.

    ls_interval-nrrangenr  = '01'.
    ls_interval-fromnumber = '0000000001'.
    ls_interval-tonumber   = '2147483647'.
    ls_interval-nrlevel    = lv_max_id.
    ls_interval-procind    = 'I'.
    ls_interval-externind  = space.

    APPEND ls_interval TO lt_intervals.

    "Create the interval
    TRY.

        cl_numberrange_intervals=>create(
          EXPORTING
            object    = 'ZSP110PRD'
            subobject = space
            interval  = lt_intervals
          IMPORTING
            error     = DATA(lv_error)
            error_inf = DATA(ls_error)
            error_iv  = DATA(lt_error_iv)
            warning   = DATA(lv_warning)
        ).

        IF lv_error IS INITIAL.

          out->write(
            'Interval 01 created successfully.'
          ).

          out->write(
            |Initial number status: { ls_interval-nrlevel }|
          ).

        ELSE.

          out->write(
            'Interval creation failed.'
          ).

          out->write(
            |Error number: { ls_error-msgnr }|
          ).

          out->write(
            |Error field: { ls_error-fieldname }|
          ).

        ENDIF.

      CATCH cx_root INTO DATA(lx_error).

        out->write( lx_error->get_text( ) ).

    ENDTRY.

  ENDMETHOD.

ENDCLASS.
