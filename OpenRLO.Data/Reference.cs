using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace OpenRLO.Data
{
  public class Reference : IndexItem, IComparable<Reference>
  {

    #region IComparable
    /*
     * Less than zero     This object is less than the other parameter.
     * Zero               This object is equal to other.
     * Greater than zero  This object is greater than other.
     * */
    public int CompareTo(Reference other)
    {
      return other.Value.CompareTo(this.Value);
    }
    #endregion

    #region IndexItem

    public string Key
    {
      get { return this.ID.ToString(); }
    }

    public string Val
    {
      get { return this.Value; }
    }

    public bool Equals(IndexItem item)
    {
      try
      {
        Reference obj = (Reference)item;
        return obj.ID == this.ID;
      }
      catch
      {
        return false;
      }
    }

    #endregion

    public Guid ID { get; set; }
    public string Value { get; set; }

    public string Save()
    {
      StringBuilder stringBuilder = new StringBuilder();
      stringBuilder.Append(this.ID);
      stringBuilder.Append(Constants.IndexEntryDelimiter);
      stringBuilder.Append(this.Value);
      stringBuilder.Append(Constants.IndexEntryDelimiter);
      stringBuilder.Append(Environment.NewLine);
      return stringBuilder.ToString();
    }

    public void Load(string line)
    {
      string[] indexEntries = line.Split(Constants.IndexEntryDelimiter);
      if (indexEntries.Length > 2)
      {
        this.ID = new Guid(indexEntries[0]);
        this.Value = indexEntries[1];
      }
    }

  }
}
