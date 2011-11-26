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
    public string CreateAccount(string username, string password, string email)
    {
      try
      {
        //
        // TODO: Data input validation
        //
        if (string.IsNullOrEmpty(password))
        {
          return "Invalid password";
        }
        if (string.IsNullOrEmpty(username))
        {
          return "Invalid username";
        }
        if (string.IsNullOrEmpty(email))
        {
          return "Invalid email";
        }
        if (this.UsernameExists(username))
        {
          return "Username already exists";
        }
        if (this.EmailExists(email))
        {
          return "Email already exists";
        }
        SiteUser siteUser = new SiteUser();
        siteUser.Username = username;
        siteUser.Passcode = password;
        siteUser.Email = email;
        siteUser.UserID = Guid.NewGuid();
        Global.SiteUserIndex.SiteUserList.Add(siteUser);
        Global.SiteUserIndex.Save();
        return "User account created";
      }
      catch
      {
      }
      return "Unable to create user account";
    }
    

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
    public SiteUser GetByID(string userID)
    {
      List<SiteUser> list = Global.SiteUserIndex.SiteUserList;
      foreach (SiteUser siteUser in list)
      {
        if (userID.Equals(siteUser.UserID.ToString()))
        {
          return siteUser;
        }
      }
      return null;
    }

    [WebMethod]
    [ScriptMethod]
    public string Add(SiteUser siteUser)
    {
      if (Global.IsAdministrator)
      {
        Global.SiteUserIndex.SiteUserList.Add(siteUser);
        Global.SiteUserIndex.Save();
        return "User added";
      }
      else
      {
        return Global.ACCESS_DENIED;
      }
    }

    [WebMethod]
    [ScriptMethod]
    public string Delete(string userID)
    {
      if (Global.IsAdministrator)
      {
        try
        {
          if (Global.SiteUserIndex.Delete(userID))
          {
            return "Deleted";
          }
          else
          {
            return "Unable to delete";
          }
        }
        catch (Exception e)
        {
          return e.ToString();
        }
      }
      else
      {
        return Global.ACCESS_DENIED;
      }
    }

    [WebMethod]
    [ScriptMethod]
    public string Edit(string userID, SiteUser newSiteUser)
    {
      if (Global.IsAdministrator)
      {
        SiteUser old = this.GetByID(userID);
        if (old != null)
        {
          old.Username = newSiteUser.Username;
          old.Timezone = newSiteUser.Timezone;
          old.Email = newSiteUser.Email;
          // The Passcode is set by the JavaScript on the Edit 
          // User Page, so we copy the Saltcode and Password.
          old.Saltcode = newSiteUser.Saltcode;
          old.Password = newSiteUser.Password;
          old.IsAdministrator = newSiteUser.IsAdministrator;
          old.IsContentEditor = newSiteUser.IsContentEditor;
          Global.SiteUserIndex.Save();
          return "User updated";
        }
        return "Error updating user";
      }
      else
      {
        return Global.ACCESS_DENIED;
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