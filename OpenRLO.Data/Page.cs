using System;
using System.Collections.Generic;
using System.Text;
using System.Web;
using System.IO;

namespace OpenRLO.Data
{
  /// <summary>
  /// A page is both a sub-class of a LearningObject, and a child object of a LearningObject.
  /// </summary>
  public class Page : LearningObject, IComparable<Page>
  {

    #region IComparable
    /*
     * Less than zero     This object is less than the other parameter.
     * Zero               This object is equal to other.
     * Greater than zero  This object is greater than other.
     * */
    public int CompareTo(Page other)
    {
      return this.Order.CompareTo(other.Order);
    }
    #endregion

    public string ParentLearningObjectUrl { get; set; }

    public int Order { get; set; }

    public string Contents { get; set; }

    public string HtmlContents
    {
      get
      {
        Markdown markdown = new Markdown();
        return markdown.Transform(this.Contents);
      }
    }

    public string FileName
    {
      get
      {
        return HttpContext.Current.Server.MapPath("/App_Data/_" + this.ParentLearningObjectUrl + "_" + this.Url + ".txt");
      }
    }

    #region Save

    public override string Save()
    {
      this.SavePageContents();

      StringBuilder stringBuilder = new StringBuilder();
      stringBuilder.Append(this.ParentLearningObjectUrl);
      stringBuilder.Append(Constants.IndexEntryDelimiter);
      stringBuilder.Append(this.Title);
      stringBuilder.Append(Constants.IndexEntryDelimiter);
      stringBuilder.Append(this.Url);
      stringBuilder.Append(Constants.IndexEntryDelimiter);
      stringBuilder.Append(this.ModifiedDateTime.ToString());
      stringBuilder.Append(Constants.IndexEntryDelimiter);
      stringBuilder.Append(this.Order.ToString());
      stringBuilder.Append(Constants.IndexEntryDelimiter);
      stringBuilder.Append(Environment.NewLine);
      return stringBuilder.ToString();
    }

    private void SavePageContents()
    {
      using (StreamWriter streamWriter = new StreamWriter(this.FileName))
      {
        streamWriter.Write(this.Contents);
      }
    }

    #endregion

    #region Load

    public override void Load(string line)
    {
      string[] indexEntries = line.Split(Constants.IndexEntryDelimiter);
      if (indexEntries.Length > 4)
      {
        this.ParentLearningObjectUrl = indexEntries[0];
        this.Title = indexEntries[1];
        this.Url = indexEntries[2];
        this.ModifiedDateTime = DateTime.Parse(indexEntries[3]);
        this.Order = int.Parse(indexEntries[4]);
        this.LoadPageContents();
      }
    }

    private void LoadPageContents()
    {
      string fileName = this.FileName;
      if (File.Exists(fileName))
      {
        using (StreamReader sr = new StreamReader(fileName))
        {
          this.Contents = sr.ReadToEnd();
        }
      }
      else
      {
        //TODO: nothing???
      }
    }

    #endregion

  }
}