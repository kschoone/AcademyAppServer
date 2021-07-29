 
 /*------------------------------------------------------------------------
    File        : OrderDA
    Syntax      : 
    Author(s)   : OEAdmin
    Created     : Thu Jul 29 11:17:51 CEST 2021
    Notes       : 
  ----------------------------------------------------------------------*/


USING Progress.Lang.*.
USING OpenEdge.BusinessLogic.BusinessEntity.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Order.OrderDA INHERITS BusinessEntity:
    /*------------------------------------------------------------------------------
            Purpose:                                                                      
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    
    {"dsOrder.i"}
    
    /* TODO Fill in appropriate datasource tables */ 
    DEFINE DATA-SOURCE srcttOrder FOR Order.
    
    /*------------------------------------------------------------------------------
            Purpose:                                                                      
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    CONSTRUCTOR PUBLIC OrderDA():
        
        DEFINE VARIABLE hDataSourceArray AS HANDLE NO-UNDO EXTENT 1.
        DEFINE VARIABLE cSkipListArray AS CHARACTER NO-UNDO EXTENT 1.
        
        SUPER (DATASET dsOrder:HANDLE).
        
        /* Data Source for each table in dataset. Should be in table order as defined 
            in DataSet */ 
         hDataSourceArray[1] = DATA-SOURCE srcttOrder:HANDLE.
                  
         /* Skip-list entry for each table in dataset. Should be in temp-table order 
           as defined in DataSet */
        /* Each skip-list entry is a comma-separated list of field names, to be
            ignored in create stmt */
         
         /* TODO Update cSkipListArray if required by your BusinessEntity */
         cSkipListArray[1] = "OrderID".
         
         THIS-OBJECT:ProDataSource = hDataSourceArray.
        THIS-OBJECT:SkipList = cSkipListArray.
                 
    END CONSTRUCTOR.
        
    /*------------------------------------------------------------------------------
            Purpose:  Get one or more records, based on a filter string                                                                     
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC VOID ReadOrderDA(
            INPUT filter AS CHARACTER, 
            OUTPUT DATASET dsOrder):
        
        SUPER:ReadData(filter).
              
    END METHOD.
      
    /*------------------------------------------------------------------------------
            Purpose: Create one or more new records                                                               
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC VOID CreateOrderDA(INPUT-OUTPUT DATASET dsOrder):            
               
        SUPER:CreateData(DATASET dsOrder BY-REFERENCE).        
    END METHOD.    
    
    /*------------------------------------------------------------------------------
            Purpose:  Update one or more records                                                                  
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC VOID UpdateOrderDA(INPUT-OUTPUT DATASET dsOrder):            
        
        SUPER:UpdateData(DATASET dsOrder BY-REFERENCE).          
    END METHOD.
    
    /*------------------------------------------------------------------------------
            Purpose:    Delete a record                                                               
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC VOID DeleteOrderDA(INPUT-OUTPUT DATASET dsOrder):                    
    
        SUPER:DeleteData(DATASET dsOrder BY-REFERENCE).
    END METHOD.
     
    
END CLASS.
