CLASS zcl_cac_app_abs DEFINITION
  PUBLIC
  ABSTRACT
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES zif_cac_app ABSTRACT METHODS add_model get_model del_model del_all_models.

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

    DATA _exc_handling TYPE zif_cac_app~ty_exc_handling.

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
      me->_exc_handling        = is_init_parameter-exception_handling.
    ELSE.
      me->_controller_required = abap_false.
      me->_exc_handling        = me->zif_cac_app~c_exc_hdl-message.
    ENDIF.

    CLEAR me->_controllers.

  ENDMETHOD.

  METHOD zif_cac_app~process_pai.
    TRY.
        me->zif_cac_app~get_controller( iv_screen )->on_pai( iv_ucomm = iv_ucomm iv_exec = iv_exec ).
      CATCH zcx_cac_app INTO DATA(lx_app).
        me->zif_cac_app~handle_exception( lx_app ).
    ENDTRY.
  ENDMETHOD.

  METHOD zif_cac_app~process_pbo.
    TRY.
        me->zif_cac_app~get_controller( iv_screen )->on_pbo( ).
      CATCH zcx_cac_app INTO DATA(lx_app).
        me->zif_cac_app~handle_exception( lx_app ).
    ENDTRY.
  ENDMETHOD.

  METHOD zif_cac_app~process_exit.
    TRY.
        me->zif_cac_app~get_controller( iv_screen )->on_exit( iv_ucomm = iv_ucomm ).
      CATCH zcx_cac_app INTO DATA(lx_app).
        me->zif_cac_app~handle_exception( lx_app ).
    ENDTRY.
  ENDMETHOD.

  METHOD zif_cac_app~handle_exception.
    CASE me->_exc_handling.
      WHEN me->zif_cac_app~c_exc_hdl-message.
        MESSAGE ix_exception TYPE iv_severity.
      WHEN me->zif_cac_app~c_exc_hdl-dump.
        RAISE EXCEPTION ix_exception.
      WHEN me->zif_cac_app~c_exc_hdl-severity.
        CASE iv_severity.
          WHEN 'X' OR 'A' OR 'E'.
            RAISE EXCEPTION ix_exception.
          WHEN OTHERS.
            MESSAGE ix_exception TYPE iv_severity.
        ENDCASE.
    ENDCASE.
  ENDMETHOD.

ENDCLASS.
