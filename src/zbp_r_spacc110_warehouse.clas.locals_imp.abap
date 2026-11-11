CLASS lsc_ZR_SPACC110_WAREHOUSE DEFINITION
  INHERITING FROM cl_abap_behavior_saver.

  PROTECTED SECTION.

    METHODS adjust_numbers REDEFINITION.

ENDCLASS.


CLASS lsc_ZR_SPACC110_WAREHOUSE IMPLEMENTATION.

  METHOD adjust_numbers.

    " Gennemgå nye lagre
    LOOP AT mapped-Warehouse
      ASSIGNING FIELD-SYMBOL(<warehouse>).

      " Hent næste Warehouse ID
      TRY.

          cl_numberrange_runtime=>number_get(
            EXPORTING
              nr_range_nr = '01'
              object      = 'ZSP110WAR'
              quantity    = 1

            IMPORTING
              number            = DATA(lv_number)
              returncode        = DATA(lv_returncode)
              returned_quantity = DATA(lv_quantity)
          ).

        CATCH cx_number_ranges INTO DATA(lx_error).

          " Kritisk fejl under save-sekvensen
          RAISE SHORTDUMP lx_error.

      ENDTRY.

      " Kontrollér at nummeret blev returneret
      ASSERT lv_quantity = 1.
      ASSERT lv_number IS NOT INITIAL.

      " Kræv en normal returstatus
      ASSERT lv_returncode = space.

      " Kontrollér grænsen for INT4
      ASSERT CONV decfloat34( lv_number )
             <= 2147483647.

      " Tildel det endelige Warehouse ID
      <warehouse>-%key-WarehouseId =
        CONV i( lv_number ).

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
