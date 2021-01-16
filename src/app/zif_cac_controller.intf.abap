INTERFACE zif_cac_controller
  PUBLIC .

  INTERFACES zif_cac_model_manager.

  ALIASES get_model FOR zif_cac_model_manager~get_model.
  ALIASES add_model FOR zif_cac_model_manager~add_model.
  ALIASES del_model FOR zif_cac_model_manager~del_model.
  ALIASES del_all_models FOR zif_cac_model_manager~del_all_models.

  METHODS on_init.
  METHODS on_pbo.
  METHODS on_pai
    IMPORTING
      iv_ucomm TYPE syucomm.
  METHODS on_exit
    IMPORTING
      iv_ucomm TYPE syucomm.

ENDINTERFACE.
