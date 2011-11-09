using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using OpenRLO.Web.Data;
using System.Web.Security;

namespace OpenRLO.Web
{
  public partial class Login : System.Web.UI.Page
  {
    protected void Page_Load(object sender, EventArgs e)
    {
      this.Title = Global.SiteSettings.CreatePageTitle("LOGIN");
    }

    protected void btnLogin_Click(object sender, EventArgs e)
    {

      //
      // http://msdn.microsoft.com/en-us/library/ff647070.aspx
      //

      if (Global.SiteUserIndex.ValidateUser(txtUsername.Text, txtPassword.Text))
      {
        FormsAuthentication.RedirectFromLoginPage(txtUsername.Text, true);
      }
      else
      {
        lblOutput.Text = "Login failed. Please try again";
      }

      //if (Membership.ValidateUser(userName.Text, password.Text))
      //{
      //  if (Request.QueryString["ReturnUrl"] != null)
      //  {
      //    FormsAuthentication.RedirectFromLoginPage(txtUsername.Text, false);
      //  }
      //  else
      //  {
      //    FormsAuthentication.SetAuthCookie(txtUsername.Text, false);
      //  }
      //}
      //else
      //{
      //  Response.Write("Invalid UserID and Password");
      //}
    }
  }
}