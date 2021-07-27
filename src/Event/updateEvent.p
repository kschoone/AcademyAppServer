
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

DEFINE INPUT-OUTPUT PARAMETER DATASET FOR dsEvent.

DEFINE VARIABLE oEventBE AS EventBE NO-UNDO.
/* ********************  Preprocessor Definitions  ******************** */


/* ***************************  Main Block  *************************** */

oEventBE = NEW EventBE().

oEventBE:UpdateEventBE(INPUT-OUTPUT DATASET dsEvent).

DELETE OBJECT oEventBE.
