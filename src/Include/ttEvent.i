/*------------------------------------------------------------------------
    File        : From template TempTable - template for temp-table. 
    Author(s)   : <author>
    Created     : Mon Jul 26 16:21:05 CEST 2021
    Version     : 
    Notes       :
  ----------------------------------------------------------------------*/
  /* temp-table definition for ttEvent */
  
  @com.openedge.t4bl.model(modeFile="platform:/resource/AcademyAppServer/appModel.t4bl", uuid="_bEmaMO4cEeu7zcooCcx-xA").
 				 
  DEFINE TEMP-TABLE ttEvent
   NO-UNDO   BEFORE-TABLE bttEvent
     FIELD EventID   AS INTEGER LABEL "Event ID" FORMAT ">>>9" INITIAL ? 
     FIELD EventName AS CHARACTER LABEL "Name" FORMAT "x(40)" 
     FIELD EventCity AS CHARACTER LABEL "City" FORMAT "x(30)" 
     FIELD EventDate AS DATE LABEL "Date" FORMAT "99/99/9999" INITIAL "?" 
   INDEX pkEventID IS  PRIMARY UNIQUE     
      EventID ASCENDING
  .  