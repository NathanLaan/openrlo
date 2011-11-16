using System;
using System.Web;
using Solution.Web.Library.HttpHandler;

namespace OpenRLO.Web.HttpHandler
{
  public class WebSiteFlexHttpHandlerPlugin : FlexHttpHandlerPlugin
  {
    FlexHttpHandlerResult FlexHttpHandlerPlugin.FindMatch(string[] splitArray)
    {
      FlexHttpHandlerResult result = null;

      if (splitArray.Length > 3
        && splitArray[1] == "learn"
        && !string.IsNullOrEmpty(splitArray[2])
        && !string.IsNullOrEmpty(splitArray[3]))
      {
        result = new FlexHttpHandlerResult(@"/Learn.aspx", "t=" + splitArray[2] + "&p=" + splitArray[3], "learn");
      }

      if (splitArray.Length > 2
        && splitArray[1] == "learn"
        && !string.IsNullOrEmpty(splitArray[2]))
      {
        result = new FlexHttpHandlerResult(@"/Learn.aspx", "t=" + splitArray[2], "learn");
      }

      return result;
    }
  }
}