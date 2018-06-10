﻿<%@ WebHandler Language="C#" Class="LoginHandler" %>

using System;
using System.Web;
using System.Web.SessionState;

public class LoginHandler : IHttpHandler,IRequiresSessionState {
    
    public void ProcessRequest (HttpContext context) {
        context.Response.ContentType = "text/plain";

        string tel = context.Request.Form["tel"];
        string pwd = context.Request.Form["pwd"];
        
        Customer Cus = CustomerFactory.GetCustomerByTelNo(tel, pwd);
        if (Cus != null)
        {
            context.Session["Customer"] = Cus;
            context.Response.Write("ok");
        }

        else
            context.Response.Write("error");
            
        
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}