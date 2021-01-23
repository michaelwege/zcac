CLASS zcx_cac_model DEFINITION
  PUBLIC
  INHERITING FROM cx_static_check
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_t100_dyn_msg .
    INTERFACES if_t100_message .

    CONSTANTS:
      BEGIN OF cannot_create_instance,
        msgid TYPE symsgid VALUE 'ZCAC_MODEL_MSG',
        msgno TYPE symsgno VALUE '000',
        attr1 TYPE scx_attrname VALUE 'CLSNAME',
        attr2 TYPE scx_attrname VALUE 'ERROR_MSG',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF cannot_create_instance .
    CONSTANTS:
      BEGIN OF unknown_model,
        msgid TYPE symsgid VALUE 'ZCAC_MODEL_MSG',
        msgno TYPE symsgno VALUE '001',
        attr1 TYPE scx_attrname VALUE 'MODEL_NAME',
        attr2 TYPE scx_attrname VALUE '',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF unknown_model .
    CONSTANTS:
      BEGIN OF class_no_intf,
        msgid TYPE symsgid VALUE 'ZCAC_MODEL_MSG',
        msgno TYPE symsgno VALUE '002',
        attr1 TYPE scx_attrname VALUE 'CLSNAME',
        attr2 TYPE scx_attrname VALUE 'INTFNAME',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF class_no_intf .

    DATA error_msg TYPE string .
    DATA clsname TYPE seoclsname .
    DATA intfname TYPE seoclsname .
    DATA model_name TYPE zif_cac_model_manager=>ty_model_name.

    METHODS constructor
      IMPORTING
        !textid     LIKE if_t100_message=>t100key OPTIONAL
        !previous   LIKE previous OPTIONAL
        !error_msg  TYPE string OPTIONAL
        !clsname    TYPE seoclsname OPTIONAL
        !intfname   TYPE seoclsname OPTIONAL
        !model_name TYPE zif_cac_model_manager=>ty_model_name OPTIONAL.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcx_cac_model IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    super->constructor( previous = previous ).
    me->error_msg = error_msg .
    me->clsname = clsname .
    me->intfname = intfname .
    me->model_name = model_name.
    CLEAR me->textid.
    IF textid IS INITIAL.
      if_t100_message~t100key = if_t100_message=>default_textid.
    ELSE.
      if_t100_message~t100key = textid.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
