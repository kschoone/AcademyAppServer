
/*------------------------------------------------------------------------
    File        : deleteProduct.p
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : OEAdmin
    Created     : Wed Jul 28 09:37:42 UTC 2021
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */

BLOCK-LEVEL ON ERROR UNDO, THROW.

USING Product.ProductBE FROM PROPATH.

{dsProduct.i}

DEFINE VARIABLE oProductBE AS ProductBE NO-UNDO.


/* ********************  Preprocessor Definitions  ******************** */


/* ***************************  Main Block  *************************** */

oProductBE = NEW ProductBE().

oProductBE:DeleteProductBE(INPUT-OUTPUT DATASET dsProduct).

DELETE OBJECT oProductBE.
