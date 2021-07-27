/*------------------------------------------------------------------------
    File        : From template TempTable - template for temp-table. 
    Author(s)   : <author>
    Created     : Tue Jul 27 09:12:34 CEST 2021
    Version     : 
    Notes       :
  ----------------------------------------------------------------------*/
  /* temp-table definition for eeCustomer */
  
  @com.openedge.t4bl.model(modeFile="platform:/resource/AcademyAppServer/appModel.t4bl", uuid="_ApvUcO6qEeu7zcooCcx-xA").
 				 
  DEFINE TEMP-TABLE ttCustomer
   NO-UNDO   BEFORE-TABLE bttCustomer
     FIELD CustomerName AS CHARACTER LABEL "Name" FORMAT "x(50)" 
     FIELD CustomerID AS INTEGER LABEL "Customer" FORMAT ">>>>>>9" INITIAL ? 
     FIELD Email AS CHARACTER LABEL "Email" FORMAT "x(50)" 
     FIELD Birthdate AS DATE LABEL "Birthdate" FORMAT "99/99/9999" INITIAL "?" 
     FIELD Password AS CHARACTER LABEL "Password" FORMAT "x(35)" 
   INDEX kpCustomerID IS  PRIMARY UNIQUE     
      CustomerID ASCENDING
  .  