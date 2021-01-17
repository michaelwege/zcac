CLASS zcl_cac_app DEFINITION
  PUBLIC
  INHERITING FROM zcl_cac_app_abs
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS zif_cac_model_manager~add_model REDEFINITION.
    METHODS zif_cac_model_manager~get_model REDEFINITION.
    METHODS zif_cac_model_manager~del_model REDEFINITION.
    METHODS zif_cac_model_manager~del_all_models REDEFINITION.

  PROTECTED SECTION.

    DATA _model_manager TYPE REF TO zif_cac_model_manager.

  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_cac_app IMPLEMENTATION.

  METHOD zif_cac_model_manager~add_model.
    me->_model_manager->add_model( iv_name = iv_name io_model = io_model ).
  ENDMETHOD.

  METHOD zif_cac_model_manager~del_model.
    me->_model_manager->del_model( iv_name = iv_name ).
  ENDMETHOD.

  METHOD zif_cac_model_manager~get_model.
    ro_model = me->_model_manager->get_model( iv_name = iv_name ).
  ENDMETHOD.

  METHOD zif_cac_model_manager~del_all_models.
    me->_model_manager->del_all_models( ).
  ENDMETHOD.

ENDCLASS.
