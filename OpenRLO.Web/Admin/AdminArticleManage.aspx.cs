using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OpenRLO.Web.Admin
{
  public partial class AdminArticleManage : System.Web.UI.Page
  {
    protected void Page_Load(object sender, EventArgs e)
    {
      this.articleList.DataSource = Global.ArticleIndex.List;
      this.articleList.DataBind();
    }
  }
}