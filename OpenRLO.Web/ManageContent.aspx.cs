﻿using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OpenRLO.Web
{
  public partial class ManageContent : System.Web.UI.Page
  {
    protected void Page_Load(object sender, EventArgs e)
    {
      this.Title = Global.SiteSettings.CreatePageTitle("Manage Content");
    }
  }
}