class ZCX_CAC_MODEL definition
  public
  inheriting from CX_STATIC_CHECK
  create public .

public section.

  interfaces IF_T100_DYN_MSG .
  interfaces IF_T100_MESSAGE .

  constants:
    begin of CANNOT_CREATE_INSTANCE,
      msgid type symsgid value 'ZCAC_MODEL_MSG',
      msgno type symsgno value '000',
      attr1 type scx_attrname value 'CLSNAME',
      attr2 type scx_attrname value 'ERROR_MSG',
      attr3 type scx_attrname value '',
      attr4 type scx_attrname value '',
    end of CANNOT_CREATE_INSTANCE .
  data ERROR_MSG type STRING .
  data CLSNAME type SEOCLSNAME .

  methods CONSTRUCTOR
    importing
      !TEXTID like IF_T100_MESSAGE=>T100KEY optional
      !PREVIOUS like PREVIOUS optional
      !ERROR_MSG type STRING optional
      !CLSNAME type SEOCLSNAME optional .
protected section.
private section.
ENDCLASS.



CLASS ZCX_CAC_MODEL IMPLEMENTATION.


  method CONSTRUCTOR.
CALL METHOD SUPER->CONSTRUCTOR
EXPORTING
PREVIOUS = PREVIOUS
.
me->ERROR_MSG = ERROR_MSG .
me->CLSNAME = CLSNAME .
clear me->textid.
if textid is initial.
  IF_T100_MESSAGE~T100KEY = IF_T100_MESSAGE=>DEFAULT_TEXTID.
else.
  IF_T100_MESSAGE~T100KEY = TEXTID.
endif.
  endmethod.
ENDCLASS.
