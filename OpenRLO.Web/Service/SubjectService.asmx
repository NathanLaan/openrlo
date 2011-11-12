<%@ WebService Language="C#" Class="OpenRLO.Web.Service.SubjectService" %>

using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Services;
using System.Web.Script.Services;
using System.Web.Services.Protocols;
using OpenRLO.Data;
using Solution.Web.Anetro.Library.Utility;

namespace OpenRLO.Web.Service
{

  [System.Web.Script.Services.GenerateScriptType(typeof(OpenRLO.Data.Subject))]
  [WebService(Namespace = "http://anetro.com/Service/SiteSettingsService")]
  [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
  [System.ComponentModel.ToolboxItem(false)]
  [System.Web.Script.Services.ScriptService]
  public class SubjectService : System.Web.Services.WebService
  {

    [WebMethod]
    [ScriptMethod]
    public Subject Get(string key)
    {
      List<Subject> list = Global.SubjectIndex.IndexList;
      foreach (Subject subject in list)
      {
        if (subject.Key.Equals(key))
        {
          return subject;
        }
      }
      return null;
    }

    [WebMethod]
    [ScriptMethod]
    public void Add(Subject subject)
    {
      Global.SubjectIndex.IndexList.Add(subject);
      Global.SubjectIndex.Save();
    }

    [WebMethod]
    [ScriptMethod]
    public string Delete(string key)
    {
      try
      {
        Global.SubjectIndex.Delete(key);
        return "Deleted";
      }
      catch (Exception e)
      {
        return e.ToString();
      }
    }

    [WebMethod]
    [ScriptMethod]
    public void Edit(Subject oldSubject, Subject newSubject)
    {
      Subject old = this.Get(oldSubject.Key);
      if (old != null)
      {
        old.Title = newSubject.Title;
        old.Url = newSubject.Url;
        old.ModifiedDateTime = newSubject.ModifiedDateTime;
        Global.SubjectIndex.Save();
      }
      else
      {
        //
        // TODO: ?
        //
      }
    }

    [WebMethod]
    [ScriptMethod]
    public List<Subject> GetList()
    {
      return Global.SubjectIndex.IndexList;
    }

    /// <summary>
    /// Returns true if EITHER username or showname exist.
    /// </summary>
    /// <param name="username"></param>
    /// <param name="showname"></param>
    /// <returns></returns>
    [WebMethod]
    [ScriptMethod]
    public bool Exists(string key)
    {
      List<Subject> list = Global.SubjectIndex.IndexList;
      foreach (Subject subject in list)
      {
        if (subject.Equals(key))
        {
          return true;
        }
      }
      return false;
    }

  }
}