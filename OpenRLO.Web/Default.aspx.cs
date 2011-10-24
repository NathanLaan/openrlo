using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using OpenRLO.Web.Data;

namespace OpenRLO.Web
{
  public partial class Default : System.Web.UI.Page
  {

    protected void Page_Load(object sender, EventArgs e)
    {
      Response.Cache.SetExpires(DateTime.Now.AddMonths(1));
      Response.Cache.SetCacheability(HttpCacheability.ServerAndPrivate);
      Response.Cache.SetValidUntilExpires(true);

      string c = this.Request["c"];
      string p = this.Request["p"];
      //this.Title = string.Format("{0}: {1}", Global.SiteSettings.SiteName, c);
      //this.Title = string.Format("{0}: Page {1}", Global.SiteSettings.SiteName, p);
      //Page.ClientScript.RegisterHiddenField("hiddenFieldC", c);
      //Page.ClientScript.RegisterHiddenField("hiddenFieldP", p);

      int pageNumber = 1;
      if (p != null && p != string.Empty)
      {
        try
        {
          pageNumber = int.Parse(p);
        }
        catch
        {
          pageNumber = 1;
        }
      }
      else
      {
        pageNumber = 1;
      }


      List<Article> sourceList = null;

      if (!string.IsNullOrEmpty(c))
      {
        Category category = Global.CategoryIndexNew.Get(c);
        if (category != null)
        {
          lblCategoryName.Text = category.Title;
        }
        else
        {
          lblCategoryName.Text = c;
        }
        this.lblCategoryName.Visible = true;
        this.categoryHeader.Visible = true;
        lnkPrev.NavigateUrl = "/" + c + "/page/" + (pageNumber - 1);
        lnkNext.NavigateUrl = "/" + c + "/page/" + (pageNumber + 1);
        sourceList = Global.ArticleIndex.GetArticleList(c, pageNumber);
      }
      else
      {
        // BUGFIX: set c to NULL so that IsLastPage() works correctly.
        c = null;
        this.lblCategoryName.Visible = false;
        this.categoryHeader.Visible = false;
        lnkPrev.NavigateUrl = "/page/" + (pageNumber - 1);
        lnkNext.NavigateUrl = "/page/" + (pageNumber + 1);
        sourceList = Global.ArticleIndex.GetArticleList(pageNumber);
      }


      if (pageNumber == 1)
      {
        lnkPrev.Visible = false;
        lblPrev.Visible = true;
      }
      else
      {
        lblPrev.Visible = false;
      }

      if (Global.ArticleIndex.IsLastPage(c, pageNumber))
      {
        lnkNext.Visible = false;
        lblNext.Visible = true;
      }
      else
      {
        lnkNext.Visible = true;
        lblNext.Visible = false;
      }

      if (Global.IsLoggedIn())
      {
        this.articleListAdmin.DataSource = sourceList;
        this.articleListAdmin.DataBind();
        this.articleList.Visible = false;
        this.articleListAdmin.Visible = true;
      }
      else
      {
        this.articleList.DataSource = sourceList;
        this.articleList.DataBind();
        this.articleList.Visible = true;
        this.articleListAdmin.Visible = false;
      }

    }

  }
}