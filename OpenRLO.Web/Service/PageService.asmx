﻿<%@ WebService Language="C#" Class="OpenRLO.Web.Service.PageService" %>

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
    public Page GetByUrl(string learningObjectUrl, string pageUrl)
    {
      LearningObject learningObject = Global.LearningObjectIndex.GetByUrl(learningObjectUrl);
      if (learningObject != null)
      {
        return learningObject.PageIndex.GetByUrl(pageUrl);
      }
      return null;
    }

    [WebMethod]
    [ScriptMethod]
    public Page GetByUrl(string learningObjectUrl, int pageNumber)
    {
      LearningObject learningObject = Global.LearningObjectIndex.GetByUrl(learningObjectUrl);
      if (learningObject != null)
      {
        foreach (Page page in learningObject.PageIndex.IndexList)
        {
          if (page.Order == pageNumber)
          {
            return page;
          }
        }
      }
      return null;
    }

    [WebMethod]
    [ScriptMethod]
    public string Add(string learningObjectUrl, string pageTitle, string pageContents)
    {
      if (string.IsNullOrEmpty(learningObjectUrl))
      {
        return "Invalid learning object";
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
      page.ParentLearningObjectUrl = learningObjectUrl;
      page.Title = pageTitle;
      page.Contents = pageContents;
      page.GenerateUrl();
      page.ModifiedDateTime = DateTime.Now;

      
      LearningObject learningObject = Global.LearningObjectIndex.GetByUrl(learningObjectUrl);

      if (learningObject == null)
      {
        return "Invalid Learning Object";
      }
      if (learningObject.PageIndex.Exists(page.Url))
      {
        return "Page already exists";
      }

      //
      // Page Number starts at ONE (1).
      //
      page.Order = learningObject.PageIndex.IndexList.Count + 1;

      learningObject.PageIndex.Add(page);
      Global.LearningObjectIndex.Save();

      
      //
      // Do we need to?
      //
      learningObject.PageIndex.Save();
      
      return "Page added";
    }

    [WebMethod]
    [ScriptMethod]
    public string DeleteByUrl(string learningObjectUrl, string pageUrl)
    {
      try
      {
        //Global.PageIndex.DeleteByUrl(url);
        //Global.PageIndex.Save();
        return "Page deleted";
      }
      catch (Exception e)
      {
        return e.ToString();
      }
    }

    [WebMethod]
    [ScriptMethod]
    public void Edit(string learningObjectUrl, Page oldPage, Page newPage)
    {
      Page old = this.GetByUrl(learningObjectUrl, oldPage.Url);
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
    public List<Page> GetList(string learningObjectUrl)
    {
      LearningObject learningObject = Global.LearningObjectIndex.GetByUrl(learningObjectUrl);
      if (learningObject != null)
      {
        return learningObject.PageIndex.IndexList;
      }
      return null;
    }

    
    [WebMethod]
    [ScriptMethod]
    public bool Exists(string learningObjectUrl, string pageUrl)
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