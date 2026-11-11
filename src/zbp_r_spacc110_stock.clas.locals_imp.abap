CLASS lhc_Stock DEFINITION
  INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    METHODS validateUniqueStock
      FOR VALIDATE ON SAVE
      IMPORTING keys FOR Stock~validateUniqueStock.

    METHODS validateStockAmount
      FOR VALIDATE ON SAVE
      IMPORTING keys FOR Stock~validateStockAmount.

    METHODS precheck_create
      FOR PRECHECK
      IMPORTING entities FOR CREATE Stock.

ENDCLASS.


CLASS lhc_Stock IMPLEMENTATION.

  METHOD validateUniqueStock.

    " Hent lager og produkt fra RAP-bufferen
    READ ENTITIES OF ZR_SPACC110_STOCK IN LOCAL MODE
      ENTITY Stock
      FIELDS ( warehouse_id product_id )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_stock).

    LOOP AT lt_stock INTO DATA(ls_stock).

      " Ryd tidligere beskeder fra denne validation
      APPEND VALUE #(
        %tky        = ls_stock-%tky
        %state_area = 'UNIQUE_STOCK'
      ) TO reported-Stock.

      " Findes kombinationen allerede i databasen?
      SELECT SINGLE FROM zspacc110_stock
        FIELDS product_id
        WHERE warehouse_id = @ls_stock-warehouse_id
          AND product_id   = @ls_stock-product_id
        INTO @DATA(lv_existing_product).

      IF sy-subrc = 0.

        APPEND VALUE #(
          %tky = ls_stock-%tky
        ) TO failed-Stock.

        APPEND VALUE #(
          %tky        = ls_stock-%tky
          %state_area = 'UNIQUE_STOCK'
          %msg        = new_message_with_text(
            severity = if_abap_behv_message=>severity-error
            text     = 'Product already exists in this warehouse. Edit the existing stock entry.'
          )
          %element-warehouse_id = if_abap_behv=>mk-on
          %element-product_id   = if_abap_behv=>mk-on
        ) TO reported-Stock.

      ENDIF.

    ENDLOOP.

  ENDMETHOD.


  METHOD validateStockAmount.

    " Hent lagerbeholdningen fra RAP-bufferen
    READ ENTITIES OF ZR_SPACC110_STOCK IN LOCAL MODE
      ENTITY Stock
      FIELDS ( amount )
      WITH CORRESPONDING #( keys )
      RESULT DATA(lt_stock).

    LOOP AT lt_stock INTO DATA(ls_stock).

      " Ryd tidligere beskeder fra denne validation
      APPEND VALUE #(
        %tky        = ls_stock-%tky
        %state_area = 'STOCK_AMOUNT'
      ) TO reported-Stock.

      " Beholdningen må ikke være negativ
      IF ls_stock-amount < 0.

        APPEND VALUE #(
          %tky = ls_stock-%tky
        ) TO failed-Stock.

        APPEND VALUE #(
          %tky        = ls_stock-%tky
          %state_area = 'STOCK_AMOUNT'
          %msg        = new_message_with_text(
            severity = if_abap_behv_message=>severity-error
            text     = 'Stock amount cannot be negative.'
          )
          %element-amount = if_abap_behv=>mk-on
        ) TO reported-Stock.

      ENDIF.

    ENDLOOP.

  ENDMETHOD.


  METHOD precheck_create.

    " Kontroller eksisterende lagerregistreringer
    LOOP AT entities INTO DATA(ls_entity).

      SELECT SINGLE FROM zspacc110_stock
        FIELDS product_id
        WHERE warehouse_id = @ls_entity-warehouse_id
          AND product_id   = @ls_entity-product_id
        INTO @DATA(lv_existing_product).

      IF sy-subrc = 0.

        " Afvis oprettelse af en dublet
        APPEND VALUE #(
          %cid = ls_entity-%cid
        ) TO failed-Stock.

        " Vis en brugervenlig fejl i Fiori
        APPEND VALUE #(
          %cid = ls_entity-%cid
          %msg = new_message_with_text(
            severity = if_abap_behv_message=>severity-error
            text     = 'Product already exists in this warehouse. Edit the existing stock entry.'
          )
          %element-warehouse_id = if_abap_behv=>mk-on
          %element-product_id   = if_abap_behv=>mk-on
        ) TO reported-Stock.

      ENDIF.

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
