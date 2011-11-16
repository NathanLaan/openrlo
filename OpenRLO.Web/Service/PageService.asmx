<%@ WebService Language="C#" Class="OpenRLO.Web.Service.PageService" %>

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

  [System.Web.Script.Services.GenerateScriptType(typeof(OpenRLO.Data.Page))]
  [WebService(Namespace = "http://openrlo.com/Service/PageService")]
  [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
  [System.ComponentModel.ToolboxItem(false)]
  [System.Web.Script.Services.ScriptService]
  public class PageService : System.Web.Services.WebService
  {

    [WebMethod]
    [ScriptMethod]
    public Page GetByUrl(string topicUrl, string pageUrl)
    {
      //List<Page> list = Global.PageIndex.IndexList;
      //foreach (Page lo in list)
      //{
      //  if (lo.Url.Equals(url))
      //  {
      //    return lo;
      //  }
      //}
      return null;
    }

    [WebMethod]
    [ScriptMethod]
    public string Add(string topicUrl, string pageTitle, string pageContents)
    {
      if (string.IsNullOrEmpty(topicUrl))
      {
        return "Invalid topic";
      }
      if (string.IsNullOrEmpty(pageTitle))
      {
        return "Invalid page title";
      }
      if (string.IsNullOrEmpty(pageContents))
      {
        return "Invalid page contents";
      }
      Page page = new Page();
      page.Title = pageTitle;
      page.Contents = pageContents;
      page.GenerateUrl();
      page.ModifiedDateTime = DateTime.Now;

      
      LearningObject learningObject = Global.LearningObjectIndex.GetByUrl(topicUrl);

      if (learningObject == null)
      {
        return "Invalid Learning Object";
      }
      if (learningObject.PageIndex.Exists(page.Url))
      {
        return "Page already exists";
      }

      page.Order = learningObject.PageIndex.IndexList.Count;

      learningObject.PageIndex.Add(page);
      Global.LearningObjectIndex.Save();

      
      //
      // Do we need to?
      //
      learningObject.PageIndex.Save();
      
      return "Learning Object added";
    }

    [WebMethod]
    [ScriptMethod]
    public string DeleteByUrl(string topicUrl, string pageUrl)
    {
      try
      {
        //Global.PageIndex.DeleteByUrl(url);
        //Global.PageIndex.Save();
        return "Learning Object deleted";
      }
      catch (Exception e)
      {
        return e.ToString();
      }
    }

    [WebMethod]
    [ScriptMethod]
    public void Edit(string topicUrl, Page oldPage, Page newPage)
    {
      Page old = this.GetByUrl(topicUrl, oldPage.Url);
      if (old != null)
      {
        //old.Title = newPage.Title;
        //old.Url = newPage.Url;
        //old.ModifiedDateTime = newPage.ModifiedDateTime;
        //Global.PageIndex.Save();
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
    public List<Page> GetList(string topicUrl)
    {
      LearningObject learningObject = Global.LearningObjectIndex.GetByUrl(topicUrl);
      if (learningObject != null)
      {
        return learningObject.PageIndex.IndexList;
      }
      return null;
    }

    
    [WebMethod]
    [ScriptMethod]
    public bool Exists(string topicUrl, string pageUrl)
    {
      //List<Page> list = Global.PageIndex.IndexList;
      //foreach (Page lo in list)
      //{
      //  if (lo.Url.Equals(url))
      //  {
      //    return true;
      //  }
      //}
      return false;
    }

  }
}