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

      this.Title = Global.SiteSettings.CreatePageTitle("HOME");
      //string c = this.Request["c"];
      //string p = this.Request["p"];
      //this.Title = string.Format("{0}: {1}", Global.SiteSettings.SiteName, c);
      //this.Title = string.Format("{0}: Page {1}", Global.SiteSettings.SiteName, p);
      //Page.ClientScript.RegisterHiddenField("hiddenFieldC", c);
      //Page.ClientScript.RegisterHiddenField("hiddenFieldP", p);

      //int pageNumber = 1;
      //if (p != null && p != string.Empty)
      //{
      //  try
      //  {
      //    pageNumber = int.Parse(p);
      //  }
      //  catch
      //  {
      //    pageNumber = 1;
      //  }
      //}
      //else
      //{
      //  pageNumber = 1;
      //}

    }

  }
}