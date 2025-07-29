CLASS lcl_connection DEFINITION.

  PUBLIC SECTION.
    DATA carrier_id TYPE /dmo/carrier_id.
    DATA connection_id TYPE /dmo/connection_id.
    CLASS-DATA conn_counter TYPE i.

**********************************************************************
* Example: Methods of the Flight Connection Class                    *
**********************************************************************
    METHODS set_attributes
      IMPORTING
        i_carrier_id    TYPE /dmo/carrier_id OPTIONAL
        i_connection_id TYPE /dmo/connection_id.

    METHODS get_attributes
      EXPORTING
        e_carrier_id    TYPE /dmo/carrier_id
        e_connection_id TYPE /dmo/connection_id.


**********************************************************************
* Example: The Need for Self-Reference ME->                          *
**********************************************************************
*    METHODS set_attributes
*      IMPORTING
*        carrier_id    TYPE /dmo/carrier_id
*        connection_id TYPE /dmo/connection_id.


**********************************************************************
* Raising Exceptions                                                 *
**********************************************************************
*    METHODS set_attributes
*      IMPORTING
*        carrier_id    TYPE /dmo/carrier_id
*        connection_id TYPE /dmo/connection_id
*      RAISING
*        cx_abap_invalid_value.


**********************************************************************
* Functional Methods                                                 *
**********************************************************************
    METHODS get_output
      RETURNING VALUE(r_output) TYPE string_table.

  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.

CLASS lcl_connection IMPLEMENTATION.

**********************************************************************
* Implementing Methods                                               *
**********************************************************************
  METHOD set_attributes.
    carrier_id = i_carrier_id.
    connection_id = i_connection_id.
    conn_counter = conn_counter + 1.
  ENDMETHOD.

  METHOD get_attributes.
    e_carrier_id = carrier_id.
    e_connection_id = connection_id.
  ENDMETHOD.


**********************************************************************
* Example: The Need for Self-Reference ME->                          *
**********************************************************************
*  METHOD set_attributes.
*    me->carrier_id = carrier_id.
*    me->connection_id = connection_id.
*  ENDMETHOD.


**********************************************************************
* Raising Exceptions                                                 *
**********************************************************************
*  METHOD set_attributes.
*    IF carrier_id IS INITIAL OR connection_id IS INITIAL.
*      RAISE EXCEPTION TYPE cx_abap_invalid_value.
*    ENDIF.
*    me->carrier_id = carrier_id.
*    me->connection_id = connection_id.
*  ENDMETHOD.


**********************************************************************
* Functional Methods                                                 *
**********************************************************************
  METHOD get_output.
    APPEND |-----------------------------| TO r_output.
    APPEND |Carrier:    { carrier_id }   | TO r_output.
    APPEND |Connection: { connection_id }| TO r_output.
  ENDMETHOD.
ENDCLASS.
