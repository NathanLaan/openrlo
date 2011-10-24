using System;
using System.Web;

namespace OpenRLO.Web.Data
{
  public class IndexManager
  {

    public Index<Category> CategoryIndex { get; set; }


    public IndexManager()
    {
      this.CategoryIndex = new Index<Category>(HttpContext.Current.Server.MapPath("/App_Data/CategoryIndex.txt"));
    }

    public void Load()
    {
    }
  }
}