using System;

namespace Solution.Web.Library.HttpHandler
{
  public class FlexHttpHandlerResult
  {

    private string url;
    public string Url
    {
      get { return url; }
      set { url = value; }
    }
    private string queryString;
    public string QueryString
    {
      get { return queryString; }
      set { queryString = value; }
    }
    private string name;
    public string Name
    {
      get { return name; }
      set { name = value; }
    }


    public FlexHttpHandlerResult(string url, string queryString):this(url, queryString, "")
    {
    }
    public FlexHttpHandlerResult(string url, string queryString, string name)
    {
      this.url = url;
      this.queryString = queryString;
      this.name = name;
    }

  }
}