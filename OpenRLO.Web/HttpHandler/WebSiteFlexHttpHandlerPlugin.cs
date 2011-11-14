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

      if (splitArray.Length > 4
        && splitArray[1] == "learn"
        && !string.IsNullOrEmpty(splitArray[2])
        && !string.IsNullOrEmpty(splitArray[3])
        && !string.IsNullOrEmpty(splitArray[4]))
      {
        result = new FlexHttpHandlerResult(@"/View.aspx", "s=" + splitArray[2] + "&t=" + splitArray[3] + "&p=" + splitArray[4], "admin");
      }

      if (splitArray.Length > 3
        && splitArray[1] == "learn"
        && !string.IsNullOrEmpty(splitArray[2])
        && !string.IsNullOrEmpty(splitArray[3]))
      {
        result = new FlexHttpHandlerResult(@"/View.aspx", "s=" + splitArray[2] + "&t=" + splitArray[3], "admin");
      }

      if (splitArray.Length > 2
        && splitArray[1] == "learn"
        && !string.IsNullOrEmpty(splitArray[2]))
      {
        result = new FlexHttpHandlerResult(@"/View.aspx", "s=" + splitArray[2], "admin");
      }

      return result;
    }
  }
}