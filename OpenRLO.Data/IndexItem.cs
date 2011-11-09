using System;

namespace OpenRLO.Data
{
  public interface IndexItem
  {

    //
    // Index classes can use a "dirty" flag to determine whether or not to save their own sub-indexes.
    //

    /// <summary>
    /// Implemented as a property so it is accessible via JavaScript.
    /// </summary>
    string Key { get; }
    string Val { get; }
    //string Filename { set; get; }

    //
    // Saving and loading is basically a custom serialization mechanism.
    //

    string Save();
    void Load(string line);

    bool Equals(IndexItem item);

  }
}