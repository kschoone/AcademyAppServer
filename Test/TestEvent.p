
/*------------------------------------------------------------------------
    File        : TestEvent.p
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : OEAdmin
    Created     : Mon Jul 26 16:24:42 CEST 2021
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

BLOCK-LEVEL ON ERROR UNDO, THROW.

USING Event.EventBE FROM PROPATH.

{dsEvent.i}

DEFINE VARIABLE oEvent AS EventBE NO-UNDO.

/* ********************  Preprocessor Definitions  ******************** */


/* ***************************  Main Block  *************************** */
oEvent = NEW EventBE().
/*TEMP-TABLE ttEvent:TRACKING-CHANGES = TRUE. */
/*CREATE ttEvent.                             */
/*ASSIGN ttEvent.EventName = "Test Event"     */
/*       ttEvent.EventCity = "Amsterdam"      */
/*       ttEvent.EventDate = TODAY.           */
/*TEMP-TABLE ttEvent:TRACKING-CHANGES = FALSE.*/
/*                                            */
/*oEvent:CreateEventBE(DATASET dsEvent).      */

oEvent:ReadEventBE("", DATASET dsEvent).
DISPLAY ttEvent.EventName.      
       
       
       