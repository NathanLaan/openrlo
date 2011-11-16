using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

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
      return this.Url.CompareTo(other.Url);
    }
    #endregion

    public string ParentLearningObjectUrl { get; set; }

  }
}