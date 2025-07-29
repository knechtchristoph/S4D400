CLASS zcl_1_itab_declaration DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS zcl_1_itab_declaration IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.
**********************************************************************
* Reminder - Simple Internal Tables                                  *
**********************************************************************
*    DATA numbers TYPE TABLE OF i.
*    DATA number  TYPE i VALUE 1234.
*
*    APPEND number TO numbers.
*    APPEND 456    TO numbers.
*    APPEND 12     TO numbers.
*    APPEND 8976   TO numbers.
*
*    out->write( data = numbers
*                name = `Simple Internal Table` ).


    DATA connection TYPE REF TO lcl_connection.
    DATA connections TYPE TABLE OF REF TO lcl_connection.

    TRY.
        connection = NEW #(
          i_carrier_id    = 'JL'
          i_connection_id = '0408' ).

        APPEND connection TO connections.
      CATCH cx_abap_invalid_value.
        out->write( `Creating instance failed` ).
    ENDTRY.


    TRY.
        connection = NEW #(
          i_carrier_id    = 'LH'
          i_connection_id = '0400' ).

        APPEND connection TO connections.
      CATCH cx_abap_invalid_value.
        out->write( `Creating instance failed` ).
    ENDTRY.


    TRY.
        connection = NEW #(
          i_carrier_id    = 'SQ'
          i_connection_id = '0001' ).

        APPEND connection TO connections.
      CATCH cx_abap_invalid_value.
        out->write( `Creating instance failed` ).
    ENDTRY.


    TRY.
        connection = NEW #(
          i_carrier_id    = 'AA'
          i_connection_id = '0017' ).

        APPEND connection TO connections.
      CATCH cx_abap_invalid_value.
        out->write( `Creating instance failed` ).
    ENDTRY.


    TRY.
        connection = NEW #(
          i_carrier_id    = 'XY'
          i_connection_id = '4711' ).

        APPEND connection TO connections.
      CATCH cx_abap_invalid_value.
        out->write( `Creating instance failed` ).
    ENDTRY.


    LOOP AT connections INTO connection.
      out->write( connection->get_output( ) ).
    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
