/*------------------------------------------------------------------------
    File        : From template TempTable - template for temp-table. 
    Author(s)   : <author>
    Created     : Tue Jul 27 07:45:16 UTC 2021
    Version     : 
    Notes       :
  ----------------------------------------------------------------------*/
  /* temp-table definition for ttProduct */
  
  @com.openedge.t4bl.model(modeFile="platform:/resource/AcademyAppServer/appModel.t4bl", uuid="_gwwXYO6uEeucV76sr-OEDg").
 				 
  DEFINE TEMP-TABLE ttProduct
   NO-UNDO   BEFORE-TABLE bttProduct
     FIELD ProductID AS INTEGER LABEL "Product ID" FORMAT ">>>>>>>>9" INITIAL ? 
     FIELD ProductName AS CHARACTER FORMAT "x(40)" INITIAL "/" 
     FIELD Price AS DECIMAL LABEL "Price" FORMAT "->>,>>9.99" INITIAL ? DECIMALS 2 
     FIELD HasAlcohol AS LOGICAL LABEL "Has Alcohol" FORMAT "yes/no" INITIAL no 
     FIELD Category AS INTEGER LABEL "Category" FORMAT ">>9" INITIAL ? 
   INDEX pkProductID IS  PRIMARY UNIQUE     
      ProductID ASCENDING
  .  