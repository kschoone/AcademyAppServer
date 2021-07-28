
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
DEFINE INPUT-OUTPUT PARAMETER DATASET FOR dsCustomer.
DEFINE VARIABLE oCustomer AS CustomerBE NO-UNDO.

/* ********************  Preprocessor Definitions  ******************** */


/* ***************************  Main Block  *************************** */
oCustomer = NEW CustomerBE().

oCustomer:CreateCustomerBE(INPUT-OUTPUT DATASET dsCustomer).

DELETE OBJECT oCustomer.