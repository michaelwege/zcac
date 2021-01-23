*&---------------------------------------------------------------------*
*& Report zcac_demo
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcac_demo.

CLASS lcl_factory DEFINITION FINAL.
  PUBLIC SECTION.
    INTERFACES zif_cac_controller_factory.
ENDCLASS.

CLASS lcl_factory IMPLEMENTATION.
  METHOD zif_cac_controller_factory~create_controller.
    CREATE OBJECT ro_controller TYPE (iv_clsname).
  ENDMETHOD.
ENDCLASS.

*DATA go_app TYPE REF TO zif_cac_app.
*
*INITIALIZATION.
*  go_app = NEW zcl_cac_app( ).
*  go_app->initialize(
*    iv_controller_prefix  = 'LCL_CONTR_'
*    io_controller_factory = NEW lcl_factory( )
*    is_init_parameter     = VALUE #( controller_required = abap_true
*                                     exception_handling  = zif_cac_app=>c_exc_hdl-message ) ).
*
*AT SELECTION-SCREEN OUTPUT.
*  go_app->process_pbo( sy-dynnr ).
*
*AT SELECTION-SCREEN.
*  go_app->process_pai(
*    iv_screen = sy-dynnr
*    iv_ucomm  = sy-ucomm ).
*
*START-OF-SELECTION.
*  go_app->process_pai(
*    iv_screen = sy-dynnr
*    iv_ucomm  = sy-ucomm
*    iv_exec   = abap_true ).
*
*MODULE pbo OUTPUT.
*  go_app->process_pbo( sy-dynnr ).
*ENDMODULE.
*
*MODULE pai INPUT.
*  go_app->process_pai(
*    iv_screen = sy-dynnr
*    iv_ucomm  = sy-ucomm ).
*ENDMODULE.
*
*MODULE exit INPUT.
*  go_app->process_exit(
*    iv_screen = sy-dynnr
*    iv_ucomm  = sy-ucomm ).
*ENDMODULE.
*
***********************************************************************
** Here starts the application coding
*PARAMETERS p_uname TYPE syuname.
*
*CLASS lcl_base_controller DEFINITION INHERITING FROM zcl_cac_controller_abs.
*
*  PROTECTED SECTION.
*
*    "All possible user commands of the applications that are handled by the controllers
*    CONSTANTS:
*      BEGIN OF _c_ucomm,
*        back    TYPE syucomm VALUE 'BACK',
*        leave   TYPE syucomm VALUE 'LEAVE',
*        refresh TYPE syucomm VALUE 'REFRESH',
*      END OF _c_ucomm.
*
*ENDCLASS.
*
*CLASS lcl_contr_1000 DEFINITION INHERITING FROM lcl_base_controller FINAL.
*
*  PUBLIC SECTION.
*
*    METHODS zif_cac_controller~on_pai REDEFINITION.
*
*ENDCLASS.
*
*CLASS lcl_contr_1000 IMPLEMENTATION.
*
*  METHOD zif_cac_controller~on_pai.
*
*    IF iv_exec EQ abap_true.
*
*      "This is the START-OF-SELECTION event. Keep in mind that this
*      "may also be triggered by a background job
*      CALL SCREEN 2000.
*
*    ELSE.
*
*      CASE iv_ucomm.
*
*        WHEN OTHERS.
*          "Here we would handle everything else on the main selection screen
*          "except the stuff that the system takes care of itself (e.g. variants, etc.)
*          RETURN.
*
*      ENDCASE.
*
*    ENDIF.
*
*  ENDMETHOD.
*
*ENDCLASS.
*
*CLASS lcl_contr_2000 DEFINITION INHERITING FROM lcl_base_controller FINAL.
*
*  PUBLIC SECTION.
*
*    METHODS zif_cac_controller~on_pbo REDEFINITION.
*    METHODS zif_cac_controller~on_pai REDEFINITION.
*    METHODS zif_cac_controller~on_exit REDEFINITION.
*
*ENDCLASS.
*
*CLASS lcl_contr_2000 IMPLEMENTATION.
*
*  METHOD zif_cac_controller~on_pbo.
*
*    SET TITLEBAR 'DEFAULT_TITLE'.
*    SET PF-STATUS 'DEFAULT_STATUS'.
*
*  ENDMETHOD.
*
*  METHOD zif_cac_controller~on_pai.
*
*    CASE iv_ucomm.
*
*      WHEN me->_c_ucomm-refresh.
*        "Do whatever has to be done
*
*    ENDCASE.
*
*  ENDMETHOD.
*
*  METHOD zif_cac_controller~on_exit.
*
*    CASE iv_ucomm.
*
*      WHEN me->_c_ucomm-back OR me->_c_ucomm-leave.
*
*        "Remove all the data, before we leave.
*        "Depending on the application, we could also keep the data,
*        "if we come back again.
*        me->zif_cac_controller~del_all_models( ).
*        LEAVE TO SCREEN 0.
*
*      WHEN OTHERS.
*
*        "We might have some other exit commands that might do different things
*        "e.g. create a log before leaving etc.
*        me->zif_cac_controller~del_all_models( ).
*        LEAVE TO SCREEN 0.
*
*    ENDCASE.
*
*  ENDMETHOD.
*
*ENDCLASS.
