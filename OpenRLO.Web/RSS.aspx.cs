using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OpenRLO.Web
{
  public partial class RSS : System.Web.UI.Page
  {
    protected void Page_Load(object sender, EventArgs e)
    {
      rptRSS.DataSource = Global.ArticleIndex.GetArticleListPublishedWithCategory();
      rptRSS.DataBind();
    }

    protected string FormatForXML(object input)
    {
      string data = input.ToString();
      data = data.Replace("&", "&amp;");
      data = data.Replace("\"", "&quot;");
      data = data.Replace("'", "&apos;");
      data = data.Replace("<", "&lt;");
      data = data.Replace(">", "&gt;"); 
      return data;
    }

  }
}