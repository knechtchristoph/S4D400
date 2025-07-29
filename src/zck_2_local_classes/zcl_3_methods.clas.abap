CLASS zcl_3_methods DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_3_methods IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    DATA connection TYPE REF TO lcl_connection.
    DATA connections TYPE TABLE OF REF TO lcl_connection.


**********************************************************************
* Examples for Method Calls                                          *
**********************************************************************
    connection = NEW #( ).

    connection->set_attributes(
      EXPORTING
        i_carrier_id    = 'LH'
        i_connection_id = '0400' ).

*    CALL METHOD connection->set_attributes
*      EXPORTING
*        i_carrier_id    = 'LH'
*        i_connection_id = '0400'.

    DATA carrier_id TYPE /dmo/carrier_id.
    DATA connection_id TYPE /dmo/connection_id.

    connection->get_attributes(
      IMPORTING
        e_carrier_id    = carrier_id
        e_connection_id = connection_id ).

*    CALL METHOD connection->get_attributes
*      IMPORTING
*        e_carrier_id    = carrier_id
*        e_connection_id = connection_id.


**********************************************************************
* Short Forms for Method Calls                                       *
**********************************************************************
    connection->set_attributes(
      EXPORTING
        i_carrier_id    = 'LH'
        i_connection_id = '0400' ).

    connection->set_attributes(
       i_carrier_id    = 'LH'
       i_connection_id = '0400' ).

    connection->set_attributes( '0400' ).


**********************************************************************
* Handling Exceptions Raised by Methods
**********************************************************************
    connection = NEW #( ).
    TRY.
*       connection->carrier_id = 'LH'.
*       connection->connection_id = '0400'.
*        connection->set_attributes(
*        EXPORTING
*          carrier_id    = 'LH'
*          connection_id = '0400'
*        ).
        APPEND connection TO connections.
      CATCH cx_abap_invalid_value.
        out->write( `Method call failed` ).
    ENDTRY.


    connection = NEW #( ).
    TRY.
*       connection->carrier_id = 'AA'.
*       connection->connection_id = '0017'.
*        connection->set_attributes(
*        EXPORTING
*          carrier_id    = 'AA'
*          connection_id = '0017'
*        ).
        APPEND connection TO connections.
      CATCH cx_abap_invalid_value.
        out->write( `Method call failed` ).
    ENDTRY.


**********************************************************************
* Functional Methods                                                 *
**********************************************************************
*    DATA(result) = connection->get_output( ).

    LOOP AT connections INTO connection.
*      out->write( EXPORTING data = connection->get_output( ) ).
*      out->write( data = connection->get_output( ) ).
      out->write( connection->get_output( ) ).
    ENDLOOP.


  ENDMETHOD.

ENDCLASS.
