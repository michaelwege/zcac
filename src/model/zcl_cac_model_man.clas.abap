CLASS zcl_cac_model_man DEFINITION
  PUBLIC
  CREATE PRIVATE
  GLOBAL FRIENDS zcl_cac_model_common .

  PUBLIC SECTION.

    INTERFACES zif_cac_model_manager.

  PROTECTED SECTION.

    TYPES:
      BEGIN OF _ty_model_item,
        name  TYPE zif_cac_model_manager~ty_model_name,
        model TYPE REF TO zif_cac_model,
      END OF _ty_model_item.

    DATA _models TYPE SORTED TABLE OF _ty_model_item WITH UNIQUE KEY name.

ENDCLASS.



CLASS zcl_cac_model_man IMPLEMENTATION.

  METHOD zif_cac_model_manager~add_model.
    INSERT VALUE #( name = iv_name model = io_model ) INTO TABLE me->_models.
  ENDMETHOD.

  METHOD zif_cac_model_manager~del_model.
    TRY.
        me->zif_cac_model_manager~get_model( iv_name = iv_name )->free( ).
        DELETE TABLE me->_models WITH TABLE KEY name = iv_name.
      CATCH zcx_cac_model.
        RETURN.
    ENDTRY.
  ENDMETHOD.

  METHOD zif_cac_model_manager~get_model.
    TRY.
        ro_model = me->_models[ name = iv_name ]-model.
      CATCH cx_sy_itab_line_not_found INTO DATA(lx_mod).
        RAISE EXCEPTION TYPE zcx_cac_model
          EXPORTING
            previous   = lx_mod
            textid     = zcx_cac_model=>unknown_model
            model_name = iv_name.
    ENDTRY.
  ENDMETHOD.

  METHOD zif_cac_model_manager~del_all_models.
    LOOP AT me->_models ASSIGNING FIELD-SYMBOL(<ls_model_item>).
      <ls_model_item>-model->free( ).
    ENDLOOP.
    CLEAR me->_models.
  ENDMETHOD.

ENDCLASS.
