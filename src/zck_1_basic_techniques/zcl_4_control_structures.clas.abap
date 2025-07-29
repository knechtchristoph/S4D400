CLASS zcl_4_control_structures DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_4_control_structures IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

**********************************************************************
*  Branching with Freely Defined Conditions                          *
**********************************************************************
    DATA number TYPE i.
    number = 3.

    IF number = 1.
      out->write( `1` ).
    ELSEIF number = 2.
      out->write( `2` ).
    ELSEIF number = 3.
      out->write( `3` ).
    ELSE.
      out->write( `else` ).
    ENDIF.

    IF number IS INITIAL.
      out->write( |'number' is initial| ).
    ELSE.
      out->write( |'number' is not initial| ).
    ENDIF.


**********************************************************************
* Branching with Equals Comparisons
**********************************************************************
    CASE number.
      WHEN 1.
        out->write( `1` ).
      WHEN 2.
        out->write( `2` ).
      WHEN 3.
        out->write( `3` ).
      WHEN OTHERS.
        out->write( `others` ).
    ENDCASE.

    out->write(
        SWITCH #( number
                       WHEN 1 THEN `1`
                       WHEN 2 THEN `2`
                       WHEN 3 THEN `3`
                       ELSE  `others` ) ).


**********************************************************************
* Some Examples of Catchable System Exceptions
**********************************************************************
*    DATA result TYPE i.
*    DATA numerator TYPE i VALUE 1.
*    DATA denominator TYPE i VALUE 0.
*
*    result = numerator / denominator.

    "---------------------------------------
*    DATA target TYPE i.
*    DATA source TYPE string VALUE `ABC`.
*
*    target = source.

    "---------------------------------------
*    DATA numbers TYPE TABLE OF i.
*
*    CLEAR numbers.
*    out->write( numbers[ 1 ] ).


**********************************************************************
* Example: Exception Handling
**********************************************************************
*    DATA result TYPE i.
*    DATA numerator TYPE i VALUE 1.
*    DATA denominator TYPE i VALUE 0.
*
*    TRY.
*        result = numerator / denominator.
*        out->write( |Result: { result }| ).
*      CATCH cx_sy_zerodivide.
*        out->write( `not possible` ).
*    ENDTRY.
*
*    out->write( `End of this demo` ).


**********************************************************************
* Iterations in ABAP
**********************************************************************
    out->write( `DO 5 TIMES - simple` ).
    DO 5 TIMES.
      out->write( |Durchlauf: { sy-index }| ).
    ENDDO.

    "---------------------------------------
    out->write( `DO 5 TIMES - with CHECK` ).
    DO 5 TIMES.
      CHECK sy-index <> 3.
      out->write( |Durchlauf: { sy-index }| ).
    ENDDO.

    "---------------------------------------
    out->write( `DO - with EXIT` ).
    DO.
      out->write( |Durchlauf: { sy-index }| ).
      IF sy-index = 3. EXIT. ENDIF.
    ENDDO.

    "---------------------------------------
    out->write( `WHILE` ).
    DATA counter TYPE i VALUE 0.
    WHILE counter < 5.
      out->write( |Durchlauf: { sy-index }| ).
      counter += 1.
    ENDWHILE.


  ENDMETHOD.
ENDCLASS.
