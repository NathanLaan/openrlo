using System;
using System.Collections.Generic;
using System.Web;
using System.Text;
using System.IO;

namespace OpenRLO.Data
{
  public class LearningObject : IndexItem, IComparable<LearningObject>
  {

    #region Equals
    public bool Equals(IndexItem item)
    {
      try
      {
        LearningObject obj = (LearningObject)item;
        return obj.Url == this.Url;
      }
      catch
      {
        return false;
      }
    }
    #endregion

    #region IComparable
    /*
     * Less than zero     This object is less than the other parameter.
     * Zero               This object is equal to other.
     * Greater than zero  This object is greater than other.
     * */
    public int CompareTo(LearningObject other)
    {
      return this.Url.CompareTo(other.Url);
    }
    #endregion

    public Index<Page> PageIndex { get; private set; }

    public string Title { get; set; }
    public string Url { get; set; }
    public DateTime ModifiedDateTime { get; set; }

    //
    // TODO: Metadata XML
    //
    public string MetadataFilename { get; set; }

    public int PageCount
    {
      get
      {
        try
        {
          return this.PageIndex.IndexList.Count;
        }
        catch
        {
          return 0;
        }
      }
    }


    //
    // TODO: Tags
    //
    //public List<string> TagList { get; private set; }

    private string FileName
    {
      get
      {
        return HttpContext.Current.Server.MapPath("/App_Data/_" + this.Url + ".txt");
      }
    }


    public LearningObject()
    {
      //this.TagList = new List<string>();
      this.PageIndex = new Index<Page>();
    }


    public void GenerateUrl()
    {
      this.Url = Title.Replace(" ", "").Replace("/", "").Replace("\\", "").Replace("'", "").Replace("\"", "");
    }



    public virtual string Save()
    {
      this.PageIndex.FileName = this.FileName;
      this.PageIndex.Save();

      StringBuilder stringBuilder = new StringBuilder();
      stringBuilder.Append(this.Title);
      stringBuilder.Append(Constants.IndexEntryDelimiter);
      stringBuilder.Append(this.Url);
      stringBuilder.Append(Constants.IndexEntryDelimiter);
      stringBuilder.Append(this.ModifiedDateTime.ToString());
      stringBuilder.Append(Constants.IndexEntryDelimiter);
      stringBuilder.Append(Environment.NewLine);
      return stringBuilder.ToString();
    }

    public virtual void Load(string line)
    {
      string[] indexEntries = line.Split(Constants.IndexEntryDelimiter);
      if (indexEntries.Length > 2)
      {
        this.Title = indexEntries[0];
        this.Url = indexEntries[1];
        this.ModifiedDateTime = DateTime.Parse(indexEntries[2]);
        this.LoadPages();
      }
    }

    private void LoadPages()
    {
      this.PageIndex = new Index<Page>(this.FileName);
      this.PageIndex.Load();
      this.PageIndex.IndexList.Sort();
    }

  }
}