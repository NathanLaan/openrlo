<%@ WebService Language="C#" Class="OpenRLO.Web.Service.ArticleService" %>

using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Services;
using System.Web.Script.Services;
using System.Web.Services.Protocols;
using OpenRLO.Web.Data;
using Solution.Web.Anetro.Library.Utility;

namespace OpenRLO.Web.Service
{

  [System.Web.Script.Services.GenerateScriptType(typeof(OpenRLO.Web.Data.Article))]
  [System.Web.Script.Services.GenerateScriptType(typeof(OpenRLO.Web.Data.ArticleVersion))]
  [WebService(Namespace = "http://anetro.com/Service/ArticleService")]
  [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
  [System.ComponentModel.ToolboxItem(false)]
  [System.Web.Script.Services.ScriptService]
  public class ArticleService : System.Web.Services.WebService
  {

    [WebMethod]
    [ScriptMethod]
    public void GenerateRandomArticles(int num)
    {
      for(int i=0; i<num;i++){
        string guid = Guid.NewGuid().ToString();
        Article article = new Article();
        article.Category = "articles";
        article.Title = guid.ToUpper();
        article.TitleUrl = "id" + guid;
        article.Published = true;
        article.PublishedDateTime = DateTime.Now;
        ArticleVersion articleVersion = new ArticleVersion();
        articleVersion.Contents = "CONTENTS_" + guid;
        articleVersion.DateTime = article.PublishedDateTime;
        this.Add(article, articleVersion);
      }
    }

    [WebMethod]
    [ScriptMethod]
    public List<Article> GetArticleList(string categoryName, string published)
    {
      if (categoryName == null)
      {
      }
      if (published != null)
      {
      }
      return Global.ArticleIndex.List;
    }

    [WebMethod]
    [ScriptMethod]
    public string TogglePublished(string categoryName, string articleTitleURL, bool newValue)
    {
      Article article = Global.ArticleIndex.GetArticle(categoryName, articleTitleURL);
      if (article != null)
      {
        article.Published = newValue;
        Global.ArticleIndex.Save();
        this.Publish(article);
        return "Article " + (newValue ? "Published" : "Drafted");
      }
      else
      {
        return "Unable to find article.";
      }
    }

    [WebMethod]
    [ScriptMethod]
    public string Delete(string categoryName, string articleTitleURL)
    {
      Article article = Global.ArticleIndex.GetArticle(categoryName, articleTitleURL);
      this.Publish(article);
      if (Global.ArticleIndex.DeleteArticle(categoryName, articleTitleURL))
      {
        return "Article deleted";
      }
      else
      {
        return "Unable to delete article.";
      }
    }

    [WebMethod]
    [ScriptMethod]
    public string GenerateShortUrl()
    {
      return Global.ArticleIndex.GenerateShortURL();
    }

    [WebMethod]
    [ScriptMethod]
    public bool ShortUrlExists(string shortUrl)
    {
      return Global.ArticleIndex.ShortUrlExists(shortUrl);
    }

    [WebMethod]
    [ScriptMethod]
    public bool TitleUrlExists(string shortUrl)
    {
      return Global.ArticleIndex.TitleUrlExists(shortUrl);
    }

    [WebMethod]
    [ScriptMethod]
    public string Add(Article article, ArticleVersion articleVersion)
    {
      try
      {
        article.Filename = article.GenerateArticleFilename();
        articleVersion.Version = 1;
        articleVersion.Filename = article.GenerateArticleVersionFilename(articleVersion);
        article.AddArticleVersion(articleVersion);

        if (Global.ArticleIndex.ArticleExists(article))
        {
          return "Article exists.";
        }
        else
        {
          Global.ArticleIndex.AddArticle(article);
          Global.ArticleIndex.Save();
          article.Save();
          articleVersion.Save();

          this.Publish(article);

          try
          {
            Email.SendMail(
              "smtp.gmail.com",
              587,
              "noreply@nathanlaan.com",
              "anetro#2011",
              "noreply@nathanlaan.com",
              "Anetro (" + Global.SiteSettings.SiteName + ")",
              "nathanlaan@gmail.com",
              "Nathan Laan",
              (article.Published?"Article Published: ":"Article Drafted: ") + article.Title,
              (article.Published?"Article Published: ":"Article Drafted: ") + article.Title + "<br><br>" + System.Environment.NewLine + System.Environment.NewLine
              + Global.SiteSettings.SiteUrl + "/" + article.Category + "/" + article.TitleUrl + "<br><br>" + System.Environment.NewLine + System.Environment.NewLine
              + article.LatestArticleContentsHtml + "<br><br><br>" + System.Environment.NewLine + System.Environment.NewLine + System.Environment.NewLine
              + article.Filename + "<br>" + System.Environment.NewLine
              + articleVersion.Filename + "<br>" + System.Environment.NewLine,
              true);
          }
          catch
          {
            // TODO: Logging?
          }
          
          return "Article saved.";
        }
      }
      catch (Exception exception)
      {
        return "Error: " + exception.ToString();
      }
    }

    [WebMethod]
    [ScriptMethod]
    //                        art.TitleUrl,              category,               title,                  titleUrl,         shortUrl,        contents,                  datetime,       published
    public string Edit(string oldArticleTitleUrl, string newCategoryName, string newArticleTitle, string titleUrl, string shortUrl, string newArticleContents, string dateTime, bool published)
    {
      try
      {
        Article article = Global.ArticleIndex.GetArticle(null, oldArticleTitleUrl);

        if (article != null)
        {
          ArticleVersion articleVersion = new ArticleVersion();
          articleVersion.DateTime = DateTime.Parse(dateTime);
          articleVersion.Contents = newArticleContents;
          articleVersion.Version = article.LatestArticleVersion.Version + 1;
          articleVersion.Filename = article.GenerateArticleVersionFilename(articleVersion);
          articleVersion.Save();
          article.Category = newCategoryName;
          article.Title = newArticleTitle;
          article.TitleUrl = titleUrl;
          article.ShortUrl = shortUrl;
          article.Published = published;
          article.LatestArticleVersion = articleVersion;
          article.AddArticleVersion(articleVersion);
          article.Filename = article.GenerateArticleFilename();
          
          //
          // NOTE: Not efficient, but "safe".
          //
          //if (oldArticleTitleUrl != titleUrl)
          //{
          //  article.SaveAll();
          //}
          //
          // TODO: Delete old Article and ArticleVersion files
          //
          article.SaveAll();
          Global.ArticleIndex.Save();

          this.Publish(article);

          return "Article saved.";
        }
        else
        {
          return "Article not found.";
        }
      }
      catch (Exception exception)
      {
        return "Error: " + exception.ToString();
      }
    }



    private void Publish(Article article)
    {
      try
      {
        AnetroTemplateIndex.Run();
      }
      catch
      {
        // TODO: Logging!
      }
      try
      {
        AnetroTemplateArticle.Run(article, false);
      }
      catch
      {
        // TODO: Logging!
      }
      try
      {
        AnetroTemplateCategory.Run(article.Category);
      }
      catch
      {
        // TODO: Logging!
      }
    }




    //[WebMethod]
    //[ScriptMethod]
    //public bool Exists(string articleTitle)
    //{
    //  return Global.ArticleIndex.ArticleExists(articleTitle);
    //}

    [WebMethod]
    [ScriptMethod]
    public Article Get(string categoryName, string articleTitle)
    {
      return Global.ArticleIndex.GetArticle(categoryName, articleTitle);
    }

    [WebMethod]
    [ScriptMethod]
    public ArticleVersion GetArticleVersion(string categoryName, string articleTitle)
    {
      return Global.ArticleIndex.GetArticle(categoryName, articleTitle).LatestArticleVersion;
    }

  }
}