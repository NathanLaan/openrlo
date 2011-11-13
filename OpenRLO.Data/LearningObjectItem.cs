using System;
using System.Text;

namespace OpenRLO.Data
{
  public class LearningObjectItem : IndexItem, IComparable<LearningObjectItem>
  {

    #region IComparable
    /*
     * Less than zero     This object is less than the other parameter.
     * Zero               This object is equal to other.
     * Greater than zero  This object is greater than other.
     * */
    public int CompareTo(LearningObjectItem other)
    {
      return this.Key.CompareTo(other.Key);
    }
    #endregion

    #region IndexItem

    public virtual string Key
    {
      get { return this.Title; }
    }

    public virtual string Val
    {
      get { return this.Url; }
    }

    public bool Equals(IndexItem item)
    {
      try
      {
        LearningObjectItem obj = (LearningObjectItem)item;
        return obj.Key == this.Key;
      }
      catch
      {
        return false;
      }
    }

    #endregion

    public string Title { get; set; }
    public string Url { get; set; }
    public DateTime ModifiedDateTime { get; set; }


    public void GenerateUrl()
    {
      this.Url = Title.Replace(" ", "").Replace("/", "").Replace("\\", "").Replace("'", "").Replace("\"", "");
    }




    public virtual string Save()
    {
      StringBuilder stringBuilder = new StringBuilder();
      stringBuilder.Append(this.Title);
      stringBuilder.Append(Constants.IndexEntryDelimiter);
      stringBuilder.Append(this.Url);
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
      }
    }

  }
}