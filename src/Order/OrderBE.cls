 /*------------------------------------------------------------------------
    File        : OrderBE
    Syntax      : 
    Author(s)   : OEAdmin
    Created     : Thu Jul 29 11:19:50 CEST 2021
    Notes       : 
  ----------------------------------------------------------------------*/


USING Progress.Lang.*.
USING OpenEdge.BusinessLogic.BusinessEntity.
USING Order.OrderDA FROM PROPATH.
USING Order.OrderLineDA FROM PROPATH.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Order.OrderBE:
    /*------------------------------------------------------------------------------
            Purpose:                                                                      
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
{dsOrder.i}
{dsOrderLine.i}
{dsOrderOrderLine.i} 
DEFINE VARIABLE oOrderDA AS OrderDA NO-UNDO.
DEFINE VARIABLE oOrderLineDA AS OrderLineDA NO-UNDO.
    
    /*------------------------------------------------------------------------------
            Purpose:                                                                      
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    CONSTRUCTOR PUBLIC OrderBE():
    
        ASSIGN oOrderDA     = NEW OrderDA()
               oOrderLineDA = NEW OrderLineDA().
                 
    END CONSTRUCTOR.
        
    /*------------------------------------------------------------------------------
            Purpose:  Get one or more records, based on a filter string                                                                     
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC VOID ReadOrderBE(
            INPUT filter AS CHARACTER, 
            OUTPUT DATASET dsOrderOrderLine):       
    
        DATASET dsOrderOrderLine:EMPTY-DATASET ().
        
        oOrderDA:ReadOrderDA(filter, OUTPUT DATASET dsOrder).
        TEMP-TABLE ttOrderProc:COPY-TEMP-TABLE (TEMP-TABLE ttOrder:HANDLE, TRUE).
        FOR EACH ttOrderProc:
            oOrderLineDA:ReadOrderLineDA("OrderLine.OrderID EQ " + STRING(ttOrderProc.OrderID), OUTPUT DATASET dsOrderLine).
            TEMP-TABLE ttOrderLineProc:COPY-TEMP-TABLE (TEMP-TABLE ttOrderLine:HANDLE, TRUE).
        END.
              
    END METHOD.
      
    /*------------------------------------------------------------------------------
            Purpose: Create one or more new records                                                               
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC VOID CreateOrderBE(INPUT-OUTPUT DATASET dsOrderOrderLine):            
       REPEAT PRESELECT EACH ttOrderProc:
           TEMP-TABLE ttOrder:EMPTY-TEMP-TABLE ().
           
           FIND NEXT ttOrderProc.
           CREATE ttOrder.
           BUFFER-COPY ttOrderProc TO ttOrder.
           
           oOrderDA:CreateOrderDA(INPUT-OUTPUT DATASET dsOrder).
           
           FIND FIRST ttOrder.
           
           REPEAT PRESELECT EACH ttOrderLineProc WHERE ttOrderLineProc.OrderID EQ ttOrderProc.OrderID:
               TEMP-TABLE ttOrderLine:EMPTY-TEMP-TABLE ().
               
               FIND NEXT ttOrderLineProc.
               
               CREATE ttOrderLine.
               BUFFER-COPY ttOrderLineProc TO ttOrderLine.              
               ASSIGN ttOrderLine.OrderID = ttOrder.OrderID.
               
               oOrderLineDA:CreateOrderLineDA(INPUT-OUTPUT DATASET dsOrderLine).
               
               FIND FIRST ttOrderLine.
               BUFFER-COPY ttOrderLine TO ttOrderLineProc.
           END.

           BUFFER-COPY ttOrder TO ttOrderProc.              
       END.
       
    END METHOD.    
    
    /*------------------------------------------------------------------------------
            Purpose:  Update one or more records                                                                  
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC VOID UpdateOrderBE(INPUT-OUTPUT DATASET dsOrderOrderLine):            
         
       REPEAT PRESELECT EACH ttOrderProc:
           TEMP-TABLE ttOrder:EMPTY-TEMP-TABLE ().
           
           FIND NEXT ttOrderProc.
           CREATE ttOrder.
           BUFFER-COPY ttOrderProc TO ttOrder.
           
           oOrderDA:UpdateOrderDA(INPUT-OUTPUT DATASET dsOrder).
           IF DATASET dsOrder:ERROR THEN ASSIGN DATASET dsOrderOrderLine:ERROR = TRUE .
           
           FIND FIRST ttOrder.
           
           REPEAT PRESELECT EACH ttOrderLineProc WHERE ttOrderLineProc.OrderID EQ ttOrderProc.OrderID:
               TEMP-TABLE ttOrderLine:EMPTY-TEMP-TABLE ().
               
               FIND NEXT ttOrderLineProc.
               
               CREATE ttOrderLine.
               BUFFER-COPY ttOrderLineProc TO ttOrderLine.              
               ASSIGN ttOrderLine.OrderID = ttOrder.OrderID.
               
               oOrderLineDA:UpdateOrderLineDA(INPUT-OUTPUT DATASET dsOrderLine).
               
               FIND FIRST ttOrderLine.
               BUFFER-COPY ttOrderLine TO ttOrderLineProc.
           END.

           BUFFER-COPY ttOrder TO ttOrderProc.              
       END.
         
    END METHOD.
    
    /*------------------------------------------------------------------------------
            Purpose:    Delete a record                                                               
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC VOID DeleteOrderBE(INPUT-OUTPUT DATASET dsOrderOrderLine):                    

    END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	DESTRUCTOR PUBLIC OrderBE ( ):
        DELETE OBJECT oOrderDA     NO-ERROR.
        DELETE OBJECT oOrderLineDA NO-ERROR.
	END DESTRUCTOR.
     
    
END CLASS.
