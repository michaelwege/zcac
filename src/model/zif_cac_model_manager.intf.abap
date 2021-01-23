"! <p class="shorttext synchronized">Model manager interface</p>
"! A model manager is capable of holding multiple model instances and
"! provides a common access. Each model instance can be address via
"! a unique name.
INTERFACE zif_cac_model_manager
  PUBLIC .

  TYPES ty_model_name TYPE c LENGTH 30.

  "! <p class="shorttext synchronized">Add new model</p>
  "!
  "! @parameter io_model | Model instance
  "! @parameter iv_name  | Unique model name
  METHODS add_model
    IMPORTING
      io_model TYPE REF TO zif_cac_model
      iv_name  TYPE ty_model_name.

  "! <p class="shorttext synchronized">Retrieve specific model</p>
  "!
  "! @parameter iv_name     | Unique model name
  "! @parameter ro_model    | Model instance
  "! @raising zcx_cac_model | Model name unknown
  METHODS get_model
    IMPORTING
      iv_name         TYPE ty_model_name
    RETURNING
      VALUE(ro_model) TYPE REF TO zif_cac_model
    RAISING
      zcx_cac_model.

  "! <p class="shorttext synchronized">Remove specific model</p>
  "!
  "! @parameter iv_name | Unique model name
  METHODS del_model
    IMPORTING
      iv_name TYPE ty_model_name.

  "! <p class="shorttext synchronized">Remove all models</p>
  METHODS del_all_models.

ENDINTERFACE.
