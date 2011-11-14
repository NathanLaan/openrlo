using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace OpenRLO.Data
{
  public class Topic : LearningObjectItem, IComparable<Subject>
  {

    #region IComparable
    /*
     * Less than zero     This object is less than the other parameter.
     * Zero               This object is equal to other.
     * Greater than zero  This object is greater than other.
     * */
    public int CompareTo(Subject other)
    {
      return this.Key.CompareTo(other.Key);
    }
    #endregion

    //
    // TODO: Metadata XML
    //
    public string MetadataFilename { get; set; }

    public Subject Parent { get; set; }

  }
}