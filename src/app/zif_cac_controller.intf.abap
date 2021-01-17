"! <p class="shorttext synchronized">Controller interface</p>
"!
"! The controller provides the application logic for a specific screen.
"! Each individual screen, including subscreens and modal screens, has its own
"! controller instance. A controller class is statically linked to its screen by its
"! name. The prefix is defined ones at the initialization of the application. The class name
"! of a controller then consists of the prefix + screen number, e.g. LCL_CONTROLLER_2000.
"!
"! The controller itself provides all necessary methods that are automatically called by the
"! application when necessary. A controller also always serves as a model manager. If data is managed
"! by the application instance or a specific controller instance is up to the application developer. Keep in mind
"! that even if data is managed by a specific screen controller, other controllers can still access them via the
"! application interface method GET_CONTROLLER.
INTERFACE zif_cac_controller
  PUBLIC .

  INTERFACES zif_cac_model_manager.

  ALIASES get_model FOR zif_cac_model_manager~get_model.
  ALIASES add_model FOR zif_cac_model_manager~add_model.
  ALIASES del_model FOR zif_cac_model_manager~del_model.
  ALIASES del_all_models FOR zif_cac_model_manager~del_all_models.

  "! <p class="shorttext synchronized">Initialization</p>
  "! This is called once upon creation.
  METHODS on_init.
  "! <p class="shorttext synchronized">Handles PBO/OUTPUT events/module</p>
  "! This is called at the PBO of screens.
  METHODS on_pbo.
  "! <p class="shorttext synchronized">Handles PAI/INPUT events/module</p>
  "! This is called at the PAI of screens.
  "!
  "! @parameter iv_ucomm  | User command
  "! @parameter iv_exec   | <p class="shorttext synchronized">Indicator for START-OF-SELECTION event</p>
  METHODS on_pai
    IMPORTING
      iv_ucomm TYPE syucomm
      iv_exec  TYPE abap_bool DEFAULT abap_false.
  "! <p class="shorttext synchronized">Handles AT EXIT-COMMAND events/module</p>
  "! This is called at the PAI AT EXIT-COMMAND of screens.
  "!
  "! @parameter iv_ucomm | User command
  METHODS on_exit
    IMPORTING
      iv_ucomm TYPE syucomm.

ENDINTERFACE.
