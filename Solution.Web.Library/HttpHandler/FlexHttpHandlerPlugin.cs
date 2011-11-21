using System;

namespace Solution.Web.Library.HttpHandler
{
  public interface FlexHttpHandlerPlugin
  {

    FlexHttpHandlerResult FindMatch(string[] splitArray);

  }
}