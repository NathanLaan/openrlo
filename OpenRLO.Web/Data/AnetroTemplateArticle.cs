using System;
using System.Collections.Generic;
using System.IO;
using System.Web;
using System.Text.RegularExpressions;
using System.Text;

namespace OpenRLO.Web.Data
{
  public class AnetroTemplateArticle : AnetroTemplate
  {


    public Article Article { get; set; }
    public bool Preview { get; set; }


    public static void Run(Article article, bool preview)
    {
      AnetroTemplateArticle anetroTemplateArticle = new AnetroTemplateArticle(AnetroTemplateEngine.TemplatePathArticle, AnetroTemplateEngine.TemplatePathBase);
      anetroTemplateArticle.Article = article;
      anetroTemplateArticle.Preview = preview;
      anetroTemplateArticle.Generate();
    }


    public AnetroTemplateArticle(string templateFilePath, string baseOutputPath)
    {
      this.TemplateFilePath = templateFilePath;
      this.BaseOutputPath = baseOutputPath;
    }

    public string Generate()
    {
      if (File.Exists(this.TemplateFilePath))
      {
        StringBuilder sb = new StringBuilder();
        string parsedContents = "";
        using (StreamReader sr = new StreamReader(this.TemplateFilePath))
        {
          parsedContents = sr.ReadToEnd();
        }
        

        if (this.Article != null)
        {
          //
          // TODO: Check for "NULL" category
          //
          parsedContents = this.ElementRegex("SiteName").Replace(parsedContents, Global.SiteSettings.SiteName);
          parsedContents = this.ElementRegex("SiteCopyright").Replace(parsedContents, Global.SiteSettings.SiteCopyright);
          parsedContents = this.ElementRegex("FeedLink.Url").Replace(parsedContents, Global.SiteSettings.SiteFeedUrl);
          //parsedContents = this.ElementRegex("FeedLink.Title").Replace(parsedContents, Global.SiteSettings.SiteFeedDescription);
          parsedContents = this.ElementRegex("ArticleTitle").Replace(parsedContents, this.Article.Title);
          parsedContents = this.ElementRegex("ArticleContents").Replace(parsedContents, this.Article.LatestArticleContentsHtml);
          parsedContents = this.ElementRegex("PublishedDateTime").Replace(parsedContents, this.Article.PublishedDateTime.ToString("yyyy/MMM/dd"));
          parsedContents = this.ElementRegex("SiteVersion").Replace(parsedContents, Global.SiteVersion);
          parsedContents = this.ElementRegex("ShortUrl").Replace(parsedContents, Global.SiteSettings.ShortURL + "/s/" + this.Article.ShortUrl);
          parsedContents = this.ElementRegex("GeneratedDateTime").Replace(parsedContents, DateTime.Now.ToString("yyyy.MMdd.HHmm.ssff"));
          parsedContents = this.ElementRegex("GoogleAnalyticsTrackingCode").Replace(parsedContents, Global.SiteSettings.GoogleAnalyticsTrackingCode);

          Regex regex1 = this.ListRegex("navigationList");
          Regex categoryRegex = this.ListRegex("CategoryList");
          parsedContents = categoryRegex.Replace(parsedContents, new MatchEvaluator(this.ReplaceCategoryList));
          Regex siteLinkRegex = this.ListRegex("LinkList");
          parsedContents = siteLinkRegex.Replace(parsedContents, new MatchEvaluator(this.ReplaceLinkList));


          string pathC = "";// this.BaseOutputPath;
          string pathA = "/" + this.Article.TitleUrl;

          if (this.Article.Category == "(None)")
          {
            parsedContents = this.ElementRegex("TitleUrl").Replace(parsedContents, this.Article.TitleUrl);
            parsedContents = this.ElementRegex("CategoryTitle").Replace(parsedContents, "");
            parsedContents = this.ElementRegex("Permalink").Replace(parsedContents, Global.SiteSettings.SiteUrl + "/" + this.Article.TitleUrl);
          }
          else
          {
            //Category category = Global.CategoryIndexNew.Get(this.Article.Category);
            //if (category != null)
            //{
              parsedContents = this.ElementRegex("Permalink").Replace(parsedContents, Global.SiteSettings.SiteUrl + "/" + this.Article.Category + "/" + this.Article.TitleUrl);
              parsedContents = this.ElementRegex("TitleUrl").Replace(parsedContents, this.Article.Category);
              parsedContents = this.ElementRegex("CategoryTitle").Replace(parsedContents, this.Article.CategoryTitle);
              pathC = "/" + this.Article.Category;
            //}
          }


          //string outputFileName = DateTime.Now.ToString("yyyyMMdd-HHmmss") + ".html";
          //string outputFilePath = this.BaseOutputPath + outputFileName;

          //if (this.Preview)
          //{
          //  this.BaseOutputPath = this.BaseOutputPath + "/preview/";
          //  if (!Directory.Exists(this.BaseOutputPath))
          //  {
          //    Directory.CreateDirectory(this.BaseOutputPath);
          //  }
          //}

          if (!Directory.Exists(this.BaseOutputPath + pathC))
          {
            Directory.CreateDirectory(this.BaseOutputPath + pathC);
          }
          if (!Directory.Exists(this.BaseOutputPath + pathC + pathA))
          {
            Directory.CreateDirectory(this.BaseOutputPath + pathC + pathA);
          }
          if (!Directory.Exists(this.BaseOutputPath + "/" + this.AlternativeOutputPath + pathC))
          {
            Directory.CreateDirectory(this.BaseOutputPath + "/" + this.AlternativeOutputPath + pathC);
          }
          if (!Directory.Exists(this.BaseOutputPath + "/" + this.AlternativeOutputPath + pathC + pathA))
          {
            Directory.CreateDirectory(this.BaseOutputPath + "/" + this.AlternativeOutputPath + pathC + pathA);
          }

          using (StreamWriter streamWriter = new StreamWriter(this.BaseOutputPath + pathC + pathA + "/index.html"))
          {
            streamWriter.Write(parsedContents);
          }
          using (StreamWriter streamWriter = new StreamWriter(this.BaseOutputPath + "/" + this.AlternativeOutputPath + pathC + pathA + "/index.html"))
          {
            streamWriter.Write(parsedContents);
          }
          return pathA;
        }

      }
      return "File not exist";
    }

    /// <summary>
    /// TODO: One of the menu items needs to be highlighted!
    /// </summary>
    /// <param name="match"></param>
    /// <returns></returns>
    private string ReplaceNavigationList(Match match)
    {
      StringBuilder sb = new StringBuilder();
      return sb.ToString();
    }

    private string ReplaceCategoryList(Match match)
    {
      StringBuilder sb = new StringBuilder();
      if (match.Groups.Count > 1)
      {
        Group listItemGroup = match.Groups[1];
        foreach (Category category in Global.CategoryIndexNew.IndexList)
        {
          //sb.Append(this.ItemRegex("CategoryList", "Title").Replace(this.ItemRegex("CategoryList", "Url").Replace(listItemGroup.Value, category.Url);, category.Title));
          string temp = this.ItemRegex("CategoryList", "Url").Replace(listItemGroup.Value, category.Url);
          sb.Append(this.ItemRegex("CategoryList", "Title").Replace(temp, category.Title));
        }
      }
      return sb.ToString();
    }

    private string ReplaceLinkList(Match match)
    {
      StringBuilder sb = new StringBuilder();
      if (match.Groups.Count > 1)
      {
        Group listItemGroup = match.Groups[1];
        foreach (SiteLink siteLink in Global.SiteLinkIndex.List)
        {
          //sb.Append(this.ItemRegex("CategoryList", "Title").Replace(this.ItemRegex("CategoryList", "Url").Replace(listItemGroup.Value, category.Url);, category.Title));
          string temp = this.ItemRegex("LinkList", "Url").Replace(listItemGroup.Value, siteLink.Url);
          sb.Append(this.ItemRegex("LinkList", "Title").Replace(temp, siteLink.Title));
        }
      }
      return sb.ToString();
    }

    //
    // A "List Template Parser" consists of the following:
    //
    // List
    //
    // Regex
    //
    // MatchEvaluator
    //

  }
}