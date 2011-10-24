using System;
using System.Web;

namespace Solution.Web.Library.HttpHandler
{
  public class CssHttpHandler : IHttpHandler
  {
    bool IHttpHandler.IsReusable
    {
      get
      {
        return false;
      }
    }
    void IHttpHandler.ProcessRequest(HttpContext httpContext)
    {
      try
      {
        httpContext.Response.Clear();
        // Needs to be "text/css" for Safari browser.
        httpContext.Response.ContentType = "text/css";
        httpContext.Response.WriteFile(httpContext.Request.PhysicalPath);
        httpContext.Response.End();
      }
      catch
      {
        //
        // TODO: Capture all exceptions
        //
      }
    } 
  }
}