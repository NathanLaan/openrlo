using System;
using System.Text;
using System.Web;
using System.IO;

namespace OpenRLO.Web.Data
{
  public class ArticleVersion
  {

    //public Article ParentArticle;
    //public string contents;
    public string Contents { get; set; }
    //{
    //  set {
    //    this.contents = value;
    //  }
    //  get {
    //    return this.contents; 
    //  }
    //}
    public string ContentsShort
    {
      get {
        string[] stringSeparators = new string[] {" "};
        string[] parts = this.Contents.Split(stringSeparators, StringSplitOptions.RemoveEmptyEntries);
        bool endEarly = false;
        int max = 10;
        if (max > parts.Length)
        {
          max = parts.Length;
          endEarly = true;
        }
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < max; i++)
        {
          if (i > 0)
          {
            sb.Append(" ");
          }
          sb.Append(parts[i]);
        }
        if (!endEarly)
        {
          sb.Append("...");          
        }
        return sb.ToString();
      }
    }

    //private string filename;
    public string Filename { get; set; }
    //{
    //  set
    //  {
    //    this.filename = value;
    //  }
    //  get
    //  {
    //    //return ParentArticle.Category + "_" + ParentArticle.TitleUrl + "_" + Version + "_" + this.DateTime.ToString("yyyyMMdd_HHmm") + ".txt";
    //    //return Version + "_" + this.DateTime.ToString("yyyyMMdd_HHmm") + ".txt";
    //    return this.filename;
    //  }
    //}

    #region Version
    //private int version = 1;
    public int Version { get; set; }
    //{
    //  get { return version; }
    //  set { version = value; }
    //}
    #endregion

    public DateTime DateTime { get; set; }

    public ArticleVersion()
    {
      this.Version = 1;
    }

    public bool Save()
    {
      //
      //TODO: error handling
      //
      StringBuilder sb = new StringBuilder();
      sb.Append(Contents);
      string p = HttpContext.Current.Server.MapPath("/App_Data/" + this.Filename);
      using (StreamWriter s = new StreamWriter(p))
      {
        s.Write(sb.ToString());
      }
      return true;
    }

    public void Load()
    {
      //TODO: more error handling
      //TODO: load lines as articles

      string mappedPath = HttpContext.Current.Server.MapPath("/App_Data/" + this.Filename);
      //HttpContext.Current.Response.Write("ARTICLEVERSION-INDEX-PATH: " + mappedPath + "<br>");
      if (File.Exists(mappedPath))
      {
        using (StreamReader sr = new StreamReader(mappedPath))
        {
          string fullFileContents = sr.ReadToEnd();
          if (fullFileContents != null && fullFileContents != string.Empty)
          {
            this.Contents = fullFileContents;
          }
          else
          {
            //TODO: Better error message
            this.Contents = "There was a problem loading the article...";
          }
        }
      }
      else
      {
        //TODO: Better error message
        this.Contents = "Article not found";
      }
    }

    public override string ToString()
    {
      //if (this.ParentArticle != null)
      //{
      //  return this.ParentArticle.Title + " Version " + this.Version.ToString();
      //}
      //else
      {
        return "Version " + this.Version.ToString();
      }
    }

  }
}