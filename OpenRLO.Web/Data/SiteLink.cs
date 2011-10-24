using System;
using System.Collections.Generic;
using System.Text;

namespace OpenRLO.Web.Data
{
  public class SiteLink : IComparable<SiteLink>
  {

    /*
     * Less than zero     This object is less than the other parameter.
     * Zero               This object is equal to other.
     * Greater than zero  This object is greater than other.
     * */
    public int CompareTo(SiteLink other)
    {
      //return this.LatestArticleVersion.DateTime.CompareTo(other.LatestArticleVersion.DateTime);
      //return this.articleVersionList[0].DateTime.CompareTo(other.articleVersionList[0].DateTime);
      return this.order.CompareTo(other.order);
    }

    private int order;
    public int Order
    {
      get { return order; }
      set { order = value; }
    }

    private string title;
    public string Title
    {
      get { return title; }
      set { title = value; }
    }

    private string url;
    public string Url
    {
      get { return url; }
      set { url = value; }
    }

  }
}