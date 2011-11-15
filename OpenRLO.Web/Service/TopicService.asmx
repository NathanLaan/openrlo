<%@ WebService Language="C#" Class="OpenRLO.Web.Service.TopicService" %>

using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Services;
using System.Web.Script.Services;
using System.Web.Services.Protocols;
using OpenRLO.Data;
using OpenRLO.Web.Data;

namespace OpenRLO.Web.Service
{

  [System.Web.Script.Services.GenerateScriptType(typeof(OpenRLO.Data.Subject))]
  [System.Web.Script.Services.GenerateScriptType(typeof(OpenRLO.Data.Topic))]
  [WebService(Namespace = "http://anetro.com/Service/SiteSettingsService")]
  [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
  [System.ComponentModel.ToolboxItem(false)]
  [System.Web.Script.Services.ScriptService]
  public class TopicService : System.Web.Services.WebService
  {

    [WebMethod]
    [ScriptMethod]
    public Topic Get(string key)
    {
      List<Topic> list = Global.SubjectIndex.IndexList;
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
    public string Add(string title)
    {
      if (string.IsNullOrEmpty(title))
      {
        return "Invalid subject title";
      }
      Subject subject = new Subject();
      subject.Title = title;
      subject.GenerateUrl();
      if (Global.SubjectIndex.ExistsKey(title))
      {
        return "Subject already exists";
      }
      Global.SubjectIndex.IndexList.Add(subject);
      Global.SubjectIndex.IndexList.Sort();
      Global.SubjectIndex.Save();
      return "Subject added";
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