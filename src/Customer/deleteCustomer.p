
/*------------------------------------------------------------------------
    File        : createCustomer.p
    Purpose     : 

    Syntax      :

    Description : 

    Author(s)   : OEAdmin
    Created     : Wed Jul 28 11:15:30 CEST 2021
    Notes       :
  ----------------------------------------------------------------------*/

/* ***************************  Definitions  ************************** */
USING Customer.CustomerBE FROM PROPATH. 
BLOCK-LEVEL ON ERROR UNDO, THROW.

{dsCustomer.i}
DEFINE INPUT PARAMETER ipCustomerID AS INTEGER NO-UNDO.
DEFINE VARIABLE oCustomer AS CustomerBE NO-UNDO.
DEFINE VARIABLE filter AS CHARACTER NO-UNDO.

/* ********************  Preprocessor Definitions  ******************** */


/* ***************************  Main Block  *************************** */
oCustomer = NEW CustomerBE().

ASSIGN filter = "Customer.CustomerID = " + STRING(ipCustomerID).
oCustomer:ReadCustomerBE  (INPUT filter, OUTPUT DATASET dsCustomer).
oCustomer:DeleteCustomerBE(INPUT-OUTPUT DATASET dsCustomer).

DELETE OBJECT oCustomer.