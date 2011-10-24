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
        && splitArray[1] == "admin"
        && splitArray[2] == "article"
        && splitArray[3] == "edit"
        && !string.IsNullOrEmpty(splitArray[4]))
      {
        result = new FlexHttpHandlerResult(@"/admin/AdminArticleEdit.aspx", "a=" + splitArray[4], "admin");
      }

      if (splitArray.Length == 3
        && splitArray[1] == "s"
        && !string.IsNullOrEmpty(splitArray[2]))
      {
        result = new FlexHttpHandlerResult(@"/ViewArticle.aspx", "s=" + splitArray[2], "article");
      }

      //if (splitArray.Length == 1)
      //{
      //  //result = new FlexHttpHandlerResult(@"/ViewCategory.aspx", "c=" + splitArray[0], "category");
      //  return new FlexHttpHandlerResult(@"/Default.aspx", "c=" + splitArray[0], "category");
      //}
      //else if (splitArray.Length == 2)
      //{
      //  //if (!string.IsNullOrEmpty(splitArray[1])) // splitArray[1] != null && splitArray[1] != string.Empty)
      //  //{
      //  //result = new FlexHttpHandlerResult(@"/ViewCategory.aspx", "c=" + splitArray[1], "category");
      //  return new FlexHttpHandlerResult(@"/Default.aspx", "c=" + splitArray[1], "category");
      //  //} 
      //}
      //else if (splitArray.Length == 3)
      //{
      //  if (!string.IsNullOrEmpty(splitArray[2]))
      //  {
      //    if (splitArray[1] == "page")
      //    {
      //      return new FlexHttpHandlerResult(@"/Default.aspx", "p=" + splitArray[2], "home");
      //    }
      //    else if (splitArray[1] == "s")
      //    {
      //      return new FlexHttpHandlerResult(@"/ViewArticle.aspx", "s=" + splitArray[2], "article");
      //    }
      //    //else
      //    //{
      //    //  return new FlexHttpHandlerResult(@"/ViewArticle.aspx", "c=" + splitArray[1] + "&a=" + splitArray[2], "article");
      //    //}
      //  }
      //  else
      //  {
      //    //result = new FlexHttpHandlerResult(@"/ViewCategory.aspx", "c=" + splitArray[1], "category");
      //    return new FlexHttpHandlerResult(@"/Default.aspx", "c=" + splitArray[1], "category");
      //  }
      //}
      //else if (splitArray.Length > 3)
      //{
      //  // /11111/2222222/3333
      //  // /admin/article/edit
      //  if (splitArray[1] == "admin"
      //    && splitArray[2] == "article"
      //    && splitArray[3] == "edit"
      //    && !string.IsNullOrEmpty(splitArray[4]))
      //  {
      //    return new FlexHttpHandlerResult(@"/admin/AdminArticleEdit.aspx", "a=" + splitArray[4], "admin");
      //  }
      //  else if (splitArray[2] == "page"
      //    && !string.IsNullOrEmpty(splitArray[1])
      //    && !string.IsNullOrEmpty(splitArray[3]))
      //  {
      //    //result = new FlexHttpHandlerResult(@"/ViewCategory.aspx", "c=" + splitArray[1] + "&p=" + splitArray[3], "category");
      //    return new FlexHttpHandlerResult(@"/Default.aspx", "c=" + splitArray[1] + "&p=" + splitArray[3], "category");
      //  }
      //  else
      //  {
      //    //result = new FlexHttpHandlerResult(@"/ViewArticle.aspx", "c=" + splitArray[1] + "&a=" + splitArray[2], "category");
      //    return new FlexHttpHandlerResult(@"/Default.aspx", "c=" + splitArray[1] + "&a=" + splitArray[2], "category");
      //  }
      //}
      return result;// new FlexHttpHandlerResult(@"/Default.aspx", "", "home");
    }
  }
}