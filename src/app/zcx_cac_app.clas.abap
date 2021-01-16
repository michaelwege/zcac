CLASS zcx_cac_app DEFINITION
  PUBLIC
  INHERITING FROM cx_static_check
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_t100_dyn_msg .
    INTERFACES if_t100_message .

    CONSTANTS:
      BEGIN OF cannot_create_instance,
        msgid TYPE symsgid VALUE 'ZCAC_APP_MSG',
        msgno TYPE symsgno VALUE '000',
        attr1 TYPE scx_attrname VALUE 'CLSNAME',
        attr2 TYPE scx_attrname VALUE 'ERROR_MSG',
        attr3 TYPE scx_attrname VALUE '',
        attr4 TYPE scx_attrname VALUE '',
      END OF cannot_create_instance .
    DATA error_msg TYPE string .
    DATA clsname TYPE seoclsname .

    METHODS constructor
      IMPORTING
        !textid    LIKE if_t100_message=>t100key OPTIONAL
        !previous  LIKE previous OPTIONAL
        !error_msg TYPE string OPTIONAL
        !clsname   TYPE seoclsname OPTIONAL .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcx_cac_app IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    CALL METHOD super->constructor
      EXPORTING
        previous = previous.
    me->error_msg = error_msg .
    me->clsname = clsname .
    CLEAR me->textid.
    IF textid IS INITIAL.
      if_t100_message~t100key = if_t100_message=>default_textid.
    ELSE.
      if_t100_message~t100key = textid.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
