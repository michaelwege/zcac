interface ZIF_CAC_MODEL
  public .


  methods SET_DATA
    importing
      !IR_DATA type ref to DATA
      !IT_FCAT type LVC_T_FCAT optional .
  methods SET_FCAT
    importing
      !IT_FCAT type LVC_T_FCAT .
  methods GET_DATA
    returning
      value(R_DATA) type ref to DATA .
  methods GET_FCAT
    returning
      value(RT_FCAT) type LVC_T_FCAT .
endinterface.
