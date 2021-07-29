 
 /*------------------------------------------------------------------------
    File        : OrderHandler
    Purpose     : 
    Syntax      : 
    Description : 
    Author(s)   : OEAdmin
    Created     : Thu Jul 29 13:59:51 CEST 2021
    Notes       : 
  ----------------------------------------------------------------------*/

USING Progress.Lang.*.
USING OpenEdge.Web.WebResponseWriter.
USING OpenEdge.Net.HTTP.StatusCodeEnum.
USING OpenEdge.Web.WebHandler.
USING Progress.Json.ObjectModel.JsonObject FROM PROPATH.

BLOCK-LEVEL ON ERROR UNDO, THROW.

CLASS OrderHandler INHERITS WebHandler: 
    
    {dsOrderOrderLine.i}
	
		
    DEFINE PRIVATE PROPERTY oOrderBE AS Order.OrderBE NO-UNDO 
    GET:
        IF NOT VALID-OBJECT (oOrderBE) THEN ASSIGN oOrderBE = NEW Order.OrderBE().
        RETURN oOrderBE.
    END.
    SET.

	/*------------------------------------------------------------------------------
            Purpose: Handler for unsupported methods. The request being serviced and
            		 an optional status code is returned. A zero or null value means 
            		 this method will deal with all errors.                                                               
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
	METHOD OVERRIDE PROTECTED INTEGER HandleNotAllowedMethod( INPUT poRequest AS OpenEdge.Web.IWebRequest ):
	
		/* Throwing an error from this method results in a 500/Internal Server Error response. 
        The web handler will attempt to log this exception.
 	    
        See the HandleGet method's comments on choosing a value to return from this method. */
        	
		UNDO, THROW NEW Progress.Lang.AppError("METHOD NOT IMPLEMENTED").
	END METHOD.


	/*------------------------------------------------------------------------------
            Purpose: Handler for unknown methods. The request being serviced and an 
                     optional status code is returned. A zero or null value means 
                     this method will deal with all errors.                                                               
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
	METHOD OVERRIDE PROTECTED INTEGER HandleNotImplemented( INPUT poRequest AS OpenEdge.Web.IWebRequest ):
	
		/* Throwing an error from this method results in a 500/Internal Server Error response. 
        The web handler will attempt to log this exception.
 	    
        See the HandleGet method's comments on choosing a value to return from this method. */	
		UNDO, THROW NEW Progress.Lang.AppError("METHOD NOT IMPLEMENTED").
   	END METHOD.
 	
	
	/*------------------------------------------------------------------------------
            Purpose: Default handler for the HTTP GET method. The request being 
                     serviced and an optional status code is returned. A zero or 
                     null value means this method will deal with all errors.                                                               
            Notes:                                                                        
    ------------------------------------------------------------------------------*/
 	METHOD OVERRIDE PROTECTED INTEGER HandleGet( INPUT poRequest AS OpenEdge.Web.IWebRequest ):
 	
	
		DEFINE VARIABLE oResponse AS OpenEdge.Net.HTTP.IHttpResponse NO-UNDO.
        DEFINE VARIABLE oWriter   AS OpenEdge.Web.WebResponseWriter  NO-UNDO.
        DEFINE VARIABLE iOrderID  AS INTEGER   NO-UNDO.
        DEFINE VARIABLE cFilter   AS CHARACTER NO-UNDO.
        DEFINE VARIABLE iEventID  AS INTEGER   NO-UNDO.
        DEFINE VARIABLE iStandID  AS INTEGER   NO-UNDO.
        DEFINE VARIABLE cStatus   AS CHARACTER NO-UNDO.
            
        /* The WebResponse body is a wrapper around an entire HTTP response message.
           It contains a status code and reason; headers; cookies and a message body.
           
           API-level doc for this and related classes can be found at
           https://documentation.progress.com/output/oehttpclient/      */
        ASSIGN 
            oResponse            = NEW OpenEdge.Web.WebResponse()
            oWriter              = NEW OpenEdge.Web.WebResponseWriter(oResponse)
          //oResponse:StatusCode = INTEGER(StatusCodeEnum:OK)
            .
        
        IF poRequest:PathInfo BEGINS "/Orders" THEN DO:           
            ASSIGN iOrderID = INTEGER(poRequest:GetPathParameter("orderID")).
            IF iOrderID > 0 THEN ASSIGN cFilter = "orderID EQ " + STRING(iOrderID).
            oOrderBE:ReadOrderBE(cFilter, OUTPUT DATASET dsOrderOrderLine).
            IF CAN-FIND(FIRST ttOrderProc) THEN DO:
                ASSIGN oResponse:ContentType = "application/json"
                       oResponse:StatusCode = INTEGER(StatusCodeEnum:OK)
                       .
                oWriter:Flush().
                DATASET dsOrderOrderLine:WRITE-JSON ("STREAM-HANDLE", oWriter:WebStream, FALSE, "UTF-8", FALSE, FALSE, TRUE).                
            END.
            ELSE DO:
                ASSIGN oResponse:StatusCode = INTEGER(StatusCodeEnum:NotFound).
            END.
        END.
        
        ELSE IF poRequest:PathInfo BEGINS "/Events" THEN DO:
            ASSIGN iStandID = INTEGER(poRequest:GetPathParameter("standID"))
                   iEventID = INTEGER(poRequest:GetPathParameter("eventID"))
                   cStatus  =         poRequest:GetPathParameter("status")
                   .
            MESSAGE cStatus
            VIEW-AS ALERT-BOX.
            IF (NOT iStandID > 0 OR NOT iEventID > 0) 
                OR NOT (cStatus = "" OR cStatus = "Open" OR cStatus = "Closed") 
            THEN DO:
                ASSIGN oResponse:StatusCode = INTEGER(StatusCodeEnum:BadRequest). 
            END.
            ELSE DO:
                ASSIGN cFilter = SUBSTITUTE("EventID = &1 and StandID = &2", iEventID, iStandID).
                CASE cStatus:
                    WHEN "Open"   THEN ASSIGN cFilter = cFilter + " AND OrderStatus <= 2".
                    WHEN "Closed" THEN ASSIGN cFilter = cFilter + " AND OrderStatus >= 3".
                END CASE.
                MESSAGE cFilter
                VIEW-AS ALERT-BOX.
                oOrderBE:ReadOrderBE(cFilter, OUTPUT DATASET dsOrderOrderLine).
                IF CAN-FIND(FIRST ttOrderProc) THEN DO:
                    ASSIGN oResponse:ContentType = "application/json"
                           oResponse:StatusCode = INTEGER(StatusCodeEnum:OK)
                           .
                    oWriter:Flush().
                    DATASET dsOrderOrderLine:WRITE-JSON ("STREAM-HANDLE", oWriter:WebStream, FALSE, "UTF-8", FALSE, FALSE, TRUE).                
                END.
                ELSE DO:
                    ASSIGN oResponse:StatusCode = INTEGER(StatusCodeEnum:NotFound).
                END.
            END.
        END.
        ELSE DO:
            ASSIGN oResponse:StatusCode = INTEGER(StatusCodeEnum:BadRequest).
        END.
        /* Finish writing the response message */
        oWriter:Close().
        
        /* A response of 0 means that this handler will build the entire response;
           a non-zero value is mapped to a static handler in the webapp's /static/error folder.
           The mappings are maintained in the webapps's WEB-INF/web.xml 
           A predefined set of HTTP status codes is provided in the OpenEdge.Net.HTTP.StatusCodeEnum 
           enumeration */
        RETURN 0.
		
 	END METHOD. 

    METHOD OVERRIDE PROTECTED INTEGER HandlePost( INPUT poRequest AS OpenEdge.Web.IWebRequest ):
        
        DEFINE VARIABLE oResponse AS OpenEdge.Net.HTTP.IHttpResponse NO-UNDO.
        DEFINE VARIABLE oWriter   AS OpenEdge.Web.WebResponseWriter  NO-UNDO.
        DEFINE VARIABLE oJson     AS JsonObject                      NO-UNDO.
        
        ASSIGN 
            oResponse            = NEW OpenEdge.Web.WebResponse()
            oWriter              = NEW OpenEdge.Web.WebResponseWriter(oResponse)
            .
        
        IF TYPE-OF(poRequest:Entity, JsonObject) THEN DO:
            oJson = CAST(poRequest:Entity, JsonObject).
            //DATASET dsOrderOrderLine:EMPTY-DATASET ().
            
            DATASET dsOrderOrderLine:READ-JSON ("JsonObject", oJson, "EMPTY").    
            oOrderBE:CreateOrderBE(INPUT-OUTPUT DATASET dsOrderOrderLine).
            
            IF DATASET dsOrderOrderLine:ERROR THEN 
                ASSIGN oResponse:StatusCode = INTEGER(StatusCodeEnum:UnprocessableEntity). //422
            ELSE 
                ASSIGN oResponse:StatusCode = INTEGER(StatusCodeEnum:Created). //201
            
            oWriter:Flush().
            DATASET dsOrderOrderLine:WRITE-JSON ("STREAM-HANDLE", oWriter:WebStream, FALSE, "UTF-8", FALSE, FALSE, TRUE).
        END.
        ELSE DO:
            ASSIGN oResponse:StatusCode = INTEGER(StatusCodeEnum:UnprocessableEntity). //422
        END.
        
        oWriter:Close().
        RETURN 0.

    END METHOD. 	

    METHOD OVERRIDE PROTECTED INTEGER HandlePut( INPUT poRequest AS OpenEdge.Web.IWebRequest ):
        
        DEFINE VARIABLE oResponse AS OpenEdge.Net.HTTP.IHttpResponse NO-UNDO.
        DEFINE VARIABLE oWriter   AS OpenEdge.Web.WebResponseWriter  NO-UNDO.
        DEFINE VARIABLE oJson     AS JsonObject                      NO-UNDO.
        
        ASSIGN 
            oResponse            = NEW OpenEdge.Web.WebResponse()
            oWriter              = NEW OpenEdge.Web.WebResponseWriter(oResponse)
            .
        
        IF TYPE-OF(poRequest:Entity, JsonObject) THEN DO:
            oJson = CAST(poRequest:Entity, JsonObject).
            //DATASET dsOrderOrderLine:EMPTY-DATASET ().
            
            DATASET dsOrderOrderLine:READ-JSON ("JsonObject", oJson, "EMPTY").    
            oOrderBE:UpdateOrderBE(INPUT-OUTPUT DATASET dsOrderOrderLine).
            
            IF DATASET dsOrderOrderLine:ERROR THEN 
                ASSIGN oResponse:StatusCode = INTEGER(StatusCodeEnum:UnprocessableEntity). //422
            ELSE 
                ASSIGN oResponse:StatusCode = INTEGER(StatusCodeEnum:OK). //200
            
            oWriter:Flush().
            DATASET dsOrderOrderLine:WRITE-JSON ("STREAM-HANDLE", oWriter:WebStream, FALSE, "UTF-8", FALSE, FALSE, TRUE).
        END.
        ELSE DO:
            ASSIGN oResponse:StatusCode = INTEGER(StatusCodeEnum:UnprocessableEntity). //422
        END.
        
        oWriter:Close().
        RETURN 0.

    END METHOD.

	/*------------------------------------------------------------------------------
	 Purpose:
	 Notes:
	------------------------------------------------------------------------------*/
	DESTRUCTOR PUBLIC OrderHandler ( ):
        IF VALID-OBJECT(oOrderBE) THEN DELETE OBJECT oOrderBE.
	END DESTRUCTOR.
 	
   	
	
END CLASS.