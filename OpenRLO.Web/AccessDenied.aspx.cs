using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using OpenRLO.Data;
using System.Web.Security;

namespace OpenRLO.Web
{
  public partial class AccessDenied : System.Web.UI.Page
  {
    protected void Page_Load(object sender, EventArgs e)
    {
      this.Title = Global.SiteSettings.CreatePageTitle("Access Denied");
      //string page = this.Request["p"];
      //this.lblPage.Text = page;
    }
  }
}