CLASS zcl_5_internal_tables DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_5_internal_tables IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

**********************************************************************
* Internal Tables                                                    *
**********************************************************************
    DATA numbers TYPE TABLE OF i.
    DATA number TYPE i VALUE 1234.

    APPEND number     TO numbers.
    APPEND 2 * number TO numbers.
    APPEND 456        TO numbers.
    APPEND 12         TO numbers.
    APPEND 8976       TO numbers.

*    INSERT 7 INTO numbers INDEX 2.

    out->write( name = `Internal Tables` data = numbers ).

*    CLEAR numbers.


**********************************************************************
* Table Types                                                        *
**********************************************************************
    "lokale Tabellentypen
    TYPES t_names TYPE TABLE OF string.
    DATA names TYPE t_names.
*    DATA names TYPE TABLE OF string.

    TYPES t_percent TYPE p LENGTH 3 DECIMALS 2.
    TYPES t_percentage TYPE TABLE OF t_percent.
    DATA percentages1 TYPE t_percentage.

    "globale Tabellentypen
    DATA percentages2 TYPE zck_t_percentage.

    DATA flights TYPE /dmo/t_flight.


**********************************************************************
* Retrieve a Single Row from an Internal Table                       *
**********************************************************************
    DATA(no_of_lines) = lines( numbers ).
    IF no_of_lines >= 2.
      number = numbers[ 2 ].
      out->write( name = `Retrieve a Single Row from an Internal Table`
                  data = |numbers[ 2 ] = { number }| ).
    ENDIF.


**********************************************************************
* Reading from an Internal Table in a Loop
**********************************************************************
    out->write( name = `Reading from an Internal Table in a Loop`
                data = `Explicit Declaration` ).
    LOOP AT numbers INTO number.
      out->write( |{ number WIDTH = 4 ALIGN = RIGHT }| ).
    ENDLOOP.

    out->write( name = `Reading from an Internal Table in a Loop`
                data = `Implicit Declaration` ).
    LOOP AT numbers INTO DATA(work_area).
      out->write( |{ work_area }| ).
    ENDLOOP.


  ENDMETHOD.
ENDCLASS.
