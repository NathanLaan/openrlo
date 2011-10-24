using System;
using System.Text;
using System.IO;

namespace OpenRLO.Web.Data
{
  public class SiteSettings
  {

    public string SiteName { get; set; }
    public string SiteUrl { get; set; }
    public string SiteCopyright { get; set; }
    public string SiteFeedDescription { get; set; }
    public string TimeZone { get; set; }
    public string ShortURL { get; set; }
    public int ShortUrlLength { get; set; }
    public string UploadSiteUrl { get; set; }
    public string GoogleAnalyticsTrackingCode { get; set; }

    private string siteFeedUrl;
    public string SiteFeedUrl
    {
      get {
        if (string.IsNullOrEmpty(this.siteFeedUrl))
        {
          return this.SiteUrl + "/feed";
        }
        else
        {
          return this.siteFeedUrl;
        }
      }
      set { siteFeedUrl = value; }
    }

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
      this.SiteFeedDescription = siteSettings.SiteFeedDescription;
      this.SiteFeedUrl = siteSettings.SiteFeedUrl;
      this.TimeZone = siteSettings.TimeZone;
      this.ShortURL = siteSettings.ShortURL;
      this.ShortUrlLength = siteSettings.ShortUrlLength;
      this.UploadSiteUrl = siteSettings.UploadSiteUrl;
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
      sb.Append(this.SiteFeedDescription);
      sb.Append(Constants.IndexEntryDelimiter);
      sb.Append(this.SiteFeedUrl);
      sb.Append(Constants.IndexEntryDelimiter);
      sb.Append(this.TimeZone);
      sb.Append(Constants.IndexEntryDelimiter);
      sb.Append(this.ShortURL);
      sb.Append(Constants.IndexEntryDelimiter);
      sb.Append(this.ShortUrlLength.ToString());
      sb.Append(Constants.IndexEntryDelimiter);
      sb.Append(this.UploadSiteUrl);
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
            this.SiteFeedDescription = indexEntries[3];
            this.SiteFeedUrl = indexEntries[4];
            this.TimeZone = indexEntries[5];
            this.ShortURL = indexEntries[6];
            try
            {
              this.ShortUrlLength = int.Parse(indexEntries[7]);
            }
            catch
            {
              this.ShortUrlLength = 3;
            }
            this.UploadSiteUrl = indexEntries[8];
            this.GoogleAnalyticsTrackingCode = indexEntries[9];
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
        this.SiteName = "Anetro";
        this.SiteUrl = "http://anetro.com";
        this.SiteCopyright = "Copyright &copy; 2011";
        this.SiteFeedDescription = "Website Description";
        this.SiteFeedUrl = "";
        this.TimeZone = "GMT";
        this.GoogleAnalyticsTrackingCode = "UA-3918071-1";
      }
    }

  }
}