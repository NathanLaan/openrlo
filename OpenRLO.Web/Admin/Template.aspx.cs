using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using OpenRLO.Web.Data;

namespace OpenRLO.Web.Admin
{
  public partial class Template : System.Web.UI.Page
  {
    protected void Page_Load(object sender, EventArgs e)
    {
      //string indexTemplatePath = HttpContext.Current.Server.MapPath("/App_Data/_AnetroTemplateIndex.html");
      //string categoryTemplatePath = HttpContext.Current.Server.MapPath("/App_Data/_AnetroTemplateCategory.html");
      //string articleTemplatePath = HttpContext.Current.Server.MapPath("/App_Data/_AnetroTemplateArticle.html");
      //string baseFilePath = HttpContext.Current.Server.MapPath("/");
      //AnetroTemplateEngine anetroTemplateEngine = new AnetroTemplateEngine(indexTemplatePath, categoryTemplatePath, articleTemplatePath, baseFilePath);
      //anetroTemplateEngine.GenerateAll();

      //AnetroTemplateArticle anetroTemplateArticle = new AnetroTemplateArticle(HttpContext.Current.Server.MapPath("/App_Data/_AnetroTemplateArticle.html"), HttpContext.Current.Server.MapPath("/"));
      //anetroTemplateArticle.CategoryList = Global.CategoryIndexNew.List;
      //anetroTemplateArticle.SiteLinkList = Global.SiteLinkIndex.List;
      //anetroTemplateArticle.Settings = Global.SiteSettings;
      //anetroTemplateArticle.Article = Global.ArticleIndex.List[0];

      //this.lnk.NavigateUrl = "/" + anetroTemplateArticle.Generate();
      //this.lnk.Text = "/" + anetroTemplateArticle.Generate();

    }
  }
}