using System;
using System.Collections.Generic;
using System.IO;
using System.Web;
using System.Text;

namespace OpenRLO.Web.Data
{
  public sealed class ArticleIndex
  {

    #region BasePath
    private string basePath = "/App_Data/";
    public string BasePath
    {
      get { return basePath; }
      set { basePath = value; }
    }
    #endregion

    #region Filename
    private string filename = "/App_Data/index.txt";
    public string Filename
    {
      get { return filename; }
      set { filename = value; }
    }
    #endregion

    #region ArticleList
    private List<Article> articleList;
    public List<Article> List
    {
      get { return articleList; }
    }
    #endregion


    public ArticleIndex()
    {
      this.articleList = new List<Article>();
    }


    public void Load()
    {
      this.articleList.Clear();

      bool saveAfterLoading = false;

      if (File.Exists(this.Filename))
      {
        using (StreamReader sr = new StreamReader(this.Filename))
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
                if (indexEntries.Length > 2)
                {
                  Article article = new Article();
                  article.Category = indexEntries[0];
                  article.Title = indexEntries[1];
                  article.TitleUrl = indexEntries[2];
                  //article.Filename = indexEntries[3];
                  article.Published = bool.Parse(indexEntries[3]);
                  article.ShortUrl = indexEntries[4];
                  try
                  {
                    article.PublishedDateTime = DateTime.Parse(indexEntries[5]);
                  }
                  catch
                  {
                    article.PublishedDateTime = DateTime.MinValue;
                  }
                  //HttpContext.Current.Response.Write("ARTICLE: " + article.Title + " TURL: " + article.TitleUrl + " F: " + article.Filename + "<br>");
                  article.Filename = article.GenerateArticleFilename();
                  article.Load();
                  this.articleList.Add(article);
                }
              }
            }
            this.articleList.Sort();
            //this.articleList.Reverse();
          }
        }
      }
      else
      {
        //TODO: nothing???
      }

      if (saveAfterLoading)
      {
        this.Save();
      }
    }

    public void Save()
    {
      StringBuilder sb = new StringBuilder();
      foreach (Article article in this.articleList)
      {
        article.Filename = article.GenerateArticleFilename();
        sb.Append(article.Category);
        sb.Append(Constants.IndexEntryDelimiter);
        sb.Append(article.Title);
        sb.Append(Constants.IndexEntryDelimiter);
        sb.Append(article.TitleUrl);
        //sb.Append(Constants.IndexEntryDelimiter);
        //sb.Append(article.Filename);
        sb.Append(Constants.IndexEntryDelimiter);
        sb.Append(article.Published.ToString());
        sb.Append(Constants.IndexEntryDelimiter);
        sb.Append(article.ShortUrl);
        sb.Append(Constants.IndexEntryDelimiter);
        if (article.PublishedDateTime == DateTime.MinValue)
        {
          try
          {
            article.PublishedDateTime = article.ArticleVersionList[0].DateTime;
          }
          catch
          {
            article.PublishedDateTime = DateTime.MinValue;
          }
        }
        sb.Append(article.PublishedDateTime);
        sb.Append(Constants.IndexEntryDelimiter);
        sb.Append(Environment.NewLine);
      }
      using (StreamWriter streamWriter = new StreamWriter(this.Filename))
      {
        streamWriter.Write(sb.ToString());
      }
    }

    public void SaveAll()
    {
      StringBuilder sb = new StringBuilder();
      foreach (Article article in this.articleList)
      {
        article.Filename = article.GenerateArticleFilename();
        sb.Append(article.Category);
        sb.Append(Constants.IndexEntryDelimiter);
        sb.Append(article.Title);
        sb.Append(Constants.IndexEntryDelimiter);
        sb.Append(article.TitleUrl);
        //sb.Append(Constants.IndexEntryDelimiter);
        //sb.Append(article.Filename);
        sb.Append(Constants.IndexEntryDelimiter);
        sb.Append(article.Published.ToString());
        sb.Append(Constants.IndexEntryDelimiter);
        sb.Append(article.ShortUrl);
        sb.Append(Constants.IndexEntryDelimiter);
        if (article.PublishedDateTime == DateTime.MinValue)
        {
          try
          {
            article.PublishedDateTime = article.ArticleVersionList[0].DateTime;
          }
          catch
          {
            article.PublishedDateTime = DateTime.MinValue;
          }
        }
        sb.Append(article.PublishedDateTime);
        sb.Append(Constants.IndexEntryDelimiter);
        sb.Append(Environment.NewLine);
        article.SaveAll();
      }
      using (StreamWriter streamWriter = new StreamWriter(this.Filename))
      {
        streamWriter.Write(sb.ToString());
      }
    }


    private static string ShortUrlCharacters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    public string GenerateShortURL()
    {
      int max = ShortUrlCharacters.Length;
      Random random = new Random();
      string shortUrl;
      char c1, c2, c3;
      while (true)
      {
        c1 = ShortUrlCharacters[random.Next(0, max)];
        c2 = ShortUrlCharacters[random.Next(0, max)];
        c3 = ShortUrlCharacters[random.Next(0, max)];
        shortUrl = new string(new char[] { c1, c2, c3 });
        if (!this.ShortUrlExists(shortUrl))
        {
          return shortUrl;
        }
      }    
    }

    public bool ShortUrlExists(string shortUrl)
    {
      foreach (Article article in this.articleList)
      {
        if (article.ShortUrl == shortUrl)
        {
          return true;
        }
      }
      return false;
    }

    public bool TitleUrlExists(string titleUrl)
    {
      foreach (Article article in this.articleList)
      {
        if (article.TitleUrl == titleUrl)
        {
          return true;
        }
      }
      return false;
    }

    public bool ArticleExists(Article article)
    {
      foreach (Article a in this.articleList)
      {
        if (a.Category.ToLower() == article.Category.ToLower() && a.Title.ToLower() == article.Title.ToLower())
        {
          return true;
        }
      }
      return false;
    }
    //public bool ArticleExists(string categoryName, string articleTitle)
    //{
    //  foreach (Article a in this.articleList)
    //  {
    //    if (a.Category.ToLower() == categoryName.ToLower() && a.Title.ToLower() == articleTitle.ToLower())
    //    {
    //      return true;
    //    }
    //  }
    //  return false;
    //}

    public bool DeleteArticle(string categoryName, string articleTitle)
    {
      foreach (Article a in this.articleList)
      {
        if (a.Category.ToLower() == categoryName.ToLower() && a.Title.ToLower() == articleTitle.ToLower())
        {
          this.articleList.Remove(a);
          //
          // TODO: Delete files?
          //
          this.Save();
          return true;
        }
      }
      return false;
    }

    public void AddArticle(Article article)
    {
      //add to list
      this.articleList.Add(article);
      this.articleList.Sort();
    }


    #region GetArticle

    /// <summary>
    /// 
    /// </summary>
    /// <param name="categoryName"></param>
    /// <param name="articleTitleURL">The path of the URL after the domain and category</param>
    /// <returns></returns>
    public Article GetArticle(string categoryName, string articleTitleURL)
    {
      //TODO: for now we take the first article in the list.
      //TODO: determine how to handle versioning
      articleTitleURL = articleTitleURL.ToLower();
      foreach (Article article in this.articleList)
      {
        if (string.IsNullOrEmpty(categoryName))
        {
          if (article.TitleUrl == articleTitleURL)
          {
            return article;
          }
        }
        else
        {
          if (article.Category == categoryName && article.TitleUrl == articleTitleURL)
          {
            return article;
          }
        }
      }
      return null;
    }

    public Article GetArticle(string shortURL)
    {
      //TODO: for now we take the first article in the list.
      //TODO: determine how to handle versioning
      foreach (Article article in this.articleList)
      {
        if (article.ShortUrl == shortURL)
        {
          return article;
        }
      }
      return null;
    }

    #endregion

    public List<Article> GetArticleList()
    {
      List<Article> list = new List<Article>();

      foreach (Article a in this.articleList)
      {
        if (a.Published)
        {
          list.Add(a);
        }
      }

      return list;
    }

    public List<Article> GetArticleListPublishedWithCategory()
    {
      List<Article> list = new List<Article>();

      foreach (Article a in this.articleList)
      {
        if (a.Published && a.Category != "(None)")
        {
          list.Add(a);
        }
      }

      return list;
    }

    public List<Article> GetArticleList(string categoryName)
    {
      string cnLower = categoryName.ToLower();
      List<Article> returnList = new List<Article>();
      foreach (Article article in this.articleList)
      {
        if (cnLower.Equals(article.Category.ToLower()) && article.Published)
        {
          returnList.Add(article);
        }
      }
      returnList.Sort();
      return returnList;
    }

    #region PAGING

    public const int DEFAULT_PAGE_SIZE = 10;

    public bool IsLastPage(string category, int pageNumber, int pageSize = DEFAULT_PAGE_SIZE)
    {
      List<Article> sourceList = null;
      if (category != null)
      {
        sourceList = this.GetArticleList(category);
      }
      else
      {
        sourceList = this.GetArticleList();
      }
      return ((pageNumber * pageSize) >= sourceList.Count);
    }

    public List<Article> GetArticleListPublishedWithCategory(int pageNumber, int pageSize = DEFAULT_PAGE_SIZE)
    {
      pageNumber = pageNumber - 1;
      int index = 0;
      int index1 = pageNumber * pageSize;
      int index2 = (pageNumber + 1) * pageSize;
      List<Article> returnlist = new List<Article>();
      List<Article> sourceList = this.articleList;
      foreach (Article a in sourceList)
      {
        if (index >= index2)
        {
          break;
        }
        if (a.Published && a.Category != "(None)")
        {
          if (index >= index1)
          {
            returnlist.Add(a);
          }
          index++;
        }
      }
      return returnlist;
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="pageNumber">Starts at 1 (ONE)! Note that internally pageNumber starts at ZERO.</param>
    /// <param name="pageSize"></param>
    /// <returns></returns>
    public List<Article> GetArticleList(int pageNumber, int pageSize = DEFAULT_PAGE_SIZE)
    {
      return this.GetArticleList(null, pageNumber, pageSize);
    }

    /// <summary>
    /// 
    /// </summary>
    /// <param name="category"></param>
    /// <param name="pageNumber">Starts at 1 (ONE)! Note that internally pageNumber starts at ZERO.</param>
    /// <param name="pageSize"></param>
    /// <returns></returns>
    public List<Article> GetArticleList(string category, int pageNumber, int pageSize = DEFAULT_PAGE_SIZE)
    {
      pageNumber = pageNumber - 1;
      int index = 0;
      int index1 = pageNumber * pageSize;
      int index2 = (pageNumber + 1) * pageSize;
      List<Article> returnlist = new List<Article>();
      List<Article> sourceList = this.articleList;
      if (category != null)
      {
        sourceList = this.GetArticleList(category);
      }
      foreach (Article a in sourceList)
      {
        if (index >= index2)
        {
          break;
        }
        if (a.Published)
        {
          if (index >= index1)
          {
            returnlist.Add(a);
          }
          index++;
        }
      }
      return returnlist;
    }

    #endregion

    #region GetCategoryList

    public List<string> GetCategoryList()
    {
      List<string> categoryList = new List<string>();
      foreach (Article article in this.articleList)
      {
        if (!categoryList.Contains(article.Category.ToLower()))
        {
          categoryList.Add(article.Category.ToLower());
        }
      }
      return categoryList;
    }

    #endregion

  }
}
