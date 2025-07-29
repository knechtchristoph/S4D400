CLASS zcl_1_eml DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_1_eml IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
**********************************************************************
* Reading Data                                                       *
**********************************************************************
    DATA input_keys TYPE TABLE FOR READ IMPORT /DMO/I_AgencyTP.
    DATA result_tab TYPE TABLE FOR READ RESULT /DMO/I_AgencyTP.


**********************************************************************
* Filling the Read Import Table                                      *
**********************************************************************
    input_keys = VALUE #( ( AgencyID = '070050' ) ).


**********************************************************************
* READ ENTITIES Statement                                            *
**********************************************************************
*    READ ENTITIES OF /DMO/I_AgencyTP
*     ENTITY /DMO/Agency
*     ALL FIELDS
*     WITH input_keys
*     RESULT result_tab.
*
*
**    READ ENTITIES OF /DMO/I_AgencyTP
**     ENTITY /DMO/Agency
**     FIELDS ( Name )
**     WITH input_keys
**     RESULT result_tab.


**********************************************************************
* MODIFY ENTITIES Statement                                          *
**********************************************************************
*    DATA update_tab TYPE TABLE FOR UPDATE /DMO/I_AgencyTP.
*
*    update_tab = VALUE #( ( AgencyID = '070050' name = 'Changed agency' ) ).
*
*    MODIFY ENTITIES OF /DMO/I_AgencyTP
*     ENTITY /DMO/Agency
*     UPDATE
*     FIELDS ( Name )
*     WITH update_tab.
*
*    COMMIT ENTITIES.


  ENDMETHOD.
ENDCLASS.
