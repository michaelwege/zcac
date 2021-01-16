CLASS zcl_cac_model_common DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    CLASS-METHODS factory_model
      RETURNING
        VALUE(ro_model) TYPE REF TO zif_cac_model
      RAISING
        zcx_cac_model.

    CLASS-METHODS factory_model_manager
      RETURNING
        VALUE(ro_model_man) TYPE REF TO zif_cac_model_manager.

    CLASS-METHODS set_model_clsname
      IMPORTING
        !iv_clsname TYPE seoclsname .

  PROTECTED SECTION.

  PRIVATE SECTION.

    CLASS-DATA model_clsname TYPE seoclsname .

ENDCLASS.



CLASS zcl_cac_model_common IMPLEMENTATION.


  METHOD factory_model.

    IF model_clsname IS INITIAL.
      CREATE OBJECT ro_model TYPE zcl_cac_model.
    ELSE.
      TRY.
          CREATE OBJECT ro_model TYPE (model_clsname).
        CATCH cx_sy_create_object_error INTO DATA(lx_obj).
          RAISE EXCEPTION TYPE zcx_cac_model
            EXPORTING
              previous  = lx_obj
              textid    = zcx_cac_model=>cannot_create_instance
              clsname   = model_clsname
              error_msg = lx_obj->get_text( ).
      ENDTRY.
    ENDIF.

  ENDMETHOD.

  METHOD set_model_clsname.
    model_clsname = iv_clsname.
  ENDMETHOD.

  METHOD factory_model_manager.
    CREATE OBJECT ro_model_man TYPE zcl_cac_model_man.
  ENDMETHOD.

ENDCLASS.
