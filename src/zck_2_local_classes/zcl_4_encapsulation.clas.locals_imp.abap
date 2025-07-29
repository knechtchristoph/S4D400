CLASS lcl_connection DEFINITION.

  PUBLIC SECTION.
    DATA carrier_id TYPE /dmo/carrier_id.
    DATA connection_id TYPE /dmo/connection_id.

    CLASS-DATA conn_counter TYPE i.

**********************************************************************
* Read-only Attributes and Private Attributes                        *
**********************************************************************
*    CLASS-DATA conn_counter TYPE i READ-ONLY.

    METHODS set_attributes
      IMPORTING
        i_carrier_id    TYPE /dmo/carrier_id
        i_connection_id TYPE /dmo/connection_id
      RAISING
        cx_abap_invalid_value.

**********************************************************************
* Example: Constructor Definition and Implementation (Generated)     *
* Adjusting the Generated Constructor                                *
**********************************************************************
*    METHODS constructor
*      IMPORTING
*                i_carrier_id    TYPE /dmo/carrier_id
*                i_connection_id TYPE /dmo/connection_id
*      RAISING   cx_abap_invalid_value.

    METHODS get_output
      RETURNING VALUE(r_output) TYPE string_table.

**********************************************************************
* Static Constructor Definition                                      *
**********************************************************************
    CLASS-METHODS class_constructor.


  PROTECTED SECTION.

  PRIVATE SECTION.

**********************************************************************
* Read-only Attributes and Private Attributes                        *
**********************************************************************
*    DATA carrier_id TYPE /dmo/carrier_id.
*    DATA connection_id TYPE /dmo/connection_id.

ENDCLASS.

CLASS lcl_connection IMPLEMENTATION.

**********************************************************************
* Example: Constructor Definition and Implementation (Generated)     *
* Adjusting the Generated Constructor                                *
**********************************************************************
*  METHOD constructor.
*    IF i_carrier_id IS INITIAL OR i_connection_id IS INITIAL.
*      RAISE EXCEPTION TYPE cx_abap_invalid_value.
*    ENDIF.
*    me->carrier_id = i_carrier_id.
*    me->connection_id = i_connection_id.
*
*    conn_counter = conn_counter + 1.
*  ENDMETHOD.

  METHOD set_attributes.
    IF i_carrier_id IS INITIAL OR i_connection_id IS INITIAL.
      RAISE EXCEPTION TYPE cx_abap_invalid_value.
    ENDIF.
    me->carrier_id = i_carrier_id.
    me->connection_id = i_connection_id.
  ENDMETHOD.

  METHOD get_output.
    APPEND |-----------------------------| TO r_output.
    APPEND |Carrier:    { carrier_id }   | TO r_output.
    APPEND |Connection: { connection_id }| TO r_output.
  ENDMETHOD.


**********************************************************************
* Static Constructor Definition                                      *
**********************************************************************
  METHOD class_constructor.

  ENDMETHOD.
ENDCLASS.
