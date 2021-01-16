INTERFACE zif_cac_app
  PUBLIC .

  INTERFACES zif_cac_model_manager.

  ALIASES get_model FOR zif_cac_model_manager~get_model.
  ALIASES add_model FOR zif_cac_model_manager~add_model.
  ALIASES del_model FOR zif_cac_model_manager~del_model.
  ALIASES del_all_models FOR zif_cac_model_manager~del_all_models.

  TYPES:
    BEGIN OF ty_s_init_param,
      controller_required TYPE abap_bool,
    END OF ty_s_init_param.

  METHODS initialize
    IMPORTING
      iv_controller_prefix  TYPE seoclsname
      io_controller_factory TYPE REF TO zif_cac_controller_factory
      is_init_parameter     TYPE ty_s_init_param OPTIONAL.

  METHODS process_pbo
    IMPORTING
      iv_screen TYPE sydynnr.

  METHODS process_pai
    IMPORTING
      iv_screen TYPE sydynnr
      iv_ucomm  TYPE syucomm
      iv_exec   TYPE abap_bool DEFAULT abap_false.

  METHODS process_exit
    IMPORTING
      iv_screen TYPE sydynnr
      iv_ucomm  TYPE syucomm.

  METHODS get_controller
    IMPORTING
      iv_screen            TYPE sydynnr
    RETURNING
      VALUE(ro_controller) TYPE REF TO zif_cac_controller
    RAISING
      zcx_cac_app.

ENDINTERFACE.
