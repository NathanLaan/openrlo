using System;
using System.Web;
using Solution.Web.Library.HttpHandler;

namespace OpenRLO.Web.HttpHandler
{
  public class WebSiteFlexHttpHandlerPlugin : FlexHttpHandlerPlugin
  {
    FlexHttpHandlerResult FlexHttpHandlerPlugin.FindMatch(string[] splitArray)
    {

      if (splitArray.Length > 3
        && splitArray[1] == "learn"
        && !string.IsNullOrEmpty(splitArray[2])
        && !string.IsNullOrEmpty(splitArray[3]))
      {
        return new FlexHttpHandlerResult(@"/Learn.aspx", "t=" + splitArray[2] + "&p=" + splitArray[3], "learn");
      }

      if (splitArray.Length > 2
        && splitArray[1] == "learn"
        && !string.IsNullOrEmpty(splitArray[2]))
      {
        return new FlexHttpHandlerResult(@"/Learn.aspx", "t=" + splitArray[2], "learn");
      }

      return null;
    }
  }
}