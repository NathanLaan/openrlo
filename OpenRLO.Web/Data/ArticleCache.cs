using System;
using System.Collections.Generic;
using System.Web;
using OpenRLO.Web.Data;

namespace OpenRLO.Web.Data
{

  /// <summary>
  /// Is a wraper class really needed???
  /// </summary>
  public sealed class ArticleCache
  {

    private Dictionary<string, string> articleCache = new Dictionary<string, string>();

    public void Add(string articleTitle, string articleContentsHtml)
    {
      this.articleCache.Add(articleTitle, articleContentsHtml);
    }

    public string Get(string articleTitle)
    {
      return this.articleCache[articleTitle];
    }

  }

}