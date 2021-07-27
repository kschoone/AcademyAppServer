/*------------------------------------------------------------------------
    File        : From template TempTable - template for temp-table. 
    Author(s)   : <author>
    Created     : Tue Jul 27 09:11:23 CEST 2021
    Version     : 
    Notes       :
  ----------------------------------------------------------------------*/
  /* temp-table definition for eeEmployee */
  
  @com.openedge.t4bl.model(modeFile="platform:/resource/AcademyAppServer/appModel.t4bl", uuid="_0qCBMO6pEeu7zcooCcx-xA").
 				 
  DEFINE TEMP-TABLE ttEmployee
   NO-UNDO   BEFORE-TABLE bttEmployee
     FIELD EmployeeName AS CHARACTER LABEL "Name" FORMAT "x(50)" 
     FIELD EmployeeID AS INTEGER LABEL "Employee ID" FORMAT ">>>9" INITIAL ? 
   INDEX pkEmployeeID IS  PRIMARY UNIQUE     
      EmployeeID ASCENDING
  .  