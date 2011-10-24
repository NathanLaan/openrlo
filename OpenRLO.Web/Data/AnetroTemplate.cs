using System;
using System.Text.RegularExpressions;

namespace OpenRLO.Web.Data
{
  public class AnetroTemplate
  {


    public string TemplateFilePath { get; set; }
    public string BaseOutputPath { get; set; }
    public string AlternativeOutputPath { get; set; }


    //
    //
    //

    public Regex ListRegex(string listName)
    {
      return new Regex(string.Format(@"{{{{{0}<}}}}([.\s\S]+?){{{{{0}>}}}}", listName));
    }

    public Regex ListItemUrlRegex(string listName)
    {
      return new Regex(string.Format(@"{{{{{0}\.Item\.Url}}}}", listName));
    }

    public Regex ItemRegex(string itemName, string parameterName)
    {
      return new Regex(string.Format(@"{{{{{0}\.Item\.{1}}}}}", itemName, parameterName));
    }

    public Regex ElementRegex(string elementName)
    {
      return new Regex(string.Format(@"{{{{{0}}}}}", elementName));
    }

    private static readonly string ELEMENT_REGEX = @"{{{{{0}}}}}";
    public string ElementRegexReplace(string elementName, string input, string replacement)
    {
      Regex regex = new Regex(string.Format(ELEMENT_REGEX, elementName));
      return regex.Replace(input, replacement);
    }

  }
}