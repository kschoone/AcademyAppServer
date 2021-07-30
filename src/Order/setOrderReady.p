
/*------------------------------------------------------------------------
    File        : setOrderInProcess.p
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : OEAdmin
    Created     : Fri Jul 30 11:50:51 UTC 2021
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

BLOCK-LEVEL ON ERROR UNDO, THROW.

USING Order.OrderBE FROM PROPATH.

DEFINE INPUT  PARAMETER ipiOrderID AS INTEGER NO-UNDO.
DEFINE OUTPUT PARAMETER oplSuccess AS LOGICAL NO-UNDO.
/* ********************  Preprocessor Definitions  ******************** */


/* ***************************  Main Block  *************************** */
DEFINE VARIABLE oOrderBE AS OrderBE NO-UNDO.
/* ********************  Preprocessor Definitions  ******************** */


/* ***************************  Main Block  *************************** */

oOrderBE = NEW OrderBE().

oplSuccess = oOrderBE:setOrderReady(ipiOrderID).

DELETE OBJECT oOrderBE.