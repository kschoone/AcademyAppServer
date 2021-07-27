/* ***************************  Definitions  ************************** */

BLOCK-LEVEL ON ERROR UNDO, THROW.

USING Employee.EmployeeBE FROM PROPATH.

{dsEmployee.i}

DEFINE INPUT  PARAMETER filter AS CHARACTER NO-UNDO.
DEFINE OUTPUT PARAMETER DATASET FOR dsEmployee.

DEFINE VARIABLE oEmployeeBE AS EmployeeBE NO-UNDO.
/* ********************  Preprocessor Definitions  ******************** */


/* ***************************  Main Block  *************************** */

oEmployeeBE = NEW EmployeeBE().

oEmployeeBE:ReadEmployeeBE(INPUT filter, OUTPUT DATASET dsEmployee).

DELETE OBJECT oEmployeeBE.
