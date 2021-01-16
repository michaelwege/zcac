INTERFACE zif_cac_controller_factory
  PUBLIC .

  METHODS create_controller
    IMPORTING
      iv_clsname           TYPE seoclsname
    RETURNING
      VALUE(ro_controller) TYPE REF TO zif_cac_controller
    RAISING
      cx_sy_create_object_error.

ENDINTERFACE.
