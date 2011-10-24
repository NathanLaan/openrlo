<%@ WebService Language="C#" Class="OpenRLO.Web.Service.SiteLinkService" %>

using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Services;
using System.Web.Script.Services;
using System.Web.Services.Protocols;
using OpenRLO.Web.Data;

namespace OpenRLO.Web.Service
{

  [System.Web.Script.Services.GenerateScriptType(typeof(OpenRLO.Web.Data.SiteLink))]
  [WebService(Namespace = "http://anetro.com/Service/SiteLinkService")]
  [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
  [System.ComponentModel.ToolboxItem(false)]
  [System.Web.Script.Services.ScriptService]
  public class SiteLinkService : System.Web.Services.WebService
  {

    [WebMethod]
    [ScriptMethod]
    public string Add(SiteLink siteLink)
    {
      Global.SiteLinkIndex.Add(siteLink);
      return "";
    }

    [WebMethod]
    [ScriptMethod]
    public bool Exists(string title)
    {
      return Global.SiteLinkIndex.Exists(title);
    }

    [WebMethod]
    [ScriptMethod]
    public List<SiteLink> GetList()
    {
      return Global.SiteLinkIndex.List;
    }

    [WebMethod]
    [ScriptMethod]
    public bool Delete(string title)
    {
      return Global.SiteLinkIndex.Delete(title);
    }

    [WebMethod]
    [ScriptMethod]
    public bool MoveUp(string title)
    {
      return Global.SiteLinkIndex.MoveUp(title);
    }

    [WebMethod]
    [ScriptMethod]
    public bool MoveDown(string title)
    {
      return Global.SiteLinkIndex.MoveDown(title);
    }

  }
}