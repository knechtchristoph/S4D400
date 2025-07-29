CLASS zcl_1_abap_syntax DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_1_abap_syntax IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

******************************************************
*   Examples of ABAP Syntax                          *
******************************************************

    "Examples of ABAP statements
    DATA name TYPE c LENGTH 10.
    DATA text TYPE string.

    name = `World`.
    CONCATENATE `Hello ` name INTO text.
    out->write( `CONCATENATE ``Hello `` name INTO text:` ).
    out->write( text ).


    "Examples of expressions
    name = `SAP`.
    text = replace( val = `Hello World` sub = `World` with = name ).
    out->write( `------------------------------------------` ).
    out->write( `replace( val = ``Hello World`` sub = ``World`` with = name ):` ).
    out->write( text ).

    CLEAR text.
    name = `Walldorf`.
    text = COND #( WHEN text = `` THEN `Hello ` && name ELSE text ).
    out->write( `------------------------------------------` ).
    out->write( `COND #( WHEN text = ```` THEN ``Hello `` && name ELSE text ):` ).
    out->write( text ).

  ENDMETHOD.
ENDCLASS.
