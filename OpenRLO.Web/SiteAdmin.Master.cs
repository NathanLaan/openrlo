using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Security.Principal;

namespace OpenRLO.Web
{
  public partial class SiteAdmin : System.Web.UI.MasterPage
  {
    protected void Page_Load(object sender, EventArgs e)
    {
      this.Page.Title = Global.SiteSettings.SiteName;
      //this.lblSiteName.Text = Global.SiteSettings.SiteName;
      this.lblSiteVersion.Text = Global.SiteVersion;

      //this.lnkHome.NavigateUrl = "/";
      //this.lnkAbout.NavigateUrl = "/about";
      //this.lnkFeed.NavigateUrl = Global.SiteSettings.SiteFeedUrl;
      this.lblCopyright.Text = Global.SiteSettings.SiteCopyright;

      //this.categoryRepeater.DataSource = Global.ArticleIndex.GetCategoryList();
      //this.categoryRepeater.DataSource = Global.CategoryIndexNew.List;
      //this.categoryRepeater.DataBind();
      //this.siteLinkRepeater.DataSource = Global.SiteLinkIndex.List;
      //this.siteLinkRepeater.DataBind();

      string currentPage = Solution.Web.Library.HttpHandler.FlexHttpHandlerFactory.GetFlexPageName(Request.RawUrl);
      switch (currentPage)
      {
        case "admin":
          this.lnkArticleManage.CssClass = "currentLink";
          break;
        case "adminArticleManage":
          this.lnkArticleManage.CssClass = "currentLink";
          break;
        case "adminArticleNew":
          this.lnkArticleNew.CssClass = "currentLink";
          break;
        case "adminCategoryManage":
          this.lnkCategoryManage.CssClass = "currentLink";
          break;
        case "adminUserManage":
          this.lnkUserManage.CssClass = "currentLink";
          break;
        case "adminSiteSettings":
          this.lnkSiteSettings.CssClass = "currentLink";
          break;
        case "adminSiteLinks":
          this.lnkSiteLinks.CssClass = "currentLink";
          break;
        case "adminUpload":
          this.lnkUpload.CssClass = "currentLink";
          break;
        case "adminContent":
          this.lnkContent.CssClass = "currentLink";
          break;
      }

      //
      // Authentication
      //
      //if (Global.IsLoggedIn())
      //{
      //  //this.lnkAdmin.Visible = true;
      //  //this.lnkAdmin.NavigateUrl = "/admin";
      //  this.lblUsername.Visible = true;
      //  // DisplayName should always be found because the user is logged in...
      //  this.lblUsername.Text = "USER: " + Global.SiteUserIndex.GetDisplayName(HttpContext.Current.User.Identity.Name);
      //  this.lnkLogout.Visible = true;
      //  this.lnkLogout.Text = "Logout";
      //  this.lnkLogout.NavigateUrl = "/admin/logout";
      //}
      //else
      //{
      //  //this.lnkAdmin.Visible = false;
      //  this.lblUsername.Visible = false;
      //  this.lnkLogout.Text = "Login";
      //  this.lnkLogout.NavigateUrl = "/admin/login";
      //}

    }
  }
}