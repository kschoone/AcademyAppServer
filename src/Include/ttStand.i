/*------------------------------------------------------------------------
    File        : From template TempTable - template for temp-table. 
    Author(s)   : <author>
    Created     : Tue Jul 27 07:43:01 UTC 2021
    Version     : 
    Notes       :
  ----------------------------------------------------------------------*/
  /* temp-table definition for ttStand */
  
  @com.openedge.t4bl.model(modeFile="platform:/resource/AcademyAppServer/appModel.t4bl", uuid="_HiFIcO6uEeucV76sr-OEDg").
 				 
  DEFINE TEMP-TABLE ttStand
   NO-UNDO   BEFORE-TABLE bttStand
     FIELD StandID AS INTEGER LABEL "Stand ID" FORMAT ">>>>>9" 
     FIELD StandName AS CHARACTER LABEL "Name" FORMAT "x(25)" 
     FIELD EventID AS INTEGER LABEL "Event ID" FORMAT ">>>9" INITIAL ? 
   INDEX pkStandID IS  PRIMARY UNIQUE     
      StandID ASCENDING
   INDEX fkEventID     
      EventID ASCENDING
  .  