CLASS zcl_2_instances DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_2_instances IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

**********************************************************************
* Creating an Instance of a Class                                    *
**********************************************************************
    DATA connection TYPE REF TO lcl_connection.

    connection = NEW #(  ).
*    connection = NEW lcl_connection(  ).
*    CREATE OBJECT connection.


**********************************************************************
* Access to Instance Attributes and Static Attributes of a Class     *
**********************************************************************
    connection->carrier_id = 'LH'.
    connection->connection_id = '0400'.

    lcl_connection=>conn_counter = 1234.


**********************************************************************
* Creating Multiple Instances of a Class                             *
**********************************************************************
    DATA connection2 TYPE REF TO lcl_connection.

    connection2 = NEW #( ).
    connection2->carrier_id = 'AA'.
    connection2->connection_id = '0017'.


**********************************************************************
* Overwriting and Copying Reference Variables                        *
**********************************************************************
    connection = NEW #( ).
    connection2 = connection.


**********************************************************************
* Storing References in an Internal Table                            *
**********************************************************************
    DATA connections TYPE TABLE OF REF TO lcl_connection.

    connection = NEW #( ).
    connection->carrier_id = 'LH'.
    connection->connection_id = '0400'.
    APPEND connection TO connections.

*    CLEAR connection.

    connection = NEW #( ).
    connection->carrier_id = 'AA'.
    connection->connection_id = '0017'.
    APPEND connection TO connections.

    APPEND NEW #( ) TO connections.
    connections[ lines( connections ) ]->carrier_id = 'SQ'.
    connections[ lines( connections ) ]->connection_id = '0001'.


  ENDMETHOD.

ENDCLASS.
