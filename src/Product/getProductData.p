
/*------------------------------------------------------------------------
    File        : getProductData.p
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : OEAdmin
    Created     : Tue Jul 27 12:21:37 UTC 2021
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

BLOCK-LEVEL ON ERROR UNDO, THROW.

USING Product.ProductBE FROM PROPATH.

{dsProduct.i}

DEFINE INPUT  PARAMETER pFilter AS CHARACTER NO-UNDO.
DEFINE OUTPUT PARAMETER DATASET FOR dsProduct.

DEFINE VARIABLE oProductBE AS ProductBE NO-UNDO.
/* ********************  Preprocessor Definitions  ******************** */


/* ***************************  Main Block  *************************** */

oProductBE = NEW ProductBE().

oProductBE:ReadProductBE(INPUT pFilter, OUTPUT DATASET dsProduct).

DELETE OBJECT oProductBE.
