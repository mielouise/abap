CLASS lhc_product DEFINITION
  INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS earlynumbering_create FOR NUMBERING
      IMPORTING entities FOR CREATE Product.

ENDCLASS.


CLASS lhc_product IMPLEMENTATION.

  METHOD earlynumbering_create.

    DATA:
      entity     TYPE STRUCTURE FOR CREATE ZR_SPACC110_PRODUCT,
      lv_next_id TYPE i.

    "1. Reuse IDs for existing drafts
    LOOP AT entities INTO entity
      WHERE ProductId IS NOT INITIAL.

      APPEND VALUE #(
        %cid      = entity-%cid
        %key      = entity-%key
        %is_draft = entity-%is_draft
      ) TO mapped-product.

    ENDLOOP.

    "2. Collect entities needing a new ID
    DATA(entities_without_id) = entities.

    DELETE entities_without_id
      WHERE ProductId IS NOT INITIAL.

    IF entities_without_id IS INITIAL.
      RETURN.
    ENDIF.

    "3. Reserve new product IDs
    TRY.

        cl_numberrange_runtime=>number_get(
          EXPORTING
            nr_range_nr = '01'
            object      = 'ZSP110PRD'
            quantity    = CONV #( lines( entities_without_id ) )
          IMPORTING
            number            = DATA(lv_number)
            returncode        = DATA(lv_returncode)
            returned_quantity = DATA(lv_quantity)
        ).

      CATCH cx_number_ranges INTO DATA(lx_error).

        LOOP AT entities_without_id INTO entity.

          APPEND VALUE #(
            %cid = entity-%cid
            %key = entity-%key
          ) TO failed-product.

          APPEND VALUE #(
            %cid = entity-%cid
            %key = entity-%key
            %msg = lx_error
          ) TO reported-product.

        ENDLOOP.

        RETURN.

    ENDTRY.

    "4. Handle insufficient numbers
    IF lv_returncode = '2'
       OR lv_returncode = '3'
       OR lv_quantity <> lines( entities_without_id ).

      LOOP AT entities_without_id INTO entity.

        APPEND VALUE #(
          %cid        = entity-%cid
          %key        = entity-%key
          %fail-cause = if_abap_behv=>cause-conflict
        ) TO failed-product.

      ENDLOOP.

      RETURN.

    ENDIF.

    "5. Calculate first generated ID
    lv_next_id = CONV i( lv_number )
               - CONV i( lv_quantity ).

    "6. Map each generated ProductId
    LOOP AT entities_without_id INTO entity.

      lv_next_id += 1.

      entity-ProductId = lv_next_id.

      APPEND VALUE #(
        %cid      = entity-%cid
        %key      = entity-%key
        %is_draft = entity-%is_draft
      ) TO mapped-product.

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
