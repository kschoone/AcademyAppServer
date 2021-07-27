/* ***************************  Definitions  ************************** */

BLOCK-LEVEL ON ERROR UNDO, THROW.

USING Customer.CustomerBE FROM PROPATH.

{dsCustomer.i}

DEFINE INPUT  PARAMETER filter AS CHARACTER NO-UNDO.
DEFINE OUTPUT PARAMETER DATASET FOR dsCustomer.

DEFINE VARIABLE oCustomerBE AS CustomerBE NO-UNDO.
/* ********************  Preprocessor Definitions  ******************** */


/* ***************************  Main Block  *************************** */

oCustomerBE = NEW CustomerBE().

oCustomerBE:ReadCustomerBE(INPUT filter, OUTPUT DATASET dsCustomer).

DELETE OBJECT oCustomerBE.
