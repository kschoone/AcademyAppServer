 
 /*------------------------------------------------------------------------
    File        : OrderLineDA
    Syntax      : 
    Author(s)   : OEAdmin
    Created     : Thu Jul 29 11:18:28 CEST 2021
    Notes       : 
  ----------------------------------------------------------------------*/


USING Progress.Lang.*.
USING OpenEdge.BusinessLogic.BusinessEntity.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Order.OrderLineDA INHERITS BusinessEntity:
    /*------------------------------------------------------------------------------
            Purpose:                                                                      
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    
    {"dsOrderLine.i"}
    
    /* TODO Fill in appropriate datasource tables */ 
    DEFINE DATA-SOURCE srcttOrderLine FOR OrderLine.
    
    /*------------------------------------------------------------------------------
            Purpose:                                                                      
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    CONSTRUCTOR PUBLIC OrderLineDA():
        
        DEFINE VARIABLE hDataSourceArray AS HANDLE NO-UNDO EXTENT 1.
        DEFINE VARIABLE cSkipListArray AS CHARACTER NO-UNDO EXTENT 1.
        
        SUPER (DATASET dsOrderLine:HANDLE).
        
        /* Data Source for each table in dataset. Should be in table order as defined 
            in DataSet */ 
         hDataSourceArray[1] = DATA-SOURCE srcttOrderLine:HANDLE.
                  
         /* Skip-list entry for each table in dataset. Should be in temp-table order 
           as defined in DataSet */
        /* Each skip-list entry is a comma-separated list of field names, to be
            ignored in create stmt */
         
         /* TODO Update cSkipListArray if required by your BusinessEntity */
         cSkipListArray[1] = "OrderLineID".
         
         THIS-OBJECT:ProDataSource = hDataSourceArray.
        THIS-OBJECT:SkipList = cSkipListArray.
                 
    END CONSTRUCTOR.
        
    /*------------------------------------------------------------------------------
            Purpose:  Get one or more records, based on a filter string                                                                     
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC VOID ReadOrderLineDA(
            INPUT filter AS CHARACTER, 
            OUTPUT DATASET dsOrderLine):
        
        SUPER:ReadData(filter).
              
    END METHOD.
      
    /*------------------------------------------------------------------------------
            Purpose: Create one or more new records                                                               
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC VOID CreateOrderLineDA(INPUT-OUTPUT DATASET dsOrderLine):            
               
        SUPER:CreateData(DATASET dsOrderLine BY-REFERENCE).        
    END METHOD.    
    
    /*------------------------------------------------------------------------------
            Purpose:  Update one or more records                                                                  
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC VOID UpdateOrderLineDA(INPUT-OUTPUT DATASET dsOrderLine):            
    
        SUPER:UpdateData(DATASET dsOrderLine BY-REFERENCE).          
    END METHOD.
    
    /*------------------------------------------------------------------------------
            Purpose:    Delete a record                                                               
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC VOID DeleteOrderLineDA(INPUT-OUTPUT DATASET dsOrderLine):                    
    
        SUPER:DeleteData(DATASET dsOrderLine BY-REFERENCE).
    END METHOD.
     
    
END CLASS.
