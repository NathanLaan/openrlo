using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using OpenRLO.Web.Data;
using System.Web.Security;

namespace OpenRLO.Web.Admin
{
  public partial class Logout : System.Web.UI.Page
  {
    protected void Page_Load(object sender, EventArgs e)
    {
      FormsAuthentication.SignOut();
      FormsAuthentication.RedirectToLoginPage();
    }
  }
}