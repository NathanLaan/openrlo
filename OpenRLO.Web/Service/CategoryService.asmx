<%@ WebService Language="C#" Class="OpenRLO.Web.Service.CategoryService" %>

using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Services;
using System.Web.Script.Services;
using System.Web.Services.Protocols;
using OpenRLO.Web.Data;

namespace OpenRLO.Web.Service
{

  [System.Web.Script.Services.GenerateScriptType(typeof(OpenRLO.Web.Data.Category))]
  [WebService(Namespace = "http://anetro.com/Service/CategoryService")]
  [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
  [System.ComponentModel.ToolboxItem(false)]
  [System.Web.Script.Services.ScriptService]
  public class CategoryService : System.Web.Services.WebService
  {

    [WebMethod]
    [ScriptMethod]
    public string Add(Category category)
    {
      Global.CategoryIndexNew.Add(category);
      Global.CategoryIndexNew.Save();
      return "";
    }

    [WebMethod]
    [ScriptMethod]
    public bool Exists(string title)
    {
      if (Global.CategoryIndexNew.IndexList.Count > 0)
      {
        return Global.CategoryIndexNew.Exists(title);
      }
      else
      {
        return false;
      }
    }

    [WebMethod]
    [ScriptMethod]
    public List<Category> GetList()
    {
      return Global.CategoryIndexNew.IndexList;
    }

    [WebMethod]
    [ScriptMethod]
    public bool Delete(string title)
    {
      Global.CategoryIndexNew.Delete(title);
      Global.CategoryIndexNew.Save();
      return true;
    }

    [WebMethod]
    [ScriptMethod]
    public bool MoveUp(string title)
    {
      int x = Global.CategoryIndexNew.IndexList.Count;
      if (x > 1)
      {
        for (int i = 1; i < x; i++)
        {
          if (Global.CategoryIndexNew.IndexList[i].Title.Equals(title))
          {
            int o = Global.CategoryIndexNew.IndexList[i].Order;
            Global.CategoryIndexNew.IndexList[i].Order = Global.CategoryIndexNew.IndexList[i - 1].Order;
            Global.CategoryIndexNew.IndexList[i - 1].Order = o;
          }
        }
      }
      Global.CategoryIndexNew.IndexList.Sort();
      Global.CategoryIndexNew.Save();
      return true;
    }

    [WebMethod]
    [ScriptMethod]
    public bool MoveDown(string title)
    {
      int x = Global.CategoryIndexNew.IndexList.Count;
      if (x > 1)
      {
        for (int i = x - 1; i >= 0; i--)
        {
          if (Global.CategoryIndexNew.IndexList[i].Title.Equals(title))
          {
            int o = Global.CategoryIndexNew.IndexList[i].Order;
            Global.CategoryIndexNew.IndexList[i].Order = Global.CategoryIndexNew.IndexList[i + 1].Order;
            Global.CategoryIndexNew.IndexList[i + 1].Order = o;
          }
        }
      }
      Global.CategoryIndexNew.IndexList.Sort();
      Global.CategoryIndexNew.Save();
      return true;
    }

  }
}