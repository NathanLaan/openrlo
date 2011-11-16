using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using OpenRLO.Web.Data;

namespace OpenRLO.Web
{
  public partial class ViewArticle : System.Web.UI.Page
  {
    protected void Page_Load(object sender, EventArgs e)
    {
      Response.Cache.SetExpires(DateTime.Now.AddMonths(1));
      Response.Cache.SetCacheability(HttpCacheability.ServerAndPrivate);
      Response.Cache.SetValidUntilExpires(true);

      string c = this.Request["c"];
      string a = this.Request["a"];
      string s = this.Request["s"];
      //this.Title = string.Format("{0}: {2}", Global.SiteSettings.SiteName, c, a);
      //Page.ClientScript.RegisterHiddenField("hiddenFieldC", c);
      //Page.ClientScript.RegisterHiddenField("hiddenFieldA", a);
      //Page.ClientScript.RegisterHiddenField("hiddenFieldS", s);

      //Article article = null;

      //if (!string.IsNullOrEmpty(c) && !string.IsNullOrEmpty(a))
      //{
      //  article = Global.ArticleIndex.GetArticle(c, a);
      //}
      //else if (!string.IsNullOrEmpty(s))
      //{
      //  article = Global.ArticleIndex.GetArticle(s);
      //}
    //  if (article != null)
    //  {
    //    Category category = Global.CategoryIndexNew.Get(article.Category);
    //    if (category != null)
    //    {
    //      this.lnkCategoryName.Text = category.Title;
    //      this.lnkCategoryName.NavigateUrl = "/" + category.Url;
    //    }
    //    else
    //    {
    //      this.lnkCategoryName.Visible = false;
    //    }
    //    article.Load();
    //    this.lblArticleTitle.Text = article.Title;
    //    this.lblArticleName.Text = article.Title;
    //    this.lnkPermalink.NavigateUrl = Global.SiteSettings.SiteUrl +  "/" + article.Category + "/" + article.TitleUrl;

    //    Page.ClientScript.RegisterHiddenField("hiddenFieldPermalink", this.lnkPermalink.NavigateUrl);

    //    this.lnkShortUrl.NavigateUrl = Global.SiteSettings.ShortURL + "/s/" + article.ShortUrl;
    //    this.lblDateTime.Text = "Posted " + article.PublishedDateTime.ToString("yyyy/MMM/dd");
    //    Markdown markdown = new Markdown();
    //    if (article.LatestArticleVersion != null)
    //    {
    //      string html = markdown.Transform(article.LatestArticleVersion.Contents);
    //      this.lblArticleContent.Text = html;
    //      //this.lblVersion.Text = article.LatestArticleVersion.Version.ToString();
    //    }
    //    else
    //    {
    //      this.lblArticleContent.Text = "Unable to load article.<br>";
    //      this.lblDateTime.Visible = false;
    //    }

    //    if (Global.IsLoggedIn())
    //    {
    //      this.lblEditArticle.Visible = true;
    //      this.lnkEditArticle.Visible = true;
    //      this.lnkEditArticle.NavigateUrl = "/admin/article/edit/" + article.TitleUrl;
    //    }
    //    else
    //    {
    //      this.lblEditArticle.Visible = false;
    //      this.lnkEditArticle.Visible = false;
    //    }
    //  }
    //  else
    //  {
    //    this.lblArticleContent.Text = "Article not found.<br>";
    //    this.lnkCategoryName.Visible = false;
    //    this.lblDateTime.Visible = false;
    //    this.lnkPermalink.Visible = false;
    //    this.lblArticleTitle.Visible = false;
    //    this.lblArticleName.Visible = false;
    //    this.lblEditArticle.Visible = false;
    //    this.lnkEditArticle.Visible = false;
    //  }
    }
  }
}