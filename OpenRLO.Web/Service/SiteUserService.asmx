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
      //
      // TODO: Check if current logged-in user is allowed to do this
      //
      
      Global.SiteUserIndex.SiteUserList.Add(siteUser);
      Global.SiteUserIndex.Save();
    }

    [WebMethod]
    [ScriptMethod]
    public string Delete(string username)
    {
      //
      // TODO: Check if current logged-in user is allowed to do this
      //
      
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
      //
      // TODO: Check if current logged-in user is allowed to do this
      //
      
      SiteUser old = this.Get(oldSiteUser.Username);
      if (old != null)
      {
        old.Username = newSiteUser.Username;
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
    /// Returns true if username exists.
    /// </summary>
    /// <param name="username"></param>
    /// <returns></returns>
    [WebMethod]
    [ScriptMethod]
    public bool UsernameExists(string username)
    {
      List<SiteUser> list = Global.SiteUserIndex.SiteUserList;
      foreach (SiteUser siteUser in list)
      {
        if (username.Equals(siteUser.Username))
        {
          return true;
        }
      }
      return false;
    }

    /// <summary>
    /// Returns true if username exists.
    /// </summary>
    /// <param name="username"></param>
    /// <returns></returns>
    [WebMethod]
    [ScriptMethod]
    public bool EmailExists(string email)
    {
      List<SiteUser> list = Global.SiteUserIndex.SiteUserList;
      foreach (SiteUser siteUser in list)
      {
        if (email.Equals(siteUser.Email))
        {
          return true;
        }
      }
      return false;
    }

  }
}