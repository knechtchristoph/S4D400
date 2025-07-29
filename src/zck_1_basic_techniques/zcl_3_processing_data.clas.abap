CLASS zcl_3_processing_data DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_3_processing_data IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

**********************************************************************
* Arithmetic Expressions                                             *
**********************************************************************
    out->write( sqrt( 16 ) ).
    out->write( ipow( base = '1.3' exp = 2  ) ).


**********************************************************************
* String Templates                                                   *
**********************************************************************
    out->write( |Wurzel aus 16 ist { sqrt( 16 ) }.| ).
*    out->write( |Wurzel aus 16 ist { sqrt( 16 ) STYLE = SCIENTIFIC }.| ).
    out->write( |1.3 ** 2 = { ipow( base = '1.3' exp = 2  ) }| ).
*    out->write( |1.3 ** 2 = { ipow( base = '1.3' exp = 2  ) DECIMALS  = 2 }| ).


**********************************************************************
* Format Options in String Templates                                 *
**********************************************************************
    DATA the_date TYPE d VALUE '19891130'.
    out->write( |{ the_date } | ).
    out->write( |{ the_date DATE = ISO } | ).
    out->write( |{ the_date DATE = USER } | ).

    DATA my_number TYPE p LENGTH 3 DECIMALS 2 VALUE '-273.15'.
    out->write( |{ my_number } | ).
    out->write( |{ my_number NUMBER = USER } | ).
    out->write( |{ my_number SIGN = RIGHT } | ).
    out->write( |{ my_number STYLE = SCIENTIFIC } | ).


**********************************************************************
* Joining Strings
**********************************************************************
    DATA resultA TYPE string.
    DATA resultB TYPE string.
    DATA part1 TYPE string VALUE `Hello`.
    DATA part2 TYPE string VALUE `World`.

    resultA = part1 && part2.
    resultB = part1 && | | && part2.

    out->write( resultA ).
    out->write( resultB ).


  ENDMETHOD.
ENDCLASS.
