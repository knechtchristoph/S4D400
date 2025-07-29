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
    TYPES: BEGIN OF st_connection,
             carrier_id      TYPE /dmo/carrier_id,
             connection_id   TYPE /dmo/connection_id,
             airport_from_id TYPE /dmo/airport_from_id,
             airport_to_id   TYPE /dmo/airport_to_id,
             carrier_name    TYPE /dmo/carrier_name,
           END OF st_connection.

    DATA connection TYPE st_connection.


**********************************************************************
* Internal Tables with Structured Row Type                           *
**********************************************************************
*    DATA connections TYPE TABLE OF st_connection.


**********************************************************************
* Examples - Complex Internal Tables                                 *
**********************************************************************
*    DATA connections_1 TYPE TABLE OF st_connection.
*
*    DATA connections_2 TYPE STANDARD TABLE OF st_connection
*                WITH NON-UNIQUE DEFAULT KEY.
*
*    DATA connections_3 TYPE SORTED TABLE OF st_connection
*                WITH NON-UNIQUE KEY airport_from_id
*                                    airport_to_id.
*
*    DATA connections_4 TYPE HASHED TABLE OF st_connection
*                WITH UNIQUE KEY carrier_id
*                                connection_id.


**********************************************************************
* Defining Table Types Locally                                       *
**********************************************************************
*    TYPES tt_connections TYPE SORTED TABLE OF st_connection
*                    WITH UNIQUE KEY carrier_id
*                                    connection_id.
*
*    DATA connections_5 TYPE tt_connections.


**********************************************************************
* Global Table Types                                                 *
**********************************************************************
*    DATA connections_6 TYPE zck_t_connection.
*
*    DATA connections_7 TYPE /dmo/t_flight.

ENDCLASS.


CLASS lcl_connection IMPLEMENTATION.

  METHOD constructor.
    IF i_carrier_id IS INITIAL OR i_connection_id IS INITIAL.
      RAISE EXCEPTION TYPE cx_abap_invalid_value.
    ENDIF.

    SELECT SINGLE
         FROM /DMO/I_Connection
         FIELDS AirlineID AS carrier_id,
                ConnectionID AS connection_id,
                DepartureAirport AS airport_from_id,
                DestinationAirport AS airport_to_id,
                \_Airline-Name   AS carrier_name
         WHERE AirlineID    = @i_carrier_id
          AND  ConnectionID = @i_connection_id
          INTO CORRESPONDING FIELDS OF @connection.

    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE cx_abap_invalid_value.
    ENDIF.

    conn_counter = conn_counter + 1.


**********************************************************************
* Addressing Internal Tables - Index Access and Key Access           *
**********************************************************************
*    connection = VALUE #( carrier_id      = 'JL'  connection_id = '0408'
*                          airport_from_id = 'FRA' airport_to_id = 'NRT'
*                          carrier_name    = 'Japan Airlines Co., Ltd.' ).
*    APPEND connection TO connections.
*
*    connection = VALUE #( carrier_id      = 'AA'  connection_id = '0017'
*                          airport_from_id = 'MIA' airport_to_id = 'HAV'
*                          carrier_name    = 'American Airlines Inc.' ).
*    APPEND connection TO connections.
*
*    connection = VALUE #( carrier_id      = 'SQ'  connection_id = '0001'
*                          airport_from_id = 'SFO' airport_to_id = 'SIN'
*                          carrier_name    = 'Singapore Airlines Limited' ).
*    APPEND connection TO connections.
*
*    connection = VALUE #( carrier_id      = 'LH' connection_id  = '0400'
*                          airport_from_id = 'FRA' airport_to_id = 'JFK'
*                          carrier_name    = 'Deutsche Lufthansa AG' ).
*    APPEND connection TO connections.
*
*
*    connection = connections[ 3 ].
*    connection = connections[ airport_from_id = 'SFO' airport_to_id = 'SIN' ].
  ENDMETHOD.

  METHOD get_output.
    APPEND |------------------------------------------------------------------| TO r_output.
    APPEND |Carrier:     { connection-carrier_id } { connection-carrier_name }| TO r_output.
    APPEND |Connection:  { connection-connection_id                          }| TO r_output.
    APPEND |Departure:   { connection-airport_from_id                        }| TO r_output.
    APPEND |Destination: { connection-airport_to_id                          }| TO r_output.
  ENDMETHOD.

ENDCLASS.
