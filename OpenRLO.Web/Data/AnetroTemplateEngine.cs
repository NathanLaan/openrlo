using System;
using System.Collections.Generic;
using System.Web;

namespace OpenRLO.Web.Data
{

  /// <summary>
  /// A wrapper to generate 
  /// </summary>
  public class AnetroTemplateEngine
  {


    public static readonly string TemplatePathIndex = HttpContext.Current.Server.MapPath("/App_Data/_AnetroTemplateIndex.html");
    public static readonly string TemplatePathCategory = HttpContext.Current.Server.MapPath("/App_Data/_AnetroTemplateCategory.html");
    public static readonly string TemplatePathArticle = HttpContext.Current.Server.MapPath("/App_Data/_AnetroTemplateArticle.html");
    public static readonly string TemplatePathBase = HttpContext.Current.Server.MapPath("/");

    private AnetroTemplateIndex _anetroTemplateIndex;
    private string _indexTemplatePath;
    private string _categoryTemplatePath;
    private string _articleTemplatePath;
    private string _baseOutputPath;

    public string AlternativeOutputPath { get; set; }

    public AnetroTemplateEngine(string indexTemplatePath, string categoryTemplatePath, string articleTemplatePath, string baseOutputPath)
    {
      this._indexTemplatePath = indexTemplatePath;
      this._categoryTemplatePath = categoryTemplatePath;
      this._articleTemplatePath = articleTemplatePath;
      this._baseOutputPath = baseOutputPath;
      this._anetroTemplateIndex = new AnetroTemplateIndex(indexTemplatePath, baseOutputPath);
    }

    public void GenerateAll()
    {
      this.AlternativeOutputPath = Global.SiteVersion + DateTime.Now.ToString(".yyyy.MMdd.HHmm.ssff");

      this._anetroTemplateIndex.AlternativeOutputPath = this.AlternativeOutputPath;
      this._anetroTemplateIndex.Generate();
      foreach (Article article in Global.ArticleIndex.List)
      {
        AnetroTemplateArticle anetroTemplateArticle = new AnetroTemplateArticle(this._articleTemplatePath, this._baseOutputPath);
        anetroTemplateArticle.AlternativeOutputPath = this.AlternativeOutputPath;
        anetroTemplateArticle.Article = article;
        anetroTemplateArticle.Generate();
      }
      foreach (Category category in Global.CategoryIndexNew.IndexList)
      {
        AnetroTemplateCategory anetroTemplateCategory = new AnetroTemplateCategory(this._categoryTemplatePath, this._baseOutputPath, category.Url);
        anetroTemplateCategory.AlternativeOutputPath = this.AlternativeOutputPath;
        anetroTemplateCategory.Generate();
      }
    }

  }
}