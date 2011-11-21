<%@ WebService Language="C#" Class="OpenRLO.Web.Service.LearningObjectService" %>

using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Services;
using System.Web.Script.Services;
using System.Web.Services.Protocols;
using OpenRLO.Data;

namespace OpenRLO.Web.Service
{

  [System.Web.Script.Services.GenerateScriptType(typeof(OpenRLO.Data.LearningObject))]
  [WebService(Namespace = "http://openrlo.com/Service/LearningObjectService")]
  [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
  [System.ComponentModel.ToolboxItem(false)]
  [System.Web.Script.Services.ScriptService]
  public class LearningObjectService : System.Web.Services.WebService
  {
    

    [WebMethod]
    [ScriptMethod]
    public LearningObject GetByUrl(string url)
    {
      List<LearningObject> list = Global.LearningObjectIndex.IndexList;
      foreach (LearningObject lo in list)
      {
        if (lo.Url.Equals(url))
        {
          return lo;
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
        return "Invalid Learning Object title";
      }
      LearningObject learningObject = new LearningObject();
      learningObject.Title = title;
      learningObject.GenerateUrl();
      learningObject.ModifiedDateTime = DateTime.Now;
      if (Global.LearningObjectIndex.Exists(learningObject.Url))
      {
        return "Learning Object already exists";
      }
      Global.LearningObjectIndex.IndexList.Add(learningObject);
      Global.LearningObjectIndex.IndexList.Sort();
      Global.LearningObjectIndex.Save();
      return "Learning Object added";
    }
    

    [WebMethod]
    [ScriptMethod]
    public string DeleteByUrl(string url)
    {
      try
      {
        Global.LearningObjectIndex.DeleteByUrl(url);
        Global.LearningObjectIndex.Save();
        return "Learning Object deleted";
      }
      catch (Exception e)
      {
        return e.ToString();
      }
    }

    
    [WebMethod]
    [ScriptMethod]
    public string Edit(string learningObjectUrl, string newLearningObjectTitle)
    {
      LearningObject learningObject = this.GetByUrl(learningObjectUrl);
      if (learningObject != null)
      {
        learningObject.Title = newLearningObjectTitle;
        learningObject.GenerateUrl();
        learningObject.ModifiedDateTime = DateTime.Now;
        Global.LearningObjectIndex.Save();
        return "Learning Object updated";
      }
      return "Error updating Learning Object";
    }

    
    [WebMethod]
    [ScriptMethod]
    public List<LearningObject> GetList()
    {
      return Global.LearningObjectIndex.IndexList;
    }
    

    /// <summary>
    /// Returns true if EITHER username or showname exist.
    /// </summary>
    /// <param name="username"></param>
    /// <param name="showname"></param>
    /// <returns></returns>
    [WebMethod]
    [ScriptMethod]
    public bool Exists(string url)
    {
      List<LearningObject> list = Global.LearningObjectIndex.IndexList;
      foreach (LearningObject lo in list)
      {
        if (lo.Url.Equals(url))
        {
          return true;
        }
      }
      return false;
    }
    

  }
}