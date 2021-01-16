INTERFACE zif_cac_model
  PUBLIC .

  METHODS set_data
    IMPORTING
      !ir_data TYPE REF TO data
      !it_fcat TYPE lvc_t_fcat OPTIONAL .

  METHODS set_fcat
    IMPORTING
      !it_fcat TYPE lvc_t_fcat .

  METHODS get_data
    RETURNING
      VALUE(r_data) TYPE REF TO data .

  METHODS get_fcat
    RETURNING
      VALUE(rt_fcat) TYPE lvc_t_fcat .

  METHODS free.

ENDINTERFACE.
