"! <p class="shorttext synchronized">Model interface</p>
"! Each instance represents one internal data table and provides
"! common access and functions to incorporate the data into applications.
INTERFACE zif_cac_model
  PUBLIC .

  "! <p class="shorttext synchronized">Set the data</p>
  "!
  "! @parameter ir_data | Data reference
  "! @parameter it_fcat | Fieldcatalog
  METHODS set_data
    IMPORTING
      !ir_data TYPE REF TO data
      !it_fcat TYPE lvc_t_fcat OPTIONAL .

  "! <p class="shorttext synchronized">Define the ALV fieldcatalog for the data</p>
  "!
  "! it_fcat | Fieldcatalog
  METHODS set_fcat
    IMPORTING
      !it_fcat TYPE lvc_t_fcat .

  "! <p class="shorttext synchronized">Retrieve the data from the instance</p>
  "!
  "! @parameter r_data | Data reference
  METHODS get_data
    RETURNING
      VALUE(r_data) TYPE REF TO data .

  "! <p class="shorttext synchronized">Retrieve the ALV fieldcatalog</p>
  "!
  "! @parameter rt_fcat | Fieldcatalog
  METHODS get_fcat
    RETURNING
      VALUE(rt_fcat) TYPE lvc_t_fcat .

  METHODS free.

ENDINTERFACE.
