using System;
using System.Collections.Generic;
using System.Text;
using System.Web;
using System.IO;

namespace OpenRLO.Web.Data
{

  public class Article : IComparable<Article>
  {

    #region IComparable
    /*
     * Less than zero     This object is less than the other parameter.
     * Zero               This object is equal to other.
     * Greater than zero  This object is greater than other.
     * */
    public int CompareTo(Article other)
    {
      //return this.LatestArticleVersion.DateTime.CompareTo(other.LatestArticleVersion.DateTime);
      //return this.articleVersionList[0].DateTime.CompareTo(other.articleVersionList[0].DateTime);
      //return other.articleVersionList[0].DateTime.CompareTo(this.articleVersionList[0].DateTime);

      //
      // Fix: We want articles on the main page to be displayed in the order of the last revision.
      //
      //return other.LatestArticleVersion.DateTime.CompareTo(this.LatestArticleVersion.DateTime);
      return other.PublishedDateTime.CompareTo(this.PublishedDateTime);
    }
    #endregion

    #region Status/Published
    public static readonly string STATUS_PUBLISHED = "published";
    public static readonly string STATUS_DRAFT = "draft";

    private string status = STATUS_PUBLISHED;
    public string Status
    {
      get { return status; }
      set { status = value; }
    }
    public bool Published
    {
      set
      {
        if (value)
        {
          this.status = Article.STATUS_PUBLISHED;
        }
        else
        {
          this.status = Article.STATUS_DRAFT;
        }
      }
      get
      {
        return this.status == Article.STATUS_PUBLISHED;
      }
    }
    #endregion

    public string CategoryTitle
    {
      get
      {
        //if (this.Category != "(None)")
        //{
        //  Category c = Global.CategoryIndexNew.Get(this.Category);
        //  if (c != null)
        //  {
        //    return c.Title;
        //  }
        //}
        return this.Category;
      }
    }

    public DateTime PublishedDateTime { get; set; }
    public string Category { get; set; }
    public string Title { get; set; }
    public string TitleUrl { get; set; }
    //public void GenerateTitleUrl()
    //{
    //  this.TitleUrl = Title.Trim().ToLower().Replace(" ", "-");
    //}

    public string Filename { get; set; }
    public string GenerateArticleFilename()
    {
      return this.TitleUrl + ".txt";
    }
    public string GenerateArticleVersionFilename(ArticleVersion articleVersion)
    {
      return this.TitleUrl + "_" + articleVersion.Version + "_" + articleVersion.DateTime.ToString("yyyyMMdd_HHmm") + ".txt";
    }

    private List<ArticleVersion> articleVersionList = new List<ArticleVersion>();
    public List<ArticleVersion> ArticleVersionList
    {
      get { return articleVersionList; }
      set { articleVersionList = value; }
    }

    public string ViewUrl
    {
      get
      {
        //this.GenerateTitleUrl();
        if (this.Category == "(None)")
        {
          return "/" + this.TitleUrl;
        }
        else
        {
          return "/" + this.Category + "/" + this.TitleUrl;
        }
      }
    }

    public string AdminUrl
    {
      get
      {
        return "/admin/article/edit/" + this.TitleUrl;
      }
    }

    public string ShortUrl { get; set; }
    public ArticleVersion LatestArticleVersion { get; set; }
    public string LatestArticleContentsHtml
    {
      get
      {
        if (this.LatestArticleVersion != null)
        {
          Markdown markdown = new Markdown();
          return markdown.Transform(this.LatestArticleVersion.Contents);
        }
        return "";
      }
    }

    private List<string> tagList = new List<string>();

    public void AddArticleVersion(ArticleVersion articleVersion)
    {
      this.ArticleVersionList.Add(articleVersion);
      this.LatestArticleVersion = articleVersion;
    }

    public bool Save()
    {
      StringBuilder sb = new StringBuilder();
      foreach (ArticleVersion articleVersion in this.ArticleVersionList)
      {
        articleVersion.Filename = this.GenerateArticleVersionFilename(articleVersion);
        sb.Append(articleVersion.Version);
        sb.Append(Constants.IndexEntryDelimiter);
        sb.Append(articleVersion.DateTime);
        sb.Append(Constants.IndexEntryDelimiter);
        sb.Append(articleVersion.Filename);
        sb.Append(Constants.IndexEntryDelimiter);
        sb.Append(Environment.NewLine);
      }
      string p = HttpContext.Current.Server.MapPath("/App_Data/" + this.Filename);
      using (StreamWriter s = new StreamWriter(p))
      {
        s.Write(sb.ToString());
      }
      return true;
    }

    public bool SaveAll()
    {
      StringBuilder sb = new StringBuilder();
      foreach (ArticleVersion articleVersion in this.ArticleVersionList)
      {
        articleVersion.Filename = this.GenerateArticleVersionFilename(articleVersion);
        sb.Append(articleVersion.Version);
        sb.Append(Constants.IndexEntryDelimiter);
        sb.Append(articleVersion.DateTime);
        sb.Append(Constants.IndexEntryDelimiter);
        sb.Append(articleVersion.Filename);
        sb.Append(Constants.IndexEntryDelimiter);
        sb.Append(Environment.NewLine);
        articleVersion.Save();
      }
      string p = HttpContext.Current.Server.MapPath("/App_Data/" + this.Filename);
      using (StreamWriter s = new StreamWriter(p))
      {
        s.Write(sb.ToString());
      }
      return true;
    }

    public void Load()
    {
      this.ArticleVersionList.Clear();
      //TODO: more error handling
      string mappedPath = HttpContext.Current.Server.MapPath("/App_Data/" + this.Filename);
      //HttpContext.Current.Response.Write("ARTICLE-INDEX-PATH: " + mappedPath + "<br>");
      if( File.Exists(mappedPath))
      {
        using (StreamReader sr = new StreamReader(mappedPath))
        {
          string fullFileContents = sr.ReadToEnd();
          if (fullFileContents != null && fullFileContents != string.Empty)
          {
            string[] fileLines = fullFileContents.Split(Environment.NewLine.ToCharArray());
            foreach (string line in fileLines)
            {
              if (line != null && line != string.Empty)
              {
                string[] indexEntries = line.Split(Constants.IndexEntryDelimiter);
                ArticleVersion articleVersion = new ArticleVersion();
                //articleVersion.ParentArticle = this;
                articleVersion.Version = int.Parse(indexEntries[0]);
                articleVersion.DateTime = DateTime.Parse(indexEntries[1]);
                articleVersion.Filename = indexEntries[2];
                articleVersion.Filename = this.GenerateArticleVersionFilename(articleVersion);
                articleVersion.Load();
                this.ArticleVersionList.Add(articleVersion);

                if (this.LatestArticleVersion == null)
                {
                  this.LatestArticleVersion = articleVersion;
                }
                else
                {
                  /*
                   * Less than zero       t1 is earlier than t2.
                   * Zero                 t1 is the same as t2.
                   * Greater than zero    t1 is later than t2.
                   */
                  //if (DateTime.Compare(this.LatestArticleVersion.DateTime, articleVersion.DateTime) < 0)
                  if (articleVersion.Version > this.LatestArticleVersion.Version)
                  {
                    this.LatestArticleVersion = articleVersion;
                  }
                }
              }
            }
          }
        }
      }
    }

  }
}