using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Security.Principal;
using OpenRLO.Data;

namespace OpenRLO.Web
{
  public partial class ManageSite : System.Web.UI.Page
  {
    protected void Page_Load(object sender, EventArgs e)
    {

      try
      {
        this.Title = Global.SiteSettings.CreatePageTitle("Manage Content");

        //
        // The user should not be able to navigate to this page without being logged in.
        //
        // However, we also need to check that the user is authorized.
        //
        // If the user is not authorized, we need to redirect them to a "Not Authorized" page.
        //
        if (Global.IsLoggedIn)
        {
          //
          // if the user has access to either admin or content 
          // management permissions, then they are NOT denied.
          //
          bool denied = true;

          if (Global.IsAdministrator)
          {
            // add field to allow appropriate javascript to be disabled
            Page.ClientScript.RegisterHiddenField("isAdministrator", "true");
            this.liUsers.Visible = true;
            this.liSettings.Visible = true;
            denied = false;
          }
          else
          {
            Page.ClientScript.RegisterHiddenField("isAdministrator", "false");
            this.liUsers.Visible = false;
            this.liSettings.Visible = false;
          }

          if (Global.IsContentEditor)
          {
            // add field to allow appropriate javascript to be disabled
            Page.ClientScript.RegisterHiddenField("isContentEditor", "true");
            this.liRLO.Visible = true;
            this.liPages.Visible = true;
            denied = false;
          }
          else
          {
            Page.ClientScript.RegisterHiddenField("isContentEditor", "false");
            this.liRLO.Visible = false;
            this.liPages.Visible = false;
          }


          if (denied)
          {
            this.Redirect();
          }

        }
        else
        {
          this.Redirect();
        }

      }
      catch
      {
        // redirect if any errors occur
        this.Redirect();
      }


    }

    private void Redirect()
    {
      //
      // TODO: Send user to "Access Denied" page...
      //
    }

  }
}