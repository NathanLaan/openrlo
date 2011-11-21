using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OpenRLO.Web
{
  public partial class Learn : System.Web.UI.Page
  {
    protected void Page_Load(object sender, EventArgs e)
    {
      this.Title = Global.SiteSettings.CreatePageTitle("LEARN");

      string t = this.Request["t"];
      string p = this.Request["p"];
      Page.ClientScript.RegisterHiddenField("hiddenFieldT", t);
      Page.ClientScript.RegisterHiddenField("hiddenFieldP", p);
    }
  }
}