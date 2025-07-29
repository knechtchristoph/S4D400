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
    DATA airport_from_id TYPE /dmo/airport_from_id.
    DATA airport_to_id TYPE /dmo/airport_to_id.
    DATA carrier_name TYPE /dmo/carrier_name.


**********************************************************************
* Example: Local Structured Type                                     *
**********************************************************************
*    TYPES: BEGIN OF st_connection,
*             airport_from_id TYPE /dmo/airport_from_id,
*             airport_to_id   TYPE /dmo/airport_to_id,
*             carrier_name    TYPE /dmo/carrier_name,
*           END OF st_connection.
*
**    TYPES BEGIN OF st_connection.
**    TYPES airport_from_id TYPE /dmo/airport_from_id.
**    TYPES airport_to_id   TYPE /dmo/airport_to_id.
**    TYPES carrier_name    TYPE /dmo/carrier_name.
**    TYPES  END OF st_connection.
*
*    DATA connection TYPE st_connection.
*
***    DATA: BEGIN OF connection,
***            airport_from_id TYPE /dmo/airport_from_id,
***            airport_to_id   TYPE /dmo/airport_to_id,
***            carrier_name    TYPE /dmo/carrier_name,
***          END OF connection.


ENDCLASS.

CLASS lcl_connection IMPLEMENTATION.

  METHOD constructor.
    IF i_carrier_id IS INITIAL OR i_connection_id IS INITIAL.
      RAISE EXCEPTION TYPE cx_abap_invalid_value.
    ENDIF.

    SELECT SINGLE
        FROM /DMO/I_Connection
        FIELDS DepartureAirport, DestinationAirport, \_Airline-Name
        WHERE AirlineID    = @i_carrier_id
         AND  ConnectionID = @i_connection_id
         INTO ( @airport_from_id, @airport_to_id, @carrier_name ).


**********************************************************************
* Structured Variables                                               *
**********************************************************************
*    DATA connection_full TYPE /DMO/I_Connection.
*
*    SELECT SINGLE
*       FROM /DMO/I_Connection
*       FIELDS AirlineID, ConnectionID, DepartureAirport, DestinationAirport,
*              DepartureTime, ArrivalTime, Distance, DistanceUnit
**       FIELDS *
*       WHERE AirlineID    = @i_carrier_id
*        AND  ConnectionID = @i_connection_id
*        INTO @connection_full.


**********************************************************************
* Global Structured Types                                            *
**********************************************************************
*    DATA message TYPE symsg.


**********************************************************************
* Example: Nested Local Structured Type                              *
**********************************************************************
*    TYPES: BEGIN OF st_nested,
*             airport_from_id TYPE /dmo/airport_from_id,
*             airport_to_id   TYPE /dmo/airport_to_id,
*             message         TYPE symsg,
*             carrier_name    TYPE /dmo/carrier_name,
*           END OF st_nested.
*
*    DATA connection TYPE st_nested.


    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE cx_abap_invalid_value.
    ENDIF.

    me->carrier_id = i_carrier_id.
    me->connection_id = i_connection_id.

    conn_counter = conn_counter + 1.
  ENDMETHOD.


  METHOD get_output.
    APPEND |--------------------------------------------| TO r_output.
    APPEND |Carrier:     { carrier_id } { carrier_name }| TO r_output.
    APPEND |Connection:  { connection_id               }| TO r_output.
    APPEND |Departure:   { airport_from_id             }| TO r_output.
    APPEND |Destination: { airport_to_id               }| TO r_output.
  ENDMETHOD.

ENDCLASS.
