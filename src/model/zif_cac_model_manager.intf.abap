INTERFACE zif_cac_model_manager
  PUBLIC .

  TYPES ty_model_name TYPE c LENGTH 30.

  METHODS add_model
    IMPORTING
      io_model TYPE REF TO zif_cac_model
      iv_name  TYPE ty_model_name.

  METHODS get_model
    IMPORTING
      iv_name         TYPE ty_model_name
    RETURNING
      VALUE(ro_model) TYPE REF TO zif_cac_model
    RAISING
      zcx_cac_model.

  METHODS del_model
    IMPORTING
      iv_name TYPE ty_model_name.

  METHODS del_all_models.

ENDINTERFACE.
