"! <p class="shorttext synchronized">Controller factory interface</p>
"!
"! The controller factory's only purpose is to create controller instances based on the local classes.
"! An instance of the controller factory is created and passed to the application instance, which uses it
"! to create the necessary controllers for the screens.
INTERFACE zif_cac_controller_factory
  PUBLIC .

  "! <p class="shorttext synchronized">Create a controller instance, based on the class name</p>
  "!
  "! @parameter iv_clsname              | Class name
  "! @parameter ro_controller           | Controller instance
  "! @raising cx_sy_create_object_error | Error in object creation
  METHODS create_controller
    IMPORTING
      iv_clsname           TYPE seoclsname
    RETURNING
      VALUE(ro_controller) TYPE REF TO zif_cac_controller
    RAISING
      cx_sy_create_object_error.

ENDINTERFACE.
