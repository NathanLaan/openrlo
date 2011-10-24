using System;
using System.Web;

namespace Solution.Web.Library.HttpHandler
{
  public class HtmlHttpHandler : IHttpHandler
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
        httpContext.Response.ContentType = "text/html";
        httpContext.Response.WriteFile(httpContext.Request.PhysicalPath);
        httpContext.Response.End();
      }
      catch
      {
      }
    } 
  }
}