<%@ WebService Language="C#" Class="OpenRLO.Web.Service.SiteSettingsService" %>

using System;
using System.Web;
using System.Web.Services;
using System.Web.Script.Services;
using System.Web.Services.Protocols;
using OpenRLO.Data;

namespace OpenRLO.Web.Service
{
  
  [System.Web.Script.Services.GenerateScriptType(typeof(OpenRLO.Data.SiteSettings))]
  [WebService(Namespace = "http://anetro.com/Service/SiteSettingsService")]
  [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
  [System.ComponentModel.ToolboxItem(false)]
  [System.Web.Script.Services.ScriptService]
  public class SiteSettingsService : System.Web.Services.WebService
  {

    [WebMethod]
    [ScriptMethod]
    public SiteSettings Get()
    {
      return Global.SiteSettings;
    }

    [WebMethod]
    [ScriptMethod]
    public string Set(SiteSettings siteSettings)
    {
      Global.SiteSettings.Set(siteSettings);
      try
      {
        Global.SiteSettings.Save();
        return "Site Settings saved";
      }
      catch (Exception exception)
      {
        return exception.ToString();
      }
    }
    
  }

}