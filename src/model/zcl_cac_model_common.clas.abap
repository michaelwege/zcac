"! <p class="shorttext synchronized">Common CAC model functions</p>
"!
"! This class provides the most common functions regarding CAC models,
"! including the FACTORY methods.
CLASS zcl_cac_model_common DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    "! <p class="shorttext synchronized">Create model instance</p>
    "!
    "! @parameter ro_model    | Model instance
    "! @raising zcx_cac_model | Instance could not be created
    CLASS-METHODS factory_model
      RETURNING
        VALUE(ro_model) TYPE REF TO zif_cac_model
      RAISING
        zcx_cac_model.

    "! <p class="shorttext synchronized">Create model manager instance</p>
    "!
    "! @parameter ro_model_man | Model manager instance
    CLASS-METHODS factory_model_manager
      RETURNING
        VALUE(ro_model_man) TYPE REF TO zif_cac_model_manager.

    "! <p class="shorttext synchronized">Set model class name</p>
    "! The class must implement interface ZIF_CAC_MODEL
    "!
    "! @parameter iv_clsname  | Class name
    "! @raising zcx_cac_model | Class not suitable
    CLASS-METHODS set_model_clsname
      IMPORTING
        !iv_clsname TYPE seoclsname
      RAISING
        zcx_cac_model.

  PROTECTED SECTION.

  PRIVATE SECTION.

    CLASS-DATA model_clsname TYPE seoclsname .
    CLASS-DATA intf_descr TYPE REF TO cl_abap_intfdescr.

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

    IF intf_descr IS NOT BOUND.
      intf_descr ?= cl_abap_intfdescr=>describe_by_name( 'ZIF_CAC_MODEL' ).
    ENDIF.

    "Check if the class implements the necessary interface
    model_clsname = COND #( WHEN intf_descr->applies_to_class( iv_clsname ) EQ abap_true
      THEN iv_clsname
      ELSE THROW zcx_cac_model( textid = zcx_cac_model=>class_no_intf clsname = iv_clsname intfname = 'ZIF_CAC_MODEL' ) ).

  ENDMETHOD.

  METHOD factory_model_manager.
    CREATE OBJECT ro_model_man TYPE zcl_cac_model_man.
  ENDMETHOD.

ENDCLASS.
