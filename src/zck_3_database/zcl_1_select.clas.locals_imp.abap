CLASS lcl_connection DEFINITION.

  PUBLIC SECTION.
    CLASS-DATA conn_counter TYPE i READ-ONLY.

    METHODS constructor
      IMPORTING
                i_carrier_id    TYPE /dmo/carrier_id
                i_connection_id TYPE /dmo/connection_id
      RAISING   cx_abap_invalid_value.

    METHODS get_output
      RETURNING VALUE(r_output) TYPE string_table.


  PROTECTED SECTION.

  PRIVATE SECTION.
    DATA carrier_id TYPE /dmo/carrier_id.
    DATA connection_id TYPE /dmo/connection_id.


**********************************************************************
* Example 1: Reading Single Field of Single Record                   *
**********************************************************************
*    DATA airport_from_id TYPE /dmo/airport_from_id.


**********************************************************************
* Example 2: Reading Several Fields of Single Record                 *
**********************************************************************
*    DATA airport_to_id TYPE /dmo/airport_to_id.

ENDCLASS.

CLASS lcl_connection IMPLEMENTATION.

  METHOD constructor.
    IF i_carrier_id IS INITIAL OR i_connection_id IS INITIAL.
      RAISE EXCEPTION TYPE cx_abap_invalid_value.
    ENDIF.


**********************************************************************
* Example 1: Reading Single Field of Single Record                   *
**********************************************************************
*    SELECT SINGLE
*        FROM /dmo/connection
*        FIELDS airport_from_id
*        WHERE carrier_id    = @i_carrier_id
*         AND  connection_id = @i_connection_id
*         INTO @airport_from_id.


**********************************************************************
* Example 2: Reading Several Fields of Single Record                 *
**********************************************************************
*    SELECT SINGLE
*        FROM /dmo/connection
*        FIELDS airport_from_id, airport_to_id
*        WHERE carrier_id    = @i_carrier_id
*         AND  connection_id = @i_connection_id
*         INTO ( @airport_from_id, @airport_to_id ).


**********************************************************************
* Handling Empty Results                                             *
**********************************************************************
*    IF sy-subrc <> 0.
*      RAISE EXCEPTION TYPE cx_abap_invalid_value.
*    ENDIF.


    me->carrier_id = i_carrier_id.
    me->connection_id = i_connection_id.

    conn_counter = conn_counter + 1.
  ENDMETHOD.


  METHOD get_output.
    APPEND |--------------------------------| TO r_output.
    APPEND |Carrier:     { carrier_id      }| TO r_output.
    APPEND |Connection:  { connection_id   }| TO r_output.


**********************************************************************
* Example 1: Reading Single Field of Single Record                   *
**********************************************************************
*    APPEND |Departure:   { airport_from_id }| TO r_output.


**********************************************************************
* Example 2: Reading Several Fields of Single Record                 *
**********************************************************************
*    APPEND |Destination: { airport_to_id   }| TO r_output.


  ENDMETHOD.


ENDCLASS.
