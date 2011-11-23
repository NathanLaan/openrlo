using System;
using System.Text;
using System.IO;
using OpenRLO.Data;

namespace OpenRLO.Data
{
  public class SiteSettings
  {


    public string CreatePageTitle(string pageName)
    {
      return new StringBuilder(this.SiteName).Append(" :: ").Append(pageName).ToString();
    }


    public string SiteName { get; set; }
    public string SiteUrl { get; set; }
    public string SiteCopyright { get; set; }
    //public string SiteFeedDescription { get; set; }
    //public string TimeZone { get; set; }
    //public string ShortURL { get; set; }
    //public int ShortUrlLength { get; set; }
    //public string UploadSiteUrl { get; set; }
    public string GoogleAnalyticsTrackingCode { get; set; }

    //private string siteFeedUrl;
    //public string SiteFeedUrl
    //{
    //  get {
    //    if (string.IsNullOrEmpty(this.siteFeedUrl))
    //    {
    //      return this.SiteUrl + "/feed";
    //    }
    //    else
    //    {
    //      return this.siteFeedUrl;
    //    }
    //  }
    //  set { siteFeedUrl = value; }
    //}

    private string filename = "/App_Data/IndexSiteSettingsDefault.txt";
    public string Filename
    {
      get { return filename; }
      set { filename = value; }
    }

    public void Set(SiteSettings siteSettings)
    {
      this.SiteName = siteSettings.SiteName;
      this.SiteUrl = siteSettings.SiteUrl;
      this.SiteCopyright = siteSettings.SiteCopyright;
      this.GoogleAnalyticsTrackingCode = siteSettings.GoogleAnalyticsTrackingCode;
    }

    public SiteSettings()
    {
    }

    public SiteSettings(string filename)
    {
      this.filename = filename;
    }

    public void Save()
    {
      StringBuilder sb = new StringBuilder();
      sb.Append(this.SiteName);
      sb.Append(Constants.IndexEntryDelimiter);
      sb.Append(this.SiteUrl);
      sb.Append(Constants.IndexEntryDelimiter);
      sb.Append(this.SiteCopyright);
      sb.Append(Constants.IndexEntryDelimiter);
      sb.Append(this.GoogleAnalyticsTrackingCode);
      sb.Append(Constants.IndexEntryDelimiter);
      sb.Append(Environment.NewLine);
      using (StreamWriter streamWriter = new StreamWriter(this.Filename))
      {
        streamWriter.Write(sb.ToString());
      }
    }

    public void Load()
    {
      bool loadDefaults = false;
      if (File.Exists(this.Filename))
      {
        using (StreamReader sr = new StreamReader(this.Filename))
        {
          string fullFileContents = sr.ReadToEnd();
          if (fullFileContents != null && fullFileContents != string.Empty)
          {
            string[] indexEntries = fullFileContents.Split(Constants.IndexEntryDelimiter);
            this.SiteName = indexEntries[0];
            this.SiteUrl = indexEntries[1];
            this.SiteCopyright = indexEntries[2];
            this.GoogleAnalyticsTrackingCode = indexEntries[3];
          }
          else
          {
            loadDefaults = true;
          }
        }
      }
      else
      {
        loadDefaults = true;
      }
      if (loadDefaults)
      {
        // Load Defaults
        this.SiteName = "OpenRLO";
        this.SiteUrl = "http://openrlo.com";
        this.SiteCopyright = "Copyright &copy; OpenRLO.com 2011";
        this.GoogleAnalyticsTrackingCode = "UA-3918071-1";
      }
    }

  }
}