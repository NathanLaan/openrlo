using System;

namespace Solution.Web.Library.HttpHandler
{
  public class FlexPage
  {

    /// <summary>
    /// The URL that the user sees in their web browser.
    /// </summary>
    private string rawUrl;
    public string RawUrl
    {
      get { return rawUrl; }
      set { rawUrl = value; }
    }

    /// <summary>
    /// The URL that the FlexHttpHandler maps the flexUrl to.
    /// </summary>
    private string mapUrl;
    public string MapUrl
    {
      get { return mapUrl; }
      set { mapUrl = value; }
    }

    /// <summary>
    /// The name assigned to the page and visible to the user.
    /// </summary>
    private string name;
    public string Name
    {
      get { return name; }
      set { name = value; }
    }

    public FlexPage()
    {
    }
    public FlexPage(string name, string rawUrl, string mapUrl)
    {
      this.Name = name;
      this.RawUrl = rawUrl;
      this.MapUrl = mapUrl;
    }

  }
}