CLASS lcl_connection DEFINITION.

  PUBLIC SECTION.
**********************************************************************
* Exercise: Use a Complex Internal Table                             *
**********************************************************************
*    CLASS-METHODS class_constructor.


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

    TYPES tt_connections TYPE STANDARD TABLE OF st_connection
                    WITH NON-UNIQUE KEY carrier_id
                                        connection_id.

    DATA connection TYPE st_connection.


**********************************************************************
* APPEND for Complex Internal Tables - Declaration of a Work Area    *
**********************************************************************
*    DATA connections TYPE tt_connections.
*    DATA connection LIKE LINE OF connections.


**********************************************************************
* Filling an Internal Table with Several Rows                        *
**********************************************************************
*    TYPES: BEGIN OF st_carrier,
*             carrier_id    TYPE /dmo/carrier_id,
*             carrier_name  TYPE /dmo/carrier_name,
*             currency_code TYPE /dmo/currency_code,
*           END OF st_carrier.
*
*    TYPES tt_carriers TYPE STANDARD TABLE OF st_carrier
*                   WITH NON-UNIQUE KEY carrier_id.
*
*    DATA carriers TYPE tt_carriers.


**********************************************************************
* Updating a Table Row with Key Access                               *
**********************************************************************
*    DATA carrier LIKE LINE OF carriers.


**********************************************************************
* Exercise: Use a Complex Internal Table                             *
**********************************************************************
*    TYPES: BEGIN OF st_airport,
*             AirportID TYPE /dmo/airport_id,
*             Name      TYPE /dmo/airport_name,
*           END OF st_airport.
*
*    TYPES tt_airports TYPE STANDARD TABLE OF st_airport
*                           WITH NON-UNIQUE DEFAULT KEY.
*
*    CLASS-DATA airports TYPE tt_airports.

ENDCLASS.


CLASS lcl_connection IMPLEMENTATION.
**********************************************************************
* Exercise: Use a Complex Internal Table                             *
**********************************************************************
*  METHOD class_constructor.
*    SELECT
*      FROM /DMO/I_Airport
*      FIELDS AirportID, Name
*      INTO TABLE @airports.
*  ENDMETHOD.


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
* APPEND for Complex Internal Tables - Declaration of a Work Area    *
**********************************************************************
*    APPEND connection TO connections.


**********************************************************************
* APPEND for Complex Internal Tables - Filling the Work Area         *
**********************************************************************
*    connection = VALUE #( carrier_id      = 'NN' connection_id  = '1234'
*                          airport_from_id = 'ABC' airport_to_id = 'XYZ'
*                          carrier_name    = 'My Airline' ).
*    APPEND connection TO connections.


**********************************************************************
* APPEND for Complex Internal Tables - direct use of VALUE #( )      *
**********************************************************************
*    APPEND VALUE #( carrier_id      = 'NN' connection_id  = '1234'
*                    airport_from_id = 'ABC' airport_to_id = 'XYZ'
*                    carrier_name    = 'My Airline' )
*        TO connections.


**********************************************************************
* Filling an Internal Table with Several Rows                        *
**********************************************************************
*    carriers = VALUE #( ( carrier_id = 'AA' carrier_name = 'American Airlines' )
*                        ( carrier_id = 'JL' carrier_name = 'Japan Airlines' )
*                        ( carrier_id = 'NN' carrier_name = 'My Airline' )
*                       ).
*
**    carriers = VALUE #( BASE carriers
**                        ( carrier_id = 'AA' carrier_name = 'American Airlines' )
**                        ( carrier_id = 'JL' carrier_name = 'Japan Airlines' )
**                        ( carrier_id = 'NN' carrier_name = 'My Airline' )
**                       ).


**********************************************************************
* Filling one Internal Table from Another                            *
**********************************************************************
*    connections = CORRESPONDING #( carriers ).
*
**    connections = CORRESPONDING #( BASE ( connections ) carriers ).


**********************************************************************
* Internal Table Expressions with Key Access                         *
**********************************************************************
*    CLEAR: connections, connection.
*
*    connections = VALUE #( ( carrier_id      = 'JL'  connection_id = '0408'
*                             airport_from_id = 'FRA' airport_to_id = 'NRT'
*                             carrier_name    = 'Japan Airlines' )
*
*                           ( carrier_id      = 'AA'  connection_id = '0017'
*                             airport_from_id = 'MIA' airport_to_id = 'HAV'
*                             carrier_name    = 'American Airlines' )
*
*                           ( carrier_id      = 'SQ'  connection_id = '0001'
*                             airport_from_id = 'SFO' airport_to_id = 'SIN'
*                             carrier_name    = 'Singapore Airlines' )
*
*                           ( carrier_id      = 'UA' connection_id  = '0078'
*                             airport_from_id = 'SFO' airport_to_id = 'SIN'
*                             carrier_name    = 'United Airlines' )
*                         ).
*
*    connection = connections[ airport_from_id = 'SFO' airport_to_id = 'SIN' ].
*
**    TRY.
**        connection = connections[ airport_from_id = 'AAA' airport_to_id = 'ZZZ' ].
**      CATCH cx_sy_itab_line_not_found.
**        "nothing found
**    ENDTRY.


**********************************************************************
* LOOP ... ENDLOOP with Key Access                                   *
**********************************************************************
*    LOOP AT connections INTO connection
*                        WHERE airport_from_id <> 'MIA'.
*
*    ENDLOOP.


**********************************************************************
* Updating a Table Row with Key Access                               *
**********************************************************************
*    CLEAR: carriers, carrier.
*    carriers = VALUE #( ( carrier_id = 'SQ' carrier_name = 'Singapore Airlines' )
*                        ( carrier_id = 'JL' carrier_name = 'Japan Airlines' )
*                        ( carrier_id = 'AA' carrier_name = 'American Airlines' )
*                        ( carrier_id = 'UA' carrier_name = 'United Airlines' )
*                       ).
*
*    carrier = carriers[ carrier_id = 'JL' ].
*    carrier-currency_code = 'JPY'.
*
*    MODIFY TABLE carriers FROM carrier.
*
*
**    ASSIGN carriers[ carrier_id = 'JL' ] TO FIELD-SYMBOL(<fs>).
**    IF sy-subrc = 0.
**      <fs>-currency_code = 'JPY'.
**    ENDIF.


**********************************************************************
* Updating a Table Row with Index Access                             *
**********************************************************************
*    CLEAR: carriers, carrier.
*    carriers = VALUE #( ( carrier_id = 'LH' carrier_name = 'Lufthansa' )
*                        ( carrier_id = 'JL' carrier_name = 'Japan Airlines' )
*                        ( carrier_id = 'AA' carrier_name = 'American Airlines' )
*                        ( carrier_id = 'UA' carrier_name = 'United Airlines' )
*                       ).
*
*    carrier-carrier_id = 'LH'.
*    carrier-currency_code = 'EUR'.
*
*    MODIFY carriers FROM carrier INDEX 1.
*
*
**    carriers[ 1 ] = carrier.
*
*
**    MODIFY carriers FROM carrier INDEX 1 TRANSPORTING currency_code.


**********************************************************************
* Updating Multiple Table Rows in a LOOP                             *
**********************************************************************
*    CLEAR: carriers, carrier.
*    carriers = VALUE #( ( carrier_id = 'LH' carrier_name = 'Lufthansa' currency_code = 'EUR' )
*                        ( carrier_id = 'JL' carrier_name = 'Japan Airlines' currency_code = 'JPY' )
*                        ( carrier_id = 'AA' carrier_name = 'American Airlines' )
*                        ( carrier_id = 'UA' carrier_name = 'United Airlines' )
*                       ).
*
*    LOOP AT carriers INTO carrier
*                     WHERE currency_code IS INITIAL.
*
*      carrier-currency_code = 'USD'.
*      MODIFY carriers FROM carrier.
*
**      carriers[ sy-tabix ] = carrier.
*
**      MODIFY carriers FROM carrier TRANSPORTING currency_code.
*
*    ENDLOOP.


**********************************************************************
* Reminder: Structured Variables in SELECT SINGLE ... INTO ...       *
**********************************************************************
*    DATA airport_full TYPE /DMO/I_Airport.
*
*    SELECT SINGLE
*        FROM /DMO/I_Airport
*        FIELDS AirportID, Name, City, CountryCode
*        WHERE City = 'Zurich'
*        INTO @airport_full.


**********************************************************************
* Internal Table in SELECT ... INTO TABLE ...                        *
**********************************************************************
*    DATA airports_full TYPE STANDARD TABLE OF /DMO/I_Airport
*                            WITH NON-UNIQUE KEY AirportID.
*
*    SELECT
*        FROM /DMO/I_Airport
*        FIELDS AirportID, Name, City, CountryCode
*        WHERE City = 'London'
*        INTO TABLE @airports_full.


**********************************************************************
* FIELDS * and INTO CORRESPONDING FIELDS OF TABLE                    *
**********************************************************************
*    TYPES: BEGIN OF st_airport,
*             AirportID TYPE /dmo/airport_id,
*             Name      TYPE /dmo/airport_name,
*           END OF st_airport.
*
*    DATA airports TYPE STANDARD TABLE OF st_airport
*                       WITH NON-UNIQUE KEY AirportID.
*
*    SELECT
*        FROM /DMO/I_Airport
*        FIELDS *
*        WHERE City = 'London'
*        INTO CORRESPONDING FIELDS OF TABLE @airports.


**********************************************************************
* Inline Declaration after INTO TABLE                                *
**********************************************************************
*    SELECT
*        FROM /DMO/I_Airport
*        FIELDS AirportID, Name AS AirportName
*        WHERE City = 'London'
*        INTO TABLE @DATA(airports_inline).


**********************************************************************
* Example: UNION ALL of Two SELECTS                                  *
**********************************************************************
*    SELECT
*        FROM /DMO/I_Carrier
*        FIELDS 'Airline' AS type, AirlineID AS id, Name
*        WHERE CurrencyCode = 'GBP'
*
*    UNION ALL
*
*    SELECT
*        FROM /DMO/I_Airport
*        FIELDS 'Airport' AS type, AirportID AS id, Name
*        WHERE  City = 'London'
*
*    INTO TABLE @DATA(Names).


  ENDMETHOD.

  METHOD get_output.
    APPEND |------------------------------------------------------------------| TO r_output.
    APPEND |Carrier:     { connection-carrier_id } { connection-carrier_name }| TO r_output.
    APPEND |Connection:  { connection-connection_id                          }| TO r_output.
    APPEND |Departure:   { connection-airport_from_id                        }| TO r_output.
    APPEND |Destination: { connection-airport_to_id                          }| TO r_output.
  ENDMETHOD.

ENDCLASS.
