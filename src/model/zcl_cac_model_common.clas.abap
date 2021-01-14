class ZCL_CAC_MODEL_COMMON definition
  public
  final
  create public .

public section.

  class-methods FACTORY_MODEL
    returning
      value(RO_MODEL) type ref to ZIF_CAC_MODEL
    raising
      ZCX_CAC_MODEL .
  class-methods SET_MODEL_CLSNAME
    importing
      !IV_CLSNAME type SEOCLSNAME .
protected section.
private section.

  class-data MODEL_CLSNAME type SEOCLSNAME .
ENDCLASS.



CLASS ZCL_CAC_MODEL_COMMON IMPLEMENTATION.


  METHOD factory_model.

    DATA lx_obj TYPE REF TO cx_sy_create_object_error.

    IF model_clsname IS INITIAL.
      CREATE OBJECT ro_model TYPE zcl_cac_model.
    ELSE.
      TRY.
          CREATE OBJECT ro_model TYPE (model_clsname).
        CATCH cx_sy_create_object_error INTO lx_obj.
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
ENDCLASS.
