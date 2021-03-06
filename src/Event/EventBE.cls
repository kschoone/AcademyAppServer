@openapi.openedge.export FILE(type="REST", executionMode="singleton", useReturnValue="false", writeDataSetBeforeImage="false").
@progress.service.resource FILE(name="EventBE", URI="/Events", schemaName="dsEvent", schemaFile="").
 
 /*------------------------------------------------------------------------
    File        : EventBE
    Syntax      : 
    Author(s)   : OEAdmin
    Created     : Mon Jul 26 16:23:30 CEST 2021
    Notes       : 
  ----------------------------------------------------------------------*/


USING Progress.Lang.*.
USING OpenEdge.BusinessLogic.BusinessEntity.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS Event.EventBE INHERITS BusinessEntity:
    /*------------------------------------------------------------------------------
            Purpose:                                                                      
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    
    {"dsEvent.i"}
    
    /* TODO Fill in appropriate datasource tables */ 
    DEFINE DATA-SOURCE srcttEvent FOR Event.
    
    /*------------------------------------------------------------------------------
            Purpose:                                                                      
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    CONSTRUCTOR PUBLIC EventBE():
        
        DEFINE VARIABLE hDataSourceArray AS HANDLE NO-UNDO EXTENT 1.
        DEFINE VARIABLE cSkipListArray AS CHARACTER NO-UNDO EXTENT 1.
        
        SUPER (DATASET dsEvent:HANDLE).
        
        /* Data Source for each table in dataset. Should be in table order as defined 
            in DataSet */ 
         hDataSourceArray[1] = DATA-SOURCE srcttEvent:HANDLE.
                  
         /* Skip-list entry for each table in dataset. Should be in temp-table order 
           as defined in DataSet */
        /* Each skip-list entry is a comma-separated list of field names, to be
            ignored in create stmt */
         
         /* TODO Update cSkipListArray if required by your BusinessEntity */
         cSkipListArray[1] = "EventID".
         
         THIS-OBJECT:ProDataSource = hDataSourceArray.
        THIS-OBJECT:SkipList = cSkipListArray.
                 
    END CONSTRUCTOR.
        
    /*------------------------------------------------------------------------------
            Purpose:  Get one or more records, based on a filter string                                                                     
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    @openapi.openedge.export(type="REST", useReturnValue="false", writeDataSetBeforeImage="false").
    @progress.service.resourceMapping(type="REST", operation="read", URI="?filter=~{filter~}", alias="", mediaType="application/json").
    METHOD PUBLIC VOID ReadEventBE(
            INPUT filter AS CHARACTER, 
            OUTPUT DATASET dsEvent):
        
        SUPER:ReadData(filter).
              
    END METHOD.
      
    /*------------------------------------------------------------------------------
            Purpose: Create one or more new records                                                               
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC VOID CreateEventBE(INPUT-OUTPUT DATASET dsEvent):            
        THIS-OBJECT:validateEvent(DATASET dsEvent BY-REFERENCE).
        
        IF NOT DATASET dsEvent:ERROR THEN                 
            SUPER:CreateData(DATASET dsEvent BY-REFERENCE).
    END METHOD.    
    
    /*------------------------------------------------------------------------------
            Purpose:  Update one or more records                                                                  
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC VOID UpdateEventBE(INPUT-OUTPUT DATASET dsEvent):            
        THIS-OBJECT:validateEvent(DATASET dsEvent BY-REFERENCE).
                
        IF NOT DATASET dsEvent:ERROR THEN        
            SUPER:UpdateData(DATASET dsEvent BY-REFERENCE).
                      
    END METHOD.
    
    /*------------------------------------------------------------------------------
            Purpose:    Delete a record                                                               
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
    METHOD PUBLIC VOID DeleteEventBE(INPUT-OUTPUT DATASET dsEvent):                    
    
        SUPER:DeleteData(DATASET dsEvent BY-REFERENCE).
    END METHOD.

    /*------------------------------------------------------------------------------
     Purpose:
     Notes:
    ------------------------------------------------------------------------------*/

    METHOD PRIVATE VOID validateEvent(INPUT DATASET dsEvent):
        
        FOR EACH ttEvent:
            FIND bttEvent WHERE ROWID(bttEvent) = BUFFER ttEvent:AFTER-ROWID NO-ERROR.   
        END.           
    END METHOD.     
    
END CLASS.
