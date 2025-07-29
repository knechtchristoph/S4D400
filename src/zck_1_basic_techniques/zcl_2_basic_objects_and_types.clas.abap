CLASS zcl_2_basic_objects_and_types DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_2_basic_objects_and_types IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

**********************************************************************
*  Declaration of Variables                                          *
**********************************************************************
    DATA my_var1 TYPE i.
    DATA my_var2 TYPE string.
    DATA my_var3 TYPE string VALUE 'Hello World'.

    "oder:
    "DATA: my_var1 TYPE i,   "Kettensatz
    "      my_var2 TYPE string,
    "      my_var3 TYPE string VALUE 'Hello World'.


**********************************************************************
*  Predefined ABAP Type p                                            *
**********************************************************************
    DATA my_var TYPE p LENGTH 3 DECIMALS 2. "Anzahl Ziffern: 2 * LENGTH - 1,
    "davon DECIMALS Nachkommastellen

    "oder:
    "TYPES my_type TYPE p LENGTH 3 DECIMALS 2.
    "DATA my_var TYPE my_type.


**********************************************************************
*  Data Elements in the ABAP Dictionary                              *
**********************************************************************
    DATA airport TYPE /dmo/airport_id.


**********************************************************************
*  Declaration of Constants                                          *
**********************************************************************
    CONSTANTS my_const1 TYPE i VALUE 12345.
    CONSTANTS my_const2 TYPE string VALUE 'Hello World'.
    CONSTANTS my_const3 TYPE c LENGTH 3 VALUE IS INITIAL.


**********************************************************************
*  Literals in ABAP                                                  *
**********************************************************************
    DATA(my_var4) = 123.
    DATA(my_var5) = -123.
    DATA(my_var6) = 'LH'.
    DATA(my_var7) = '123.45'.
    DATA(my_var8) = `Hello`.
    DATA(my_var9) = `What's up?`.


**********************************************************************
*  Value Assignments and Expressions                                 *
**********************************************************************
*    DATA my_var1 TYPE string.
*    DATA my_var2 TYPE i.
*    DATA my_var3 TYPE i.
*    DATA my_var4 TYPE i.
*
*    my_var1 = `Hello World`.
*    my_var2= 17.
*    my_var3 = my_var2.
*    my_var4 = my_var2 + my_var3.


**********************************************************************
*  Implicit type conversions                                         *
**********************************************************************
    DATA my_int TYPE i.
    DATA my_pack TYPE p LENGTH 8 DECIMALS 2.
    DATA my_char10 TYPE c LENGTH 10 VALUE 'abcdefghij'.
    DATA my_char4 TYPE c LENGTH 4.
    DATA my_string TYPE string.

    my_int = '1234'.                 " C -> I
    my_pack = '-273.15'.             " C -> P

    my_char4 = 'Hugo'.
    my_int = my_char4.               " C -> I, potential runtime error

    my_char4 = my_char10.            " C -> C, potential information loss

    my_string = '  Hello  '.        " C -> STRING, ignores trailing blanks

    DATA my_otherString TYPE string.
    my_otherString = `  Hello  `.


*   exercise related example
    DATA number1 TYPE i.
    DATA number2 TYPE i.

    number1 = -8.
    number2 = 3.

    DATA result1 TYPE i.
    DATA result2 TYPE p LENGTH 8 DECIMALS 2.

    result1 = number1 / number2.
    "or:
    "DATA(result1) = number1 / number2.

    result2 = number1 / number2.

    out->write( result1 ).
    out->write( result2 ).


**********************************************************************
*  Resetting Variables                                               *
**********************************************************************
*    DATA my_var1 TYPE i.
*    DATA my_var2 TYPE i VALUE 1234.
*    DATA my_var3 TYPE string.
*
*    my_var1 = my_var2.
*    my_var3 = `Hello World`.
*
*    CLEAR my_var1.   " value is reset to 0
*    CLEAR my_var2.   " value is reset to 0!
*    CLEAR my_var3.   " String is now empty again


**********************************************************************
*  Inline Declaration in Value Assignments                           *
**********************************************************************
*    DATA my_var1 TYPE string.
*    DATA my_var2 TYPE i.
*    DATA my_var3 TYPE i.
*    DATA my_var4 TYPE i.
*
*    my_var1 = `Hello World`.
*    my_var2 = 17.
*    my_var3 = my_var2.
*    my_var4 = my_var2 + my_var3.
*
*    DATA(my_var1) = `Hello World`.
*    DATA(my_var2) = 17.
*    DATA(my_var3) = my_var2.
*    DATA(my_var4) = my_var2 + my_var3.


  ENDMETHOD.
ENDCLASS.
