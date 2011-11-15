using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Security.Principal;
using System.Text.RegularExpressions;
using OpenRLO.Data;

namespace OpenRLO.Web
{
  public partial class SiteMobile : System.Web.UI.MasterPage
  {
    protected void Page_Load(object sender, EventArgs e)
    {

      Response.Cache.SetExpires(DateTime.Now.AddMonths(1));
      Response.Cache.SetCacheability(HttpCacheability.ServerAndPrivate);
      Response.Cache.SetValidUntilExpires(true);

      string mobile = Request.QueryString.Get("mobile");
      if (!string.IsNullOrEmpty(mobile))
      {
        //Response.Write("<b>mobile: " + mobile + "</b><br><br>");
        System.Web.UI.HtmlControls.HtmlLink link = new System.Web.UI.HtmlControls.HtmlLink();
        link.Href = "/css/360.css";
        link.Attributes.Add("rel", "stylesheet");
        link.Attributes.Add("type", "text/css");
        this.HeadElement.Controls.Add(link);
      }
      //else
      //{
      //  System.Web.UI.HtmlControls.HtmlLink link = new System.Web.UI.HtmlControls.HtmlLink();
      //  link.Href = "/css/960.css";
      //  link.Attributes.Add("rel", "stylesheet");
      //  link.Attributes.Add("type", "text/css");
      //  this.HeadElement.Controls.Add(link);
      //}

      this.lblSiteName.Text = Global.SiteSettings.SiteName;
      this.lblSiteVersion.Text = Global.SiteVersion;

      //this.lnkHome.NavigateUrl = "/";
      //this.lnkAbout.NavigateUrl = "/about";
      //this.lnkHelp.NavigateUrl = "/help";
      //this.lnkAdmin.NavigateUrl = "/admin";
      if (!string.IsNullOrEmpty(Global.SiteSettings.SiteCopyright))
      {
        this.lblCopyright.Text = Global.SiteSettings.SiteCopyright;
      }
      else
      {
        this.lblCopyright.Text = "Copyright &copy; " + DateTime.Now.Year + " " + Global.SiteSettings.SiteName;
      }

      //this.categoryRepeater.DataSource = Global.ArticleIndex.GetCategoryList();
      //this.categoryRepeater.DataSource = Global.CategoryIndexNew.IndexList;
      //this.categoryRepeater.DataBind();
      //this.siteLinkRepeater.DataSource = Global.SiteLinkIndex.List;
      //this.siteLinkRepeater.DataBind();

      //string currentPage = Solution.Web.Library.HttpHandler.FlexHttpHandlerFactory.GetFlexPageName(Request.RawUrl);
      string currentPage = Solution.Web.Library.HttpHandler.FlexHttpHandlerFactory.GetFlexPageName();
      //Response.Write("CurrentPage: " + currentPage);
      switch (currentPage)
      {
        case "home":
              this.liHome.Attributes["class"] = "active";
              break;
        case "view":
              this.liView.Attributes["class"] = "active";
              break;
        case "about":
              this.liAbout.Attributes["class"] = "active";
              break;
        case "manage":
              this.liManage.Attributes["class"] = "active";
              break;
      }


      //
      // Authentication
      //
      if (Global.IsLoggedIn())
      {
        this.liManage.Visible = true;
        //this.lnkAdmin.Visible = true;
        //this.lnkAdmin.NavigateUrl = "/admin";
        this.lblUsername.Visible = true;
        // DisplayName should always be found because the user is logged in...
        //this.lblUsername.Text = "USER: " + Global.SiteUserIndex.GetDisplayName(HttpContext.Current.User.Identity.Name);
        this.lnkLogout.Visible = true;
        this.lnkLogout.Text = "Logout";
        this.lnkLogout.NavigateUrl = "/logout";
        //this.divFooterBar.Visible = true;
      }
      else
      {
        this.liManage.Visible = false;
        //this.lnkAdmin.Visible = false;
        this.lblUsername.Visible = false;
        this.lnkLogout.Text = "Login";
        this.lnkLogout.NavigateUrl = "/login";
        //this.divFooterBar.Visible = false;
      }

    }
  }
}