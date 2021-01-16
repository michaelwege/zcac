CLASS zcl_cac_app_abs DEFINITION
  PUBLIC
  ABSTRACT
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_cac_app.

  PROTECTED SECTION.

    TYPES:
      BEGIN OF _ty_s_controller_item,
        screen     TYPE sydynnr,
        controller TYPE REF TO zif_cac_controller,
      END OF _ty_s_controller_item.

    DATA _controllers         TYPE SORTED TABLE OF _ty_s_controller_item WITH UNIQUE KEY screen.
    DATA _controller_factory  TYPE REF TO zif_cac_controller_factory.
    DATA _controller_prefix   TYPE seoclsname.
    DATA _controller_required TYPE abap_bool.

    DATA _model_manager TYPE REF TO zif_cac_model_manager.

  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_cac_app_abs IMPLEMENTATION.

  METHOD zif_cac_app~get_controller.

    DATA ls_controller_item TYPE _ty_s_controller_item.
    DATA lv_clsname         TYPE seoclsname.

    READ TABLE me->_controllers
      WITH TABLE KEY screen = iv_screen
      INTO ls_controller_item.

    IF sy-subrc EQ 0.

      ro_controller = ls_controller_item-controller.

    ELSE.

      TRY.
          "Try to get a controller instance
          lv_clsname = me->_controller_prefix && iv_screen.
          ro_controller = me->_controller_factory->create_controller( iv_clsname = lv_clsname ).
        CATCH cx_sy_create_object_error INTO DATA(lx_obj).

          IF me->_controller_required EQ abap_true.
            "Controller are mandatory
            RAISE EXCEPTION TYPE zcx_cac_app
              EXPORTING
                previous  = lx_obj
                textid    = zcx_cac_app=>cannot_create_instance
                clsname   = lv_clsname
                error_msg = lx_obj->get_text( ).
          ELSE.
            "Controller are not mandatory, we'll just continue with a dummy controller for this screen
            CREATE OBJECT ro_controller TYPE lcl_controller.
          ENDIF.

      ENDTRY.

      ls_controller_item-screen = iv_screen.
      ls_controller_item-controller = ro_controller.
      INSERT ls_controller_item INTO TABLE me->_controllers.

      ro_controller->on_init( ).

    ENDIF.

  ENDMETHOD.

  METHOD zif_cac_app~initialize.

    me->_controller_prefix = iv_controller_prefix.
    me->_controller_factory = io_controller_factory.

    IF is_init_parameter IS SUPPLIED.
      me->_controller_required = is_init_parameter-controller_required.
    ELSE.
      me->_controller_required = abap_false.
    ENDIF.

    CLEAR me->_controllers.

  ENDMETHOD.

  METHOD zif_cac_app~process_pai.
    TRY.
        me->zif_cac_app~get_controller( iv_screen )->on_pai( iv_ucomm = iv_ucomm ).
      CATCH zcx_cac_app.
        "[...]
    ENDTRY.
  ENDMETHOD.

  METHOD zif_cac_app~process_pbo.
    TRY.
        me->zif_cac_app~get_controller( iv_screen )->on_pbo( ).
      CATCH zcx_cac_app.
        "[...]
    ENDTRY.
  ENDMETHOD.

  METHOD zif_cac_app~process_exit.
    TRY.
        me->zif_cac_app~get_controller( iv_screen )->on_exit( iv_ucomm = iv_ucomm ).
      CATCH zcx_cac_app.
        "[...]
    ENDTRY.
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
