"! <p class="shorttext synchronized">Application interface</p>
"! An application is represented by one single application instance. This instance
"! takes care of the application flow by managing the controller instances and calling
"! their respective methods when necessary. Some basic application settings can be defined
"! upon initialization of the application.
"!
"! An application also always serves as a model manager. If data is managed
"! by the application instance or a specific controller instance is up to the application developer.
INTERFACE zif_cac_app
  PUBLIC .

  INTERFACES zif_cac_model_manager.

  ALIASES get_model FOR zif_cac_model_manager~get_model.
  ALIASES add_model FOR zif_cac_model_manager~add_model.
  ALIASES del_model FOR zif_cac_model_manager~del_model.
  ALIASES del_all_models FOR zif_cac_model_manager~del_all_models.

  TYPES ty_exc_handling TYPE c LENGTH 3.

  TYPES:
    BEGIN OF ty_s_init_param,
      controller_required TYPE abap_bool,
      exception_handling  TYPE ty_exc_handling,
    END OF ty_s_init_param.

  CONSTANTS:
    BEGIN OF c_exc_hdl,
      message  TYPE ty_exc_handling VALUE 'MSG',
      dump     TYPE ty_exc_handling VALUE 'DMP',
      severity TYPE ty_exc_handling VALUE 'SEV',
    END OF c_exc_hdl.

  "! <p class="shorttext synchronized">Initialization of the application</p>
  "!
  "! @parameter iv_controller_prefix  | <p class="shorttext synchronized">Prefix for controller class names</p>
  "! @parameter io_controller_factory | Controller factory
  "! @parameter is_init_parameter     | <p class="shorttext synchronized">Various parameter to control the basic application</p>
  METHODS initialize
    IMPORTING
      iv_controller_prefix  TYPE seoclsname
      io_controller_factory TYPE REF TO zif_cac_controller_factory
      is_init_parameter     TYPE ty_s_init_param OPTIONAL.

  "! <p class="shorttext synchronized">Process PBO</p>
  "!
  "! @parameter iv_screen | Current screen number
  METHODS process_pbo
    IMPORTING
      iv_screen TYPE sydynnr.

  "! <p class="shorttext synchronized">Process PAI</p>
  "!
  "! @parameter iv_screen | Current screen number
  "! @parameter iv_ucomm  | Current user command
  "! @parameter iv_exec   | Indicator for START-OF-SELECTION event
  METHODS process_pai
    IMPORTING
      iv_screen TYPE sydynnr
      iv_ucomm  TYPE syucomm
      iv_exec   TYPE abap_bool DEFAULT abap_false.

  "! <p class="shorttext synchronized">Process EXIT</p>
  "!
  "! @parameter iv_screen | Current screen number
  "! @parameter iv_ucomm  | Current user command
  METHODS process_exit
    IMPORTING
      iv_screen TYPE sydynnr
      iv_ucomm  TYPE syucomm.

  "! <p class="shorttext synchronized">Get controller for given screen</p>
  "!
  "! @parameter iv_screen     | Screen number of controller
  "! @parameter ro_controller | Controller instance
  "! @raising zcx_cac_app     | Error, e.g. because local class does not exist
  METHODS get_controller
    IMPORTING
      iv_screen            TYPE sydynnr
    RETURNING
      VALUE(ro_controller) TYPE REF TO zif_cac_controller
    RAISING
      zcx_cac_app.

  "! <p class="shorttext synchronized">Handle exception in application flow</p>
  "!
  "! @parameter ix_exception  | Exception instance
  "! @parameter iv_severity   | Severity of error
  METHODS handle_exception
    IMPORTING
      ix_exception TYPE REF TO cx_root
      iv_severity  TYPE symsgty DEFAULT 'A'.

ENDINTERFACE.
