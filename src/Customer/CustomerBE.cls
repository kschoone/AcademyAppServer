 
 /*------------------------------------------------------------------------
    File        : CustomerBE
    Syntax      : 
    Author(s)   : OEAdmin
    Created     : Tue Jul 27 09:17:26 CEST 2021
    Notes       : 
  ----------------------------------------------------------------------*/


USING Progress.Lang.*.
USING OpenEdge.BusinessLogic.BusinessEntity.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Customer.CustomerBE INHERITS BusinessEntity:
    /*------------------------------------------------------------------------------
            Purpose:                                                                      
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    
    {dsCustomer.i}
    
    /* TODO Fill in appropriate datasource tables */ 
    DEFINE DATA-SOURCE srcttCustomer FOR Customer.
    
    /*------------------------------------------------------------------------------
            Purpose:                                                                      
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    CONSTRUCTOR PUBLIC CustomerBE():
        
        DEFINE VARIABLE hDataSourceArray AS HANDLE NO-UNDO EXTENT 1.
        DEFINE VARIABLE cSkipListArray AS CHARACTER NO-UNDO EXTENT 1.
        
        SUPER (DATASET dsCustomer:HANDLE).
        
        /* Data Source for each table in dataset. Should be in table order as defined 
            in DataSet */ 
         hDataSourceArray[1] = DATA-SOURCE srcttCustomer:HANDLE.
                  
         /* Skip-list entry for each table in dataset. Should be in temp-table order 
           as defined in DataSet */
        /* Each skip-list entry is a comma-separated list of field names, to be
            ignored in create stmt */
         
         /* TODO Update cSkipListArray if required by your BusinessEntity */
         cSkipListArray[1] = "CustomerID".
         
         THIS-OBJECT:ProDataSource = hDataSourceArray.
        THIS-OBJECT:SkipList = cSkipListArray.
                 
    END CONSTRUCTOR.
        
    /*------------------------------------------------------------------------------
            Purpose:  Get one or more records, based on a filter string                                                                     
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC VOID ReadCustomerBE(
            INPUT filter AS CHARACTER, 
            OUTPUT DATASET dsCustomer):
        
        SUPER:ReadData(filter).
              
    END METHOD.
      
    /*------------------------------------------------------------------------------
            Purpose: Create one or more new records                                                               
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC VOID CreateCustomerBE(INPUT-OUTPUT DATASET dsCustomer):  
        
        THIS-OBJECT:ValidateCustomer(DATASET dsCustomer BY-REFERENCE) NO-ERROR.
        IF DATASET dsCustomer:ERROR THEN RETURN.
        
        SUPER:CreateData(DATASET dsCustomer BY-REFERENCE).      
  
    END METHOD.    
    
    /*------------------------------------------------------------------------------
            Purpose:  Update one or more records                                                                  
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC VOID UpdateCustomerBE(INPUT-OUTPUT DATASET dsCustomer):
        
        THIS-OBJECT:ValidateCustomer(DATASET dsCustomer BY-REFERENCE) NO-ERROR.
        IF DATASET dsCustomer:ERROR THEN RETURN.
    
        SUPER:UpdateData(DATASET dsCustomer BY-REFERENCE).          
    END METHOD.
    
    /*------------------------------------------------------------------------------
            Purpose:    Delete a record                                                               
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC VOID DeleteCustomerBE(INPUT-OUTPUT DATASET dsCustomer):                    
    
        SUPER:DeleteData(DATASET dsCustomer BY-REFERENCE).
    END METHOD.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/

    METHOD PRIVATE VOID ValidateCustomer(INPUT-OUTPUT DATASET dsCustomer  ):
        FOR EACH ttCustomer:
            IF ttCustomer.Birthdate > TODAY THEN DO:
                ASSIGN BUFFER ttCustomer:REJECTED     = TRUE
                       BUFFER ttCustomer:ERROR-STRING = "Customer can't be born in the future."
                       TEMP-TABLE ttCustomer:ERROR    = TRUE
                       DATASET dsCustomer:ERROR       = TRUE
                       .
                NEXT.
            END.
            
            IF ttCustomer.CustomerName = "" THEN DO:
                ASSIGN BUFFER ttCustomer:REJECTED     = TRUE
                       BUFFER ttCustomer:ERROR-STRING = "Customer needs a name."
                       TEMP-TABLE ttCustomer:ERROR    = TRUE
                       DATASET dsCustomer:ERROR       = TRUE
                       .
                NEXT.
            END.
            IF NOT ttCustomer.Email MATCHES "*@*" THEN DO:     
                ASSIGN BUFFER ttCustomer:REJECTED     = TRUE
                       BUFFER ttCustomer:ERROR-STRING = "Email needs @ to be valid."
                       TEMP-TABLE ttCustomer:ERROR    = TRUE
                       DATASET dsCustomer:ERROR       = TRUE
                       .
                NEXT.
            END.
        END.
        RETURN.

    END METHOD.     
    
END CLASS.
