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
* Accessing Structure Components                                     *
**********************************************************************
*    TYPES: BEGIN OF st_connection,
*             airport_from_id TYPE /dmo/airport_from_id,
*             airport_to_id   TYPE /dmo/airport_to_id,
*             carrier_name    TYPE /dmo/carrier_name,
*           END OF st_connection.
*
*    DATA connection TYPE st_connection.


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
* Accessing the Sub-Components of Nested Structures                  *
**********************************************************************
*    TYPES: BEGIN OF st_connection_nested,
*             airport_from_id TYPE /dmo/airport_from_id,
*             airport_to_id   TYPE /dmo/airport_to_id,
*             message         TYPE symsg,
*             carrier_name    TYPE /dmo/carrier_name,
*           END OF st_connection_nested.
*
*    DATA connection_nested TYPE st_connection_nested.
*
*    connection_nested-message-msgty = 'E'.
*    connection_nested-message-msgid = 'ABC'.
*    connection_nested-message-msgno = '123'.


**********************************************************************
* Filling a Whole Structure with One Assignment                      *
**********************************************************************
*    connection_nested = VALUE #( airport_from_id = 'ABC'
*                                 airport_to_id = 'XYZ'
*                                 carrier_name = 'My Airline'
*                                 message = VALUE #( msgty = 'E'
*                                                    msgid = 'ABC'
*                                                    msgno = '123'
*                                                   )
*                                ).


**********************************************************************
* Value Assignment Between Structures                                *
**********************************************************************
*    connection-airport_from_id = 'ABC'.
*    connection-airport_to_id = 'XYZ'.
*    connection-carrier_name = 'My Airline'.
*
*    connection_nested-carrier_name = 'Other Airline'.
*
*    connection_nested = connection.


**********************************************************************
* Component-Based Value Assignment                                   *
**********************************************************************
*    connection-airport_from_id = 'ABC'.
*    connection-airport_to_id = 'XYZ'.
*    connection-carrier_name = 'My Airline'.
*
*    connection_nested-carrier_name = 'Other Airline'.
*
*    connection_nested = CORRESPONDING #( connection ).


**********************************************************************
* Correspondence Between Fields and INTO                             *
**********************************************************************
*    SELECT SINGLE
*      FROM /DMO/I_Connection
*      FIELDS DepartureAirport, DestinationAirport, \_Airline-Name
*      WHERE AirlineID    = @i_carrier_id
*       AND  ConnectionID = @i_connection_id
*       INTO @connection.


**********************************************************************
* FIELDS * to Read All Fields from a Data Source                     *
**********************************************************************
*    DATA connection_full TYPE /DMO/I_Connection.
*
*    SELECT SINGLE
*         FROM /DMO/I_Connection
*         FIELDS *
*         WHERE AirlineID    = @i_carrier_id
*          AND  ConnectionID = @i_connection_id
*          INTO @connection_full.


**********************************************************************
* INTO CORRESPONDING FIELDS OF                                       *
* to Read Only Fields with Corresponding Names                       *
**********************************************************************
*    TYPES: BEGIN OF st_connection_short,
*             DepartureAirport   TYPE /dmo/airport_from_id,
*             DestinationAirport TYPE /dmo/airport_to_id,
*           END OF st_connection_short.
*
*    DATA connection_short TYPE st_connection_short.
*
*    SELECT SINGLE
*         FROM /DMO/I_Connection
*         FIELDS *
*         WHERE AirlineID    = @i_carrier_id
*          AND  ConnectionID = @i_connection_id
*          INTO CORRESPONDING FIELDS OF @connection_short.


**********************************************************************
* Alias Names for Fields                                             *
**********************************************************************
*    SELECT SINGLE
*         FROM /DMO/I_Connection
*         FIELDS DepartureAirport AS airport_from_id,
*                \_Airline-Name   AS carrier_name
*         WHERE AirlineID    = @i_carrier_id
*          AND  ConnectionID = @i_connection_id
*          INTO CORRESPONDING FIELDS OF @connection.


**********************************************************************
* Inline Declarations in INTO Clauses                                *
**********************************************************************
*    SELECT SINGLE
*         FROM /DMO/I_Connection
*         FIELDS DepartureAirport,
*                DestinationAirport AS ArrivalAirport,
*                \_Airline-Name AS AirlineName
*         WHERE AirlineID    = @i_carrier_id
*          AND  ConnectionID = @i_connection_id
*          INTO @DATA(connection_inline).


**********************************************************************
* Example: Join Syntax in ABAP SQL                                   *
**********************************************************************
*    SELECT SINGLE
*        FROM /dmo/connection AS c
*        LEFT OUTER JOIN /dmo/airport AS f
*        ON c~airport_from_id = f~airport_id
*
*        FIELDS c~carrier_id, c~connection_id, c~airport_from_id, c~airport_to_id,
*               f~name AS airport_from_name
*
*        WHERE c~carrier_id    = @i_carrier_id
*         AND  c~connection_id = @i_connection_id
*
*         INTO @DATA(connection_join).


**********************************************************************
* Example: Nested Join                                               *
**********************************************************************
*    SELECT SINGLE
*        FROM ( /dmo/connection AS c
*        LEFT OUTER JOIN /dmo/airport AS f
*        ON c~airport_from_id = f~airport_id )
*
*        LEFT OUTER JOIN /dmo/airport AS t
*        ON c~airport_to_id = t~airport_id
*
*        FIELDS c~carrier_id, c~connection_id, c~airport_from_id, c~airport_to_id,
*               f~name AS airport_from_name,
*               t~name AS airport_to_name
*
*        WHERE c~carrier_id    = @i_carrier_id
*         AND  c~connection_id = @i_connection_id
*
*         INTO @DATA(connection_join).


    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE cx_abap_invalid_value.
    ENDIF.

    me->carrier_id = i_carrier_id.
    me->connection_id = i_connection_id.

    conn_counter = conn_counter + 1.
  ENDMETHOD.


  METHOD get_output.
**********************************************************************
* Accessing Structure Components                                     *
**********************************************************************
*    connection-airport_from_id = 'ABC'.
*    connection-airport_to_id = 'XYZ'.
*    connection-carrier_name = 'My Airline'.
*
*    APPEND |-------------------------------------------------------| TO r_output.
*    APPEND |Carrier:     { carrier_id } { connection-carrier_name }| TO r_output.
*    APPEND |Connection:  { connection_id                          }| TO r_output.
*    APPEND |Departure:   { connection-airport_from_id             }| TO r_output.
*    APPEND |Destination: { connection-airport_to_id               }| TO r_output.


**********************************************************************
* Filling a Whole Structure with One Assignment                      *
**********************************************************************
*    connection = VALUE #( airport_from_id = 'ABC'
*                          airport_to_id = 'XYZ'
*                          carrier_name = 'My Airline' ).


    APPEND |--------------------------------------------| TO r_output.
    APPEND |Carrier:     { carrier_id } { carrier_name }| TO r_output.
    APPEND |Connection:  { connection_id               }| TO r_output.
    APPEND |Departure:   { airport_from_id             }| TO r_output.
    APPEND |Destination: { airport_to_id               }| TO r_output.

  ENDMETHOD.

ENDCLASS.
