using System;
using System.Collections.Generic;
using System.IO;
using System.Web;
using System.Text.RegularExpressions;
using System.Text;

namespace OpenRLO.Web.Data
{
  public class AnetroTemplateIndex : AnetroTemplate
  {

    public static void Run()
    {
      AnetroTemplateIndex anetroTemplateIndex = new AnetroTemplateIndex(AnetroTemplateEngine.TemplatePathIndex, AnetroTemplateEngine.TemplatePathBase);
      anetroTemplateIndex.Generate();
    }

    public AnetroTemplateIndex(string templateFilePath, string baseOutputPath)
    {
      this.TemplateFilePath = templateFilePath;
      this.BaseOutputPath = baseOutputPath;
    }

    private int numPages;
    private int pageSize = 15;
    private int pageNumber;

    public void Generate()
    {

      //
      // TODO: Don't include article with "NULL" category.
      //

      if (File.Exists(this.TemplateFilePath))
      {
        string templateContents = "";
        using (StreamReader sr = new StreamReader(this.TemplateFilePath))
        {
          templateContents = sr.ReadToEnd();
        }

        numPages = (int)Math.Ceiling((double)Global.ArticleIndex.List.Count / (double)pageSize);

        for (int i = 0; i < numPages; i++)
        {
          this.pageNumber = i + 1;
          string parsedContents = templateContents;
          parsedContents = this.ElementRegex("GeneratedDateTime").Replace(parsedContents, DateTime.Now.ToString("yyyy.MMdd.HHmm.ssff"));
          parsedContents = this.ElementRegex("GoogleAnalyticsTrackingCode").Replace(parsedContents, Global.SiteSettings.GoogleAnalyticsTrackingCode);
          parsedContents = this.ElementRegex("SiteVersion").Replace(parsedContents, Global.SiteVersion);
          parsedContents = this.ElementRegex("SiteName").Replace(parsedContents, Global.SiteSettings.SiteName);
          parsedContents = this.ElementRegex("SiteCopyright").Replace(parsedContents, Global.SiteSettings.SiteCopyright);
          parsedContents = this.ElementRegex("FeedLink.Url").Replace(parsedContents, Global.SiteSettings.SiteFeedUrl);
          //parsedContents = this.ElementRegex("FeedLink.Title").Replace(parsedContents, Global.SiteSettings.SiteFeedDescription);
          Regex categoryRegex = this.ListRegex("CategoryList");
          parsedContents = categoryRegex.Replace(parsedContents, new MatchEvaluator(this.ReplaceCategoryList));
          Regex siteLinkRegex = this.ListRegex("LinkList");
          parsedContents = siteLinkRegex.Replace(parsedContents, new MatchEvaluator(this.ReplaceLinkList));
          Regex articleRegex = this.ListRegex("ArticleList");
          parsedContents = articleRegex.Replace(parsedContents, new MatchEvaluator(this.ReplaceArticleList));

          //
          // TODO: Paging
          //
          if (this.pageNumber == 1)
          {
            parsedContents = this.ElementRegex("PrevPage.URL").Replace(parsedContents, "");
            parsedContents = this.ElementRegex("PrevPage.Title").Replace(parsedContents, "");
            parsedContents = this.ElementRegex("PrevPage.Label").Replace(parsedContents, "&laquo&nbsp;Newer");
          }
          else
          {
            parsedContents = this.ElementRegex("PrevPage.URL").Replace(parsedContents, "/page/" + (this.pageNumber - 1));
            parsedContents = this.ElementRegex("PrevPage.Title").Replace(parsedContents, "&laquo&nbsp;Newer");
            parsedContents = this.ElementRegex("PrevPage.Label").Replace(parsedContents, "");
          }
          if (Global.ArticleIndex.IsLastPage(null, this.pageNumber, pageSize))
          {
            parsedContents = this.ElementRegex("NextPage.URL").Replace(parsedContents, "");
            parsedContents = this.ElementRegex("NextPage.Title").Replace(parsedContents, "");
            parsedContents = this.ElementRegex("NextPage.Label").Replace(parsedContents, "Older&nbsp;&raquo;");
          }
          else
          {
            parsedContents = this.ElementRegex("NextPage.URL").Replace(parsedContents, "/page/" + (this.pageNumber + 1));
            parsedContents = this.ElementRegex("NextPage.Title").Replace(parsedContents, "Older&nbsp;&raquo;");
            parsedContents = this.ElementRegex("NextPage.Label").Replace(parsedContents, "");
          }

          this.SavePage(parsedContents, this.pageNumber);
        }

      }

    }


    private void SavePage(string pageContents, int pageNumber)
    {
      //
      // The first page is also written to "index.html" and all pages are written to "/page/NUMBER/index.html"
      //

      if (pageNumber == 1)
      {
        using (StreamWriter streamWriter = new StreamWriter(this.BaseOutputPath + "/index.html"))
        {
          streamWriter.Write(pageContents);
        }
        if (!Directory.Exists(this.BaseOutputPath + "/" + this.AlternativeOutputPath))
        {
          Directory.CreateDirectory(this.BaseOutputPath + "/" + this.AlternativeOutputPath);
        }
        using (StreamWriter streamWriter = new StreamWriter(this.BaseOutputPath + "/" + this.AlternativeOutputPath + "/index.html"))
        {
          streamWriter.Write(pageContents);
        }
      }

      if (!Directory.Exists(this.BaseOutputPath + "/page/"))
      {
        Directory.CreateDirectory(this.BaseOutputPath + "/page/");
      }
      if (!Directory.Exists(this.BaseOutputPath + "/page/" + pageNumber + "/"))
      {
        Directory.CreateDirectory(this.BaseOutputPath + "/page/" + pageNumber + "/");
      }
      using (StreamWriter streamWriter = new StreamWriter(this.BaseOutputPath + "/page/" + pageNumber + "/index.html"))
      {
        streamWriter.Write(pageContents);
      }

      if (!Directory.Exists(this.BaseOutputPath + "/" + this.AlternativeOutputPath + "/page/"))
      {
        Directory.CreateDirectory(this.BaseOutputPath + "/" + this.AlternativeOutputPath + "/page/");
      }
      if (!Directory.Exists(this.BaseOutputPath + "/" + this.AlternativeOutputPath + "/page/" + pageNumber + "/"))
      {
        Directory.CreateDirectory(this.BaseOutputPath + "/" + this.AlternativeOutputPath + "/page/" + pageNumber + "/");
      }
      using (StreamWriter streamWriter = new StreamWriter(this.BaseOutputPath + "/" + this.AlternativeOutputPath + "/page/" + pageNumber + "/index.html"))
      {
        streamWriter.Write(pageContents);
      }
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


    private string ReplaceArticleList(Match match)
    {
      StringBuilder sb = new StringBuilder();
      if (match.Groups.Count > 1)
      {
        Group listItemGroup = match.Groups[1];

        int articleMin = (this.pageNumber * this.pageSize) - this.pageSize;
        int articleMax = (this.pageNumber * this.pageSize);
        List<Article> articleList = Global.ArticleIndex.GetArticleListPublishedWithCategory(this.pageNumber, this.pageSize);
        foreach (Article article in articleList)
        {
          //sb.Append(this.ItemRegex("CategoryList", "Title").Replace(this.ItemRegex("CategoryList", "Url").Replace(listItemGroup.Value, category.Url);, category.Title));
          string temp = this.ItemRegex("ArticleList", "Category").Replace(listItemGroup.Value, article.Category);
          temp = this.ItemRegex("ArticleList", "Title").Replace(temp, article.Title);
          temp = this.ItemRegex("ArticleList", "TitleUrl").Replace(temp, article.TitleUrl);
          temp = this.ItemRegex("ArticleList", "PublishedDateTime").Replace(temp, article.PublishedDateTime.ToString(Global.DateTimeFormatString));
          sb.Append(this.ItemRegex("ArticleList", "LatestArticleContentsHtml").Replace(temp, article.LatestArticleContentsHtml));
        }
      }
      return sb.ToString();
    }


  }
}