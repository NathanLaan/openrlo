<%@ WebService Language="C#" Class="OpenRLO.Web.Service.TemplateService" %>

using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Services;
using System.Web.Script.Services;
using System.Web.Services.Protocols;
using OpenRLO.Web.Data;
using OpenRLO.Web.Data;

namespace OpenRLO.Web.Service
{

  [System.Web.Script.Services.GenerateScriptType(typeof(OpenRLO.Web.Data.Article))]
  [System.Web.Script.Services.GenerateScriptType(typeof(OpenRLO.Web.Data.ArticleVersion))]
  [WebService(Namespace = "http://anetro.com/Service/ArticleService")]
  [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
  [System.ComponentModel.ToolboxItem(false)]
  [System.Web.Script.Services.ScriptService]
  public class TemplateService : System.Web.Services.WebService
  {

    [WebMethod]
    [ScriptMethod]
    public string GenerateAll()
    {
      try
      {
        AnetroTemplateEngine anetroTemplateEngine = new AnetroTemplateEngine(
          AnetroTemplateEngine.TemplatePathIndex,
          AnetroTemplateEngine.TemplatePathCategory,
          AnetroTemplateEngine.TemplatePathArticle,
          AnetroTemplateEngine.TemplatePathBase);
        anetroTemplateEngine.GenerateAll();
        return anetroTemplateEngine.AlternativeOutputPath;
      }
      catch (Exception exception)
      {
        return exception.ToString();
      }
    }

    [WebMethod]
    [ScriptMethod]
    public string SaveAll()
    {
      try
      {
        Global.ArticleIndex.SaveAll();
        return "SaveAll completed.";
      }
      catch (Exception exception)
      {
        return exception.ToString();
      }
    }

    [WebMethod]
    [ScriptMethod]
    public string Preview(Article article, ArticleVersion articleVersion)
    {
      try
      {
        article.AddArticleVersion(articleVersion);
        //AnetroTemplateArticle anetroTemplateArticle = new AnetroTemplateArticle(
        //  AnetroTemplateEngine.TemplatePathArticle, 
        //  AnetroTemplateEngine.TemplatePathBase);
        //anetroTemplateArticle.Article = article;
        //anetroTemplateArticle.Generate();
        AnetroTemplateArticle.Run(article, true);
        return article.ViewUrl;
      }
      catch (Exception exception)
      {
        return exception.ToString();
      }
    }

  }
}