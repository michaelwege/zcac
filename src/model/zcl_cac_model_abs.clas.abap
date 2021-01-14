class ZCL_CAC_MODEL_ABS definition
  public
  abstract
  create public .

public section.

  interfaces ZIF_CAC_MODEL .
protected section.

  data _DATA type ref to DATA .
  data _FCAT type LVC_T_FCAT .
  data _TABLE_DESCR type ref to CL_ABAP_TABLEDESCR .
private section.
ENDCLASS.



CLASS ZCL_CAC_MODEL_ABS IMPLEMENTATION.


  METHOD ZIF_CAC_MODEL~GET_DATA.
    r_data = me->_data.
  ENDMETHOD.


  METHOD ZIF_CAC_MODEL~GET_FCAT.
    rt_fcat = me->_fcat.
  ENDMETHOD.


  METHOD ZIF_CAC_MODEL~SET_DATA.

    me->_data = ir_data.

    me->_fcat = it_fcat.

  ENDMETHOD.


  METHOD ZIF_CAC_MODEL~SET_FCAT.
    me->_fcat = it_fcat.
  ENDMETHOD.
ENDCLASS.
