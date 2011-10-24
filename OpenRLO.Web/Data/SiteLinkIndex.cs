using System;
using System.Collections.Generic;
using System.Text;
using System.IO;

namespace OpenRLO.Web.Data
{
  public class SiteLinkIndex
  {

    private string filename = "/App_Data/SiteLinkIndex.txt";
    public string Filename
    {
      get { return filename; }
      set { filename = value; }
    }

    private List<SiteLink> siteLinkList;
    public List<SiteLink> List
    {
      get { return siteLinkList; }
      set { siteLinkList = value; }
    }

    public SiteLinkIndex()
    {
      this.siteLinkList = new List<SiteLink>();
    }

    public int Add(SiteLink siteLink)
    {
      int order = 0;
      foreach (SiteLink sl in this.siteLinkList)
      {
        order = Math.Max(order, sl.Order+1);
      }
      siteLink.Order = order;
      this.siteLinkList.Add(siteLink);
      this.Save();
      return order;
    }

    public bool Delete(string title)
    {
      foreach (SiteLink sl in this.siteLinkList)
      {
        if (title.Equals(sl.Title))
        {
          this.siteLinkList.Remove(sl);
          this.ReOrder();
          this.Save();
          return true;
        }
      }
      return false;
    }

    private void ReOrder()
    {
      // insertion sort
      int i;
      int x = this.siteLinkList.Count;
      this.siteLinkList.Sort();

      // re-ordering
      if (this.siteLinkList.Count > 0)
      {
        this.siteLinkList[0].Order = 0;
        for (i = 1; i < x; i++)
        {
          int diff = this.siteLinkList[i].Order - this.siteLinkList[i - 1].Order;
          if (diff > 1)
          {
            this.siteLinkList[i].Order = this.siteLinkList[i - 1].Order + 1;
          }
        }
      }
    }

    public bool MoveUp(string title)
    {
      int x = this.siteLinkList.Count;
      if (x > 1)
      {
        for (int i = 1; i < x; i++)
        {
          if (this.siteLinkList[i].Title.Equals(title))
          {
            int o = this.siteLinkList[i].Order;
            this.siteLinkList[i].Order = this.siteLinkList[i - 1].Order;
            this.siteLinkList[i - 1].Order = o;
          }
        }
      }
      this.siteLinkList.Sort();
      this.Save();
      return true;
    }

    public bool MoveDown(string title)
    {
      int x = this.siteLinkList.Count;
      if (x > 1)
      {
        for (int i = x-1; i >= 0; i--)
        {
          if (this.siteLinkList[i].Title.Equals(title))
          {
            int o = this.siteLinkList[i].Order;
            this.siteLinkList[i].Order = this.siteLinkList[i + 1].Order;
            this.siteLinkList[i + 1].Order = o;
          }
        }
      }
      this.siteLinkList.Sort();
      this.Save();
      return true;
    }

    public bool Exists(string title)
    {
      foreach (SiteLink sl in this.siteLinkList)
      {
        if (title.Equals(sl.Title))
        {
          return true;
        }
      }
      return false;
    }

    public void Load()
    {
      this.siteLinkList.Clear();
      //TODO: more error handling
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
                  SiteLink siteLink = new SiteLink();
                  siteLink.Order = int.Parse(indexEntries[0]);
                  siteLink.Title = indexEntries[1];
                  siteLink.Url = indexEntries[2];
                  this.siteLinkList.Add(siteLink);
                }
              }
            }
            this.siteLinkList.Sort();
          }
        }
      }
      else
      {
        //TODO: nothing???
      }
    }

    public void Save()
    {
      StringBuilder sb = new StringBuilder();
      foreach (SiteLink siteLink in this.siteLinkList)
      {
        sb.Append(siteLink.Order);
        sb.Append(Constants.IndexEntryDelimiter);
        sb.Append(siteLink.Title);
        sb.Append(Constants.IndexEntryDelimiter);
        sb.Append(siteLink.Url);
        sb.Append(Environment.NewLine);
      }
      using (StreamWriter streamWriter = new StreamWriter(this.Filename))
      {
        streamWriter.Write(sb.ToString());
      }
    }

  }
}