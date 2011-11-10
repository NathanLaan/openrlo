using System;

namespace OpenRLO.Data
{
  public class Subject : LearningObjectItem, IComparable<Subject>
  {

    #region IComparable
    /*
     * Less than zero     This object is less than the other parameter.
     * Zero               This object is equal to other.
     * Greater than zero  This object is greater than other.
     * */
    public int CompareTo(Subject other)
    {
      return other.Key.CompareTo(this.Key);
    }
    #endregion


  }
}