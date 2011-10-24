using System;
using System.Collections.Generic;
using System.Text;

namespace OpenRLO.Web.Data
{
  public class Utility
  {
    /// <summary>
    /// Sanitize for display.
    /// </summary>
    /// <param name="val"></param>
    /// <returns></returns>
    public static string Sanitize(string val)
    {
      string v1 = val.Trim();
      string v2 = val.Replace(' ', '-');
      return v2;
    }

  }
}