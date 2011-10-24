using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using OpenRLO.Web.Data;

namespace OpenRLO.Web.Admin
{
  public partial class AdminArticleEdit : System.Web.UI.Page
  {

    protected void Page_Load(object sender, EventArgs e)
    {
      string a = this.Request["a"];
      //this.Title = string.Format("{0}: {2}", Global.SiteSettings.SiteName, c, a);
      Page.ClientScript.RegisterHiddenField("hiddenFieldA", a);
    }

  }
}