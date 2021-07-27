
/*------------------------------------------------------------------------
    File        : updateEvent.p
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : OEAdmin
    Created     : Tue Jul 27 09:46:43 UTC 2021
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

BLOCK-LEVEL ON ERROR UNDO, THROW.

USING Event.EventBE FROM PROPATH.

{dsEvent.i}

DEFINE INPUT PARAMETER ipEventID AS INTEGER NO-UNDO.

DEFINE VARIABLE oEventBE AS EventBE NO-UNDO.
DEFINE VARIABLE cFIlter AS CHARACTER NO-UNDO.
/* ********************  Preprocessor Definitions  ******************** */


/* ***************************  Main Block  *************************** */

oEventBE = NEW EventBE().
ASSIGN cFilter = "Event.EventID EQ " + STRING(ipEventID).
oEventBE:ReadEventBE(INPUT cFilter, OUTPUT DATASET dsEvent).

IF NOT CAN-FIND(FIRST ttEvent) THEN RETURN.

oEventBE:DeleteEventBE(INPUT-OUTPUT DATASET dsEvent).

DELETE OBJECT oEventBE.

IF DATASET dsEvent:ERROR THEN DO:
    FIND FIRST ttEvent NO-ERROR.
    RETURN ERROR BUFFER ttEvent:ERROR-STRING.    
END.    

