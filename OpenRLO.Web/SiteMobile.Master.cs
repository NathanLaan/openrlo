﻿using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Security.Principal;
using System.Text.RegularExpressions;

namespace OpenRLO.Web
{
  public partial class SiteMobile : System.Web.UI.MasterPage
  {
    protected void Page_Load(object sender, EventArgs e)
    {

      Response.Cache.SetExpires(DateTime.Now.AddMonths(1));
      Response.Cache.SetCacheability(HttpCacheability.ServerAndPrivate);
      Response.Cache.SetValidUntilExpires(true);
      // NOT WORKING!!!!!!!
      //this.lblGeneratedDateTime.Text = DateTime.Now.ToString("yyyyMMdd:HHmmss");
      //this.lblGeneratedDateTime.Text = DateTime.Now.ToString("yyyyMMdd");

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

      this.Page.Title = Global.SiteSettings.SiteName;
      this.lblSiteName.Text = Global.SiteSettings.SiteName;
      this.lblSiteVersion.Text = Global.SiteVersion;

      this.lnkHome.NavigateUrl = "/";
      this.lnkAbout.NavigateUrl = "/about";
      //this.lnkColophon.NavigateUrl = "/colophon";
      this.lnkFeed.NavigateUrl = Global.SiteSettings.SiteFeedUrl;
      this.lblCopyright.Text = Global.SiteSettings.SiteCopyright;

      //this.categoryRepeater.DataSource = Global.ArticleIndex.GetCategoryList();
      this.categoryRepeater.DataSource = Global.CategoryIndexNew.IndexList;
      this.categoryRepeater.DataBind();
      this.siteLinkRepeater.DataSource = Global.SiteLinkIndex.List;
      this.siteLinkRepeater.DataBind();

      string currentPage = Solution.Web.Library.HttpHandler.FlexHttpHandlerFactory.GetFlexPageName(Request.RawUrl);
      switch (currentPage)
      {
        case "home":
          this.lnkHome.CssClass = "currentLink";
          break;
        case "about":
          this.lnkAbout.CssClass = "currentLink";
          break;
        //case "colophon":
        //  this.lnkColophon.CssClass = "currentLink";
        //  break;
        case "admin":
          this.lnkAdmin.CssClass = "currentLink";
          break;
      }

      //
      // Authentication
      //
      if (Global.IsLoggedIn())
      {
        this.lnkAdmin.Visible = true;
        this.lnkAdmin.NavigateUrl = "/admin";
        this.lblUsername.Visible = true;
        // DisplayName should always be found because the user is logged in...
        this.lblUsername.Text = "USER: " + Global.SiteUserIndex.GetDisplayName(HttpContext.Current.User.Identity.Name);
        this.lnkLogout.Visible = true;
        this.lnkLogout.Text = "Logout";
        this.lnkLogout.NavigateUrl = "/admin/logout";
        //this.divFooterBar.Visible = true;
      }
      else
      {
        this.lnkAdmin.Visible = false;
        this.lblUsername.Visible = false;
        this.lnkLogout.Text = "Login";
        this.lnkLogout.NavigateUrl = "/admin/login";
        //this.divFooterBar.Visible = false;
      }

    }
  }
}