
/*------------------------------------------------------------------------
    File        : getStandData.p
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : OEAdmin
    Created     : Tue Jul 27 12:28:46 UTC 2021
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

BLOCK-LEVEL ON ERROR UNDO, THROW.

USING Stand.StandBE FROM PROPATH.

{dsStand.i}

DEFINE INPUT  PARAMETER pFilter AS CHARACTER NO-UNDO.
DEFINE OUTPUT PARAMETER DATASET FOR dsStand.

DEFINE VARIABLE oStandBE AS StandBE NO-UNDO.
/* ********************  Preprocessor Definitions  ******************** */


/* ***************************  Main Block  *************************** */

oStandBE = NEW StandBE().

oStandBE:ReadStandBE(INPUT pFilter, OUTPUT DATASET dsStand).

DELETE OBJECT oStandBE.
