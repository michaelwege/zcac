CLASS zcl_cac_controller_abs DEFINITION
  PUBLIC
  ABSTRACT
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_cac_controller.

  PROTECTED SECTION.

    DATA _model_manager TYPE REF TO zif_cac_model_manager.

  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_cac_controller_abs IMPLEMENTATION.

  METHOD zif_cac_controller~on_exit.
    RETURN.
  ENDMETHOD.

  METHOD zif_cac_controller~on_init.
    me->_model_manager = zcl_cac_model_common=>factory_model_manager( ).
  ENDMETHOD.

  METHOD zif_cac_controller~on_pai.
    RETURN.
  ENDMETHOD.

  METHOD zif_cac_controller~on_pbo.
    RETURN.
  ENDMETHOD.

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
