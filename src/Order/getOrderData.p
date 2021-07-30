
/*------------------------------------------------------------------------
    File        : getEventData.p
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : OEAdmin
    Created     : Tue Jul 27 09:46:43 UTC 2021
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

BLOCK-LEVEL ON ERROR UNDO, THROW.

USING Order.OrderBE FROM PROPATH.

{dsOrderOrderLine.i}

DEFINE INPUT  PARAMETER filter AS CHARACTER NO-UNDO.
DEFINE OUTPUT PARAMETER DATASET FOR dsOrderOrderLine.

DEFINE VARIABLE oOrderBE AS OrderBE NO-UNDO.
/* ********************  Preprocessor Definitions  ******************** */


/* ***************************  Main Block  *************************** */

oOrderBE = NEW OrderBE().

oOrderBE:ReadOrderBE(INPUT filter, OUTPUT DATASET dsOrderOrderLine).

DELETE OBJECT oOrderBE.
