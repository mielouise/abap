CLASS lhc_Product DEFINITION
  INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS validateProductName
      FOR VALIDATE ON SAVE
      IMPORTING keys FOR Product~validateProductName.

ENDCLASS.


CLASS lhc_Product IMPLEMENTATION.

  METHOD validateProductName.

    " Læs produkternes navne
    READ ENTITIES OF ZR_SPACC110_PRODUCT
      IN LOCAL MODE
      ENTITY Product
      FIELDS ( ProductName )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_products).

    LOOP AT lt_products ASSIGNING FIELD-SYMBOL(<product>).

      " Ryd tidligere fejlmeddelelse
      APPEND VALUE #(
        %tky        = <product>-%tky
        %state_area = 'VALIDATE_PRODUCT_NAME'
      ) TO reported-Product.

      " Kontrollér om navnet kun indeholder mellemrum
      DATA(lv_name) = <product>-ProductName.
      CONDENSE lv_name NO-GAPS.

      IF lv_name IS INITIAL.

        " Afvis gemning
        APPEND VALUE #(
          %tky = <product>-%tky
        ) TO failed-Product.

        " Vis fejl i Fiori
        APPEND VALUE #(
          %tky        = <product>-%tky
          %state_area = 'VALIDATE_PRODUCT_NAME'
          %msg = new_message_with_text(
            severity = if_abap_behv_message=>severity-error
            text = 'Product name cannot be empty or contain only spaces.'
          )
          %element-ProductName = if_abap_behv=>mk-on
        ) TO reported-Product.

      ENDIF.

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.


CLASS lsc_zr_spacc110_product DEFINITION
  INHERITING FROM cl_abap_behavior_saver.

  PROTECTED SECTION.

    METHODS adjust_numbers REDEFINITION.

ENDCLASS.


CLASS lsc_zr_spacc110_product IMPLEMENTATION.

  METHOD adjust_numbers.

    " Gennemgå nye produkter
    LOOP AT mapped-Product
      ASSIGNING FIELD-SYMBOL(<product>).

      TRY.

          " Hent næste Product ID
          cl_numberrange_runtime=>number_get(
            EXPORTING
              nr_range_nr = '01'
              object      = 'ZSP110PRD'
              quantity    = 1
            IMPORTING
              number            = DATA(lv_number)
              returncode        = DATA(lv_returncode)
              returned_quantity = DATA(lv_quantity)
          ).

        CATCH cx_number_ranges INTO DATA(lx_error).

          " Kritisk fejl under RAP save-sekvensen
          RAISE SHORTDUMP lx_error.

      ENDTRY.

      " Kontrollér resultatet
      ASSERT lv_quantity = 1.
      ASSERT lv_number IS NOT INITIAL.

      ASSERT lv_returncode <> '2'
         AND lv_returncode <> '3'.

      ASSERT CONV decfloat34( lv_number ) > 0.
      ASSERT CONV decfloat34( lv_number ) <= 2147483647.

      " Tildel endeligt Product ID
      <product>-%key-ProductId = CONV i( lv_number ).

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
