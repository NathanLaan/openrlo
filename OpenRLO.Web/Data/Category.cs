using System;
using System.Collections.Generic;
using System.Text;

namespace OpenRLO.Web.Data
{
  public class Category : IComparable<Category>, IndexItem
  {

    /*
     * Less than zero     This object is less than the other parameter.
     * Zero               This object is equal to other.
     * Greater than zero  This object is greater than other.
     * */
    public int CompareTo(Category other)
    {
      //return this.LatestArticleVersion.DateTime.CompareTo(other.LatestArticleVersion.DateTime);
      //return this.articleVersionList[0].DateTime.CompareTo(other.articleVersionList[0].DateTime);
      return this.Order.CompareTo(other.Order);
    }

    public int Order { get; set; }
    public string Url { get; set; }
    public string Title { get; set; }

    public string TitleUrl
    {
      get
      {
        return Title.Trim().Replace(" ", "-");
      }
    }


    //
    // IndexItem implementation
    //

    public string Key
    {
      get { return this.Url; }
    }

    public string Val
    {
      get { return this.Title; }
    }

    public string Save()
    {
      StringBuilder stringBuilder = new StringBuilder();
      stringBuilder.Append(this.Order);
      stringBuilder.Append(Constants.IndexEntryDelimiter);
      stringBuilder.Append(this.Url);
      stringBuilder.Append(Constants.IndexEntryDelimiter);
      stringBuilder.Append(this.Title);
      stringBuilder.Append(Environment.NewLine);
      return stringBuilder.ToString();
    }

    public void Load(string line)
    {
      string[] indexEntries = line.Split(Constants.IndexEntryDelimiter);
      if (indexEntries.Length > 2)
      {
        this.Order = int.Parse(indexEntries[0]);
        this.Url = indexEntries[1];
        this.Title = indexEntries[2];
      }
    }

    public bool Equals(IndexItem item)
    {
      try
      {
        Category obj = (Category)item;
        return obj.Title == this.Title;
      }
      catch
      {
        return false;
      }
    }
  }
}