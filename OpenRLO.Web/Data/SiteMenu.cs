using System;
using System.Collections.Generic;
using System.Text;
using System.IO;

namespace OpenRLO.Web.Data
{
  public class SiteMenu
  {

    private string filename;
    public string Filename
    {
      get { return filename; }
      set { filename = value; }
    }

    private List<SiteMenuItem> siteMenuItemList;
    public List<SiteMenuItem> SiteMenuItemList
    {
      get { return siteMenuItemList; }
    }

    public SiteMenu():this("")
    {
    }

    public SiteMenu(string filename)
    {
      this.siteMenuItemList = new List<SiteMenuItem>();
      this.filename = filename;
    }

    public void Load()
    {
    }

  }
}
