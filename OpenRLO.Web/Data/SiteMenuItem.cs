using System;
using System.Collections.Generic;
using System.Text;

namespace OpenRLO.Web.Data
{
  public class SiteMenuItem
  {

    private string categoryName;
    public string CategoryName
    {
      get { return categoryName; }
      set { categoryName = value; }
    }

    private string articleTitle;
    public string ArticleTitle
    {
      get { return articleTitle; }
      set { articleTitle = value; }
    }

  }
}
