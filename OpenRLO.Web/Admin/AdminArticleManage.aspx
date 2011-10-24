<%@ Page Title="" Language="C#" MasterPageFile="~/SiteAdmin.Master" AutoEventWireup="true" CodeBehind="AdminArticleManage.aspx.cs" Inherits="OpenRLO.Web.Admin.AdminArticleManage" %>
<asp:Content ID="Content3" ContentPlaceHolderID="bodyContentPlaceHolder" runat="server">
  <asp:ScriptManager runat="server" ID="masterPageScriptManager" AsyncPostBackErrorMessage="timeout" AsyncPostBackTimeout="300">
    <Services>
      <asp:ServiceReference Path="~/Service/ArticleService.asmx" />
    </Services>
  </asp:ScriptManager>
  <!--<h2>Manage Articles</h2>-->
  <br />
  
  <select id="catList" class="reloadListClass"></select>&nbsp;<a href="/admin/category/manage">Manage Categories</a><br />
  <select id="pubList" class="reloadListClass">
    <option title="Published/Draft" value="all">All Articles</option>
    <option title="Published" value="true">Published Only</option>
    <option title="Draft" value="false">Draft Only</option>
  </select>&nbsp;<a href="/admin/article/new">New Article</a>
  <br />
  <div id="articleListDiv"></div>

  <!--
  http://plugins.jquery.com/project/CreateTable
  IDEA: Have the service return an array of arrays...
  ISSUE: Need to embed controls. Template will likely be a better approach.
  -->

  <!-- http://jtemplates.tpython.com/ 
  #template MAIN}
  <div id="header">{$T.name}</div>
  <table>
  {#foreach $T.table as r}
  {#include row root=$T.r}
  {#/for}
  </table>
  {#/template MAIN}
  {#template row}
  <tr bgcolor="{#cycle values=['#AAAAEE','#CCCCFF']}">
  <td>{$T.name.bold()}</td>
  <td>{$T.age}</td>
  <td>{$T.mail.link('mailto:'+$T.mail)}</td>
  </tr>
  {#/template row}
  -->
  <asp:Repeater runat="server" ID="articleList">
    <HeaderTemplate>
    <table width="100%" class="stripeMe">
    <tr><td><b>Category</b></td><td colspan="2"><b>Title</b></td><td><b>D/T</b></td><td><b>&nbsp;P</b></td><td><b>V</b></td><td>&nbsp;</td><td>&nbsp;</td></tr>
    </HeaderTemplate>
    <ItemTemplate>
    <tr id="tr<%# ((OpenRLO.Web.Data.Article)Container.DataItem).Title %>">
    <td><%# ((OpenRLO.Web.Data.Article)Container.DataItem).CategoryTitle %></td>
    <td><a href="<%# ((OpenRLO.Web.Data.Article)Container.DataItem).AdminUrl %>" title="Open in a new window" target="_blank"><img src="/img/table_edit.png" height="12" width="12" /></a></td>
    <td class="clickMe" id="<%# ((OpenRLO.Web.Data.Article)Container.DataItem).TitleUrl %>"><a href="<%# ((OpenRLO.Web.Data.Article)Container.DataItem).AdminUrl %>"><%# ((OpenRLO.Web.Data.Article)Container.DataItem).Title%></a></td>
    <td><%# ((OpenRLO.Web.Data.Article)Container.DataItem).PublishedDateTime.ToString("yyyy/MMM/dd hh:mm tt")%></td>
    <td><input type="checkbox" id="chk<%# ((OpenRLO.Web.Data.Article)Container.DataItem).Category %>_<%# ((OpenRLO.Web.Data.Article)Container.DataItem).Title %>"  onclick="TogglePublished('<%# ((OpenRLO.Web.Data.Article)Container.DataItem).Category %>','<%# ((OpenRLO.Web.Data.Article)Container.DataItem).Title %>','<%# ((OpenRLO.Web.Data.Article)Container.DataItem).TitleUrl %>',$(this).attr('checked'))" <%# ((OpenRLO.Web.Data.Article)Container.DataItem).Published ? "checked" : "" %> /></td>
    <td><%# ((OpenRLO.Web.Data.Article)Container.DataItem).ArticleVersionList.Count%></td>
    <td><a href="<%# ((OpenRLO.Web.Data.Article)Container.DataItem).ViewUrl %>" target="_blank"><img src="/img/table_go.png" height="12" width="12" /></a></td>
    <td><a onclick="DeleteArticle('<%# ((OpenRLO.Web.Data.Article)Container.DataItem).Category %>','<%# ((OpenRLO.Web.Data.Article)Container.DataItem).Title %>');" href="javascript:void(0);"><img src="/img/delete.png" height="12" width="12" /></a></td>
    </ItemTemplate>
    <FooterTemplate></table></FooterTemplate>
  </asp:Repeater>
  <br /><br /><div id="output"></div>

<script type="text/javascript">

  $(document).ready(function () {
    loadCategoryList();
    //    $('.reloadListClass').change(function () {
    //      loadArticleList();
    //    });
    zebra();
    $(".stripeMe tr").mouseover(function () { $(this).addClass("over"); }).mouseout(function () { $(this).removeClass("over"); });
    $(".clickMe").click(function () {
      consoleDebug(this);
      window.location = "/admin/article/edit/" + $(this).attr('id');
      //alert($(this).attr('id'));
    });
  });

  //
  function zebra() {
    $(".stripeMe tr").removeClass("alt");
    $(".stripeMe tr:even").addClass("alt");
  }

  function loadCategoryList() {
    var listControl = $('#catList')[0];
    listControl.options.length = 0;
    listControl.options[0] = new Option('All Categories','all');
    $.ajax({
      type: "POST",
      url: "/service/CategoryService.asmx/GetList",
      data: "{}",
      contentType: "application/json; charset=utf-8",
      dataType: "json",
      success: function (a) {
        if (a !== undefined && a.d !== undefined) {
          for (var i = 0; i < a.d.length; i++) {
            listControl.options[i + 1] = new Option(a.d[i].Title, a.d[i].Title);
          }
          // TODO:
          //loadArticleList();
        }
      }
    });
  }

  /*
   * cat = category
   * pub = published or not
   */
  function loadArticleList() {
    clearTable();
    var cat = ($('#catList').val() === "all" ? null : $('#catList').val());
    var pub = ($('#pubList').val() === "all" ? null : $('#pubList').val());
    //
    //http://encosia.com/2008/06/05/3-mistakes-to-avoid-when-using-jquery-with-aspnet-ajax/
    //
    var params = "{'categoryName':'" + cat + "', 'published':'" + pub + "'}";
    $('div#output').append('------- loadArticleList() - catList: ' + $('#catList').val() + ' pubList: ' + $('#pubList').val() + '<br/>');
    $('div#output').append('------- loadArticleList() - params: ' + params + '<br/>');
    $.ajax({
      type: "POST",
      url: "/service/ArticleService.asmx/GetArticleList",
      data: params,
      contentType: "application/json; charset=utf-8",
      dataType: "json",
      success: displayArticleList
    });
  }

  function displayArticleList(a) {
    if (a !== undefined && a.d !== undefined) {
      clearTable();
      $.each(a.d, function () {
      });
    }
    $('div#output').append('------- displayArticleList()<br/>');
  }

  function clearTable() {
    $('#articleListDiv').html('');
  }
  function buildTable(a) {
  }

  function DeleteArticle(cat, art) {
    if (confirm("Delete " + art + "?")) {
      OpenRLO.Web.Service.ArticleService.Delete(cat, art, function(message) {
        var el = document.getElementById("tr" + art);
        el.parentNode.removeChild(el);
        zebra();
      }, function(message) {
        alert(message);
        $('div#output').html(message.toString() + '<br/>');
      });
    }
  }

  function TogglePublished(cat, art, artURL, chk) {
    if (confirm((chk ? "Publish " : "Draft ") + art + "?")) {
      OpenRLO.Web.Service.ArticleService.TogglePublished(cat, artURL, chk, function (message) {
        $('div#output').html(message.toString() + '<br/>');
      }, function (message) {
        $('div#output').html(message.toString() + '<br/>');
      });
    } else {
      var el = document.getElementById("chk" + cat + "_" + art);
      el.checked = !chk;
    }
  }

</script>
</asp:Content>