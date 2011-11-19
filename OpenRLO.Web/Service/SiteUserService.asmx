<%@ WebService Language="C#" Class="OpenRLO.Web.Service.SiteUserService" %>

using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Services;
using System.Web.Script.Services;
using System.Web.Services.Protocols;
using OpenRLO.Data;

namespace OpenRLO.Web.Service
{

  [System.Web.Script.Services.GenerateScriptType(typeof(OpenRLO.Data.SiteUser))]
  [WebService(Namespace = "http://anetro.com/Service/SiteSettingsService")]
  [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
  [System.ComponentModel.ToolboxItem(false)]
  [System.Web.Script.Services.ScriptService]
  public class SiteUserService : System.Web.Services.WebService
  {

    [WebMethod]
    [ScriptMethod]
    public SiteUser Get(string username)
    {
      List<SiteUser> list = Global.SiteUserIndex.SiteUserList;
      foreach (SiteUser siteUser in list)
      {
        if (username.Equals(siteUser.Username))
        {
          return siteUser;
        }
      }
      return null;
    }

    [WebMethod]
    [ScriptMethod]
    public void Add(SiteUser siteUser)
    {
      Global.SiteUserIndex.SiteUserList.Add(siteUser);
      Global.SiteUserIndex.Save();
    }

    [WebMethod]
    [ScriptMethod]
    public string Delete(string username)
    {
      try
      {
        Global.SiteUserIndex.Delete(username);
        return "Deleted";
      }
      catch (Exception e)
      {
        return e.ToString();
      }
    }

    [WebMethod]
    [ScriptMethod]
    public void Edit(SiteUser oldSiteUser, SiteUser newSiteUser)
    {
      SiteUser old = this.Get(oldSiteUser.Username);
      if (old != null)
      {
        old.Username = newSiteUser.Username;
        old.Showname = newSiteUser.Showname;
        old.Timezone = newSiteUser.Timezone;
        old.Email = newSiteUser.Email;
        // The Passcode is set by the JavaScript on the Edit 
        // User Page, so we copy the Saltcode and Password.
        old.Saltcode = newSiteUser.Saltcode;
        old.Password = newSiteUser.Password;
        Global.SiteUserIndex.Save();
        try
        {

        }
        catch
        {
          // TODO: Logging?
        }
      }
      else
      {
        //
        //
        //
      }
    }

    [WebMethod]
    [ScriptMethod]
    public List<SiteUser> GetList()
    {
      return Global.SiteUserIndex.SiteUserList;
    }

    /// <summary>
    /// Returns true if EITHER username or showname exist.
    /// </summary>
    /// <param name="username"></param>
    /// <param name="showname"></param>
    /// <returns></returns>
    [WebMethod]
    [ScriptMethod]
    public bool Exists(string username, string showname)
    {
      List<SiteUser> list = Global.SiteUserIndex.SiteUserList;
      foreach (SiteUser siteUser in list)
      {
        if (username.Equals(siteUser.Username) || showname.Equals(siteUser.Showname))
        {
          return true;
        }
      }
      return false;
    }

  }
}