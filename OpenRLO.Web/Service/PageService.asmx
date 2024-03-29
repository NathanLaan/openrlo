﻿<%@ WebService Language="C#" Class="OpenRLO.Web.Service.PageService" %>

using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Services;
using System.Web.Script.Services;
using System.Web.Services.Protocols;
using OpenRLO.Data;

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
    public Page GetByUrl2(string learningObjectUrl, int pageNumber)
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
      if (Global.IsContentEditor)
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
      else
      {
        return Global.ACCESS_DENIED;
      }
    }

    [WebMethod]
    [ScriptMethod]
    public string DeleteByUrl(string learningObjectUrl, string pageUrl)
    {
      if (Global.IsContentEditor)
      {
        try
        {
          LearningObject learningObject = Global.LearningObjectIndex.GetByUrl(learningObjectUrl);
          if (learningObject != null)
          {
            foreach (Page page in learningObject.PageIndex.IndexList)
            {
              if (page.Url == pageUrl)
              {
                learningObject.PageIndex.DeleteByUrl(pageUrl);
                //
                // TODO: re-order the index
                //
                learningObject.ReorderPageList();
                learningObject.Save();
                return "Page deleted";
              }
            }
          }
          else
          {
            return "Learning Object [" + learningObjectUrl + "] not found";
          }
        }
        catch (Exception e)
        {
          return e.ToString();
        }
        return "Page [" + pageUrl + "] not deleted";
      }
      else
      {
        return Global.ACCESS_DENIED;
      }
    }

    [WebMethod]
    [ScriptMethod]
    public string MovePageUp(string learningObjectUrl, string pageUrl)
    {
      if (Global.IsContentEditor)
      {
        LearningObject learningObject = Global.LearningObjectIndex.GetByUrl(learningObjectUrl);
        if (learningObject != null)
        {
          int x = learningObject.PageIndex.IndexList.Count;
          if (x > 1)
          {
            for (int i = 1; i < x; i++)
            {
              if (learningObject.PageIndex.IndexList[i].Url.Equals(pageUrl))
              {
                int o = learningObject.PageIndex.IndexList[i].Order;
                learningObject.PageIndex.IndexList[i].Order = learningObject.PageIndex.IndexList[i - 1].Order;
                learningObject.PageIndex.IndexList[i - 1].Order = o;
              }
            }
            learningObject.PageIndex.IndexList.Sort();
            learningObject.Save();
            return "Page [" + pageUrl + "] moved";
          }
        }
        else
        {
          return "Learning Object [" + learningObjectUrl + "] not found";
        }
        return "Unable to move page [" + pageUrl + "]";
      }
      else
      {
        return Global.ACCESS_DENIED;
      }
    }

    [WebMethod]
    [ScriptMethod]
    public string MovePageDown(string learningObjectUrl, string pageUrl)
    {
      if (Global.IsContentEditor)
      {
        LearningObject learningObject = Global.LearningObjectIndex.GetByUrl(learningObjectUrl);
        if (learningObject != null)
        {
          int x = learningObject.PageIndex.IndexList.Count;
          if (x > 1)
          {
            for (int i = x - 1; i >= 0; i--)
            {
              if (learningObject.PageIndex.IndexList[i].Url.Equals(pageUrl))
              {
                int o = learningObject.PageIndex.IndexList[i].Order;
                learningObject.PageIndex.IndexList[i].Order = learningObject.PageIndex.IndexList[i + 1].Order;
                learningObject.PageIndex.IndexList[i + 1].Order = o;
              }
            }

            learningObject.PageIndex.IndexList.Sort();
            learningObject.Save();
            return "Page [" + pageUrl + "] moved";
          }
        }
        else
        {
          return "Learning Object [" + learningObjectUrl + "] not found";
        }
        return "Unable to move page [" + pageUrl + "]";
      }
      else
      {
        return Global.ACCESS_DENIED;
      }
    }

    [WebMethod]
    [ScriptMethod]
    public string Edit(string learningObjectUrl, string oldPageUrl, string newPageTitle, string newPageContents)
    {
      if (Global.IsContentEditor)
      {
        Page oldPage = this.GetByUrl(learningObjectUrl, oldPageUrl);
        if (oldPage != null)
        {
          oldPage.Title = newPageTitle;
          oldPage.Contents = newPageContents;
          oldPage.GenerateUrl();
          oldPage.ModifiedDateTime = DateTime.Now;

          LearningObject learningObject = Global.LearningObjectIndex.GetByUrl(learningObjectUrl);
          if (learningObject != null)
          {
            learningObject.PageIndex.IndexList.Sort();
            learningObject.Save();
            return "Page updated";
          }
          // get parent
        }
        return "Error updating page";
      }
      else
      {
        return Global.ACCESS_DENIED;
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


  }
}