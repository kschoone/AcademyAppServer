 
 /*------------------------------------------------------------------------
    File        : ProductBE
    Syntax      : 
    Author(s)   : OEAdmin
    Created     : Tue Jul 27 07:18:25 UTC 2021
    Notes       : 
  ----------------------------------------------------------------------*/


USING Progress.Lang.*.
USING OpenEdge.BusinessLogic.BusinessEntity.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Product.ProductBE INHERITS BusinessEntity:
    /*------------------------------------------------------------------------------
            Purpose:                                                                      
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    
    {dsProduct.i}
    
    DEFINE DATA-SOURCE srcProduct FOR Product.
    
    
    /*------------------------------------------------------------------------------
            Purpose:                                                                      
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    CONSTRUCTOR PUBLIC ProductBE():
        
        DEFINE VARIABLE hDataSourceArray AS HANDLE NO-UNDO EXTENT 1.
        DEFINE VARIABLE cSkipListArray AS CHARACTER NO-UNDO EXTENT 1.
        
        SUPER (DATASET dsProduct:HANDLE).
        
        /* Data Source for each table in dataset. Should be in table order as defined 
            in DataSet */     
         hDataSourceArray[1] =  DATA-SOURCE srcProduct:HANDLE.
         
                  
         /* Skip-list entry for each table in dataset. Should be in temp-table order 
           as defined in DataSet */
        /* Each skip-list entry is a comma-separated list of field names, to be
            ignored in create stmt */
             
         cSkipListArray[1] = "ProductID".
         
         
         THIS-OBJECT:ProDataSource = hDataSourceArray.
        THIS-OBJECT:SkipList = cSkipListArray.
                 
    END CONSTRUCTOR.
        
    /*------------------------------------------------------------------------------
            Purpose:  Get one or more records, based on a filter string                                                                     
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC VOID ReadProductBE(
            INPUT filter AS CHARACTER, 
            OUTPUT DATASET dsProduct):
        
        SUPER:ReadData(filter).
              
    END METHOD.
      
    /*------------------------------------------------------------------------------
            Purpose: Create one or more new records                                                               
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC VOID CreateProductBE(INPUT-OUTPUT DATASET dsProduct):            
               
       /*Validate if Product database exists in memory*/
       THIS-OBJECT:validateProduct(DATASET dsProduct BY-REFERENCE).
       
       //Create new dataset if dataset does not already exist     
       IF NOT DATASET dsProduct:ERROR THEN     
            SUPER:CreateData(DATASET dsProduct BY-REFERENCE).        
    END METHOD.    
    
    /*------------------------------------------------------------------------------
            Purpose:  Update one or more records                                                                  
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC VOID UpdateProductBE(INPUT-OUTPUT DATASET dsProduct):            
        THIS-OBJECT:validateProduct(DATASET dsProduct BY-REFERENCE).
    
        IF NOT DATASET dsProduct:ERROR THEN 
            SUPER:UpdateData(DATASET dsProduct BY-REFERENCE).          
    END METHOD.
    
    /*------------------------------------------------------------------------------
            Purpose:    Delete a record                                                               
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC VOID DeleteProductBE(INPUT-OUTPUT DATASET dsProduct):                    
        THIS-OBJECT:validateProduct(DATASET dsProduct BY-REFERENCE).
        
        IF NOT DATASET dsProduct:ERROR THEN 
            SUPER:DeleteData(DATASET dsProduct BY-REFERENCE).
    END METHOD.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/

    METHOD PUBLIC VOID validateProduct(INPUT DATASET dsProduct):
        
        //For each before-table check if equal to temp-table
        FOR EACH ttProduct:
            FIND bttProduct WHERE ROWID(bttProduct) = BUFFER ttProduct:AFTER-ROWID NO-ERROR.
            
        END.      
        
        RETURN.

    END METHOD.     
    
END CLASS.
