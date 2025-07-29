CLASS zcl_4_encapsulation DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_4_encapsulation IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA connection TYPE REF TO lcl_connection.
    DATA connections TYPE TABLE OF REF TO lcl_connection.

    connection = NEW #( ).

    TRY.
        connection->set_attributes(
          i_carrier_id    = 'LH'
          i_connection_id = '0400'
        ).

        connection->carrier_id = 'XY'.
        connection->connection_id = '0001'.

        lcl_connection=>conn_counter = 4711.

        APPEND connection TO connections.
      CATCH cx_abap_invalid_value.
        out->write( `Method call failed` ).
    ENDTRY.


    TRY.
*        connection = NEW #(
*          i_carrier_id    = 'LH'
*          i_connection_id = '0400' ).

*        connection->set_attributes(
*          i_carrier_id    = 'LH'
*          i_connection_id = '0400'
*        ).

*        connection->carrier_id = 'XY'.
*        connection->connection_id = '0001'.

*        lcl_connection=>conn_counter = 4711.

        APPEND connection TO connections.
      CATCH cx_abap_invalid_value.
        out->write( `Creating instance failed` ).
    ENDTRY.


    LOOP AT connections INTO connection.
      out->write( connection->get_output( ) ).
    ENDLOOP.


  ENDMETHOD.

ENDCLASS.
