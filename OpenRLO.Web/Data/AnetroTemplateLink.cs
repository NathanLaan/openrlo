using System;
using System.Collections.Generic;
using System.Web;

namespace OpenRLO.Web.Data
{
  public class AnetroTemplateLink
  {

    public string Url { get; set; }
    public string Title { get; set; }
    public string LinkName { get; set; }

    //private string ReplaceList(Match match)
    //{
    //  string[] list = { "Test1", "Test2", "Test3" };
    //  StringBuilder sb = new StringBuilder();
    //  if (match.Groups.Count > 1)
    //  {
    //    Group listItemGroup = match.Groups[1];
    //    foreach (string link in list)
    //    {
    //      Regex url = this.ListItemUrlRegex("navigationList");
    //      string output = url.Replace(listItemGroup.Value, link);
    //      sb.Append(output);
    //    }
    //  }
    //  return sb.ToString();
    //}

  }
}