<%@ Page Title="" Language="C#" MasterPageFile="~/SiteAdmin.Master" AutoEventWireup="true" CodeBehind="AdminArticleEdit.aspx.cs" Inherits="OpenRLO.Web.Admin.AdminArticleEdit" %>
<asp:Content ID="Content2" ContentPlaceHolderID="bodyContentPlaceHolder" runat="server">
  <asp:ScriptManager runat="server" ID="masterPageScriptManager" AsyncPostBackErrorMessage="timeout" AsyncPostBackTimeout="300">
    <Services>
      <asp:ServiceReference Path="~/Service/ArticleService.asmx" />
      <asp:ServiceReference Path="~/Service/CategoryService.asmx" />
      <asp:ServiceReference Path="~/Service/TemplateService.asmx" />
    </Services>
  </asp:ScriptManager>
  <!--<h2>Edit Article</h2>-->
  <br /><label for="txtVersion">Version:</label><select class="inputControl" id="lstVersion" onchange="lstVersion_Change()"></select>
  <br /><label>Category:</label><select class="inputControl" id="selCategory"></select>
  <br /><label>Title:</label><input class="inputControl" type="text" id="txtTitle" size="40" maxlength="100" onkeyup="generateTitleUrl();" />
  <br /><label>Title URL:</label><input class="inputControl" type="text" id="txtTitleUrl" size="40" maxlength="100" onkeyup="checkTitleUrl();" />
  <br /><label>Short URL:</label><input class="inputControl" type="text" id="txtShortUrl" size="40" maxlength="100" onkeyup="checkShortUrl();" /><input type="button" class="inputControl" id="btnGenerateShortUrl" value="&laquo;&nbsp;New" onclick="generateShortUrl();" />
  <br /><label>Tags:</label><input class="inputControl" type="text" id="txtTags" size="40" maxlength="100" />
  <br /><label>Date/Time:</label><input class="inputControl" type="text" id="txtDateTime" size="40" maxlength="100" /><input class="inputControl" type="button" id="btnCurrentDateTime" value="&laquo;&nbsp;Now" onclick="setDate();" />
  <br /><textarea class="inputControl" id="txtContent" rows="24" cols="70" onchange="txtContent_OnChange()"></textarea>
  <br /><a href="http://daringfireball.net/projects/markdown/" target="_blank">MARKDOWN</a>: [Text](http://link.com/) ![AltText](img)
  <br /><input class="inputControl" type="button" value="Preview" id="btnPreview" onclick="previewArticle();" />&nbsp;<input class="inputControl" type="button" value="Save" onclick="editArticle();" />&nbsp;<input class="inputControl" type="checkbox" id="chkPublished" checked="checked" />Published&nbsp;<a href="#" target="_blank" id="lnkPreview">View</a>
  <br /><br /><div id="output"></div>

<script type="text/javascript">
  $(document).ready(function () {
    disableInputControl(true);
    loadList();
    $(window).bind("beforeunload", function () {
      if (txtContent_changed) {
        return "You have unsaved changes. Are you sure you want to continue?";
        //return confirm("You have unsaved changes. Are you sure you want to continue?");
      }
    });
    $('form').submit(function () {
      $(window).unbind("beforeunload");
    });
  });
  function disableInputControl(d) {
    $('.inputControl').attr('disabled', d);
  }
  function setDate() {
    $('#txtDateTime').val(new Date().format('yyyy/MM/dd hh:mm tt'));
  }
  var art;
  var txtContent_changed = false;
  function txtContent_OnChange() {
    txtContent_changed = true;
  }
  function loadList() {
    OpenRLO.Web.Service.CategoryService.GetList(function (a) {
      var optionList = $('#selCategory')[0];
      optionList.options.length = 0;
      optionList.options[0] = new Option('(None)', '(None)', true, true);
      if (a != null) {
        $.each(a, function (i, v) {
          var idx = optionList.options.length;
          optionList.options[idx] = new Option(v.Title, v.Url);
        });
      }
      loadArticle();
    }, function (m) {
      $('div#output').html('Unable to load category list.<br/>');
    });
  }
  function loadArticle() {
    var a = $('#hiddenFieldA').val();
    OpenRLO.Web.Service.ArticleService.Get(null, a, GetArticleCBS, function (m) {
      $('div#output').html('Article not found.<br/>');
    });
  }
  function GetArticleCBS(article) {
    if (article == null) {
      $('div#output').html('Invalid article.<br/>');
    } else {
      art = article;
      var categoryList = document.getElementById('selCategory');
      for (var i = 0; i < categoryList.options.length; i++) {
        if (categoryList.options[i].value == article.Category) {
          categoryList.options[i].selected = true;
        }
      }

      //lnkPreview.href = "/" + article.Category + "/" + article.TitleUrl;
      lnkPreview.href = article.ViewUrl;
      lnkPreview.value = "Preview";

      $('#txtTitle').val(article.Title);
      $('#txtTitleUrl').val(article.TitleUrl);
      $('#txtShortUrl').val(article.ShortUrl);
      $('#txtContent').val(article.LatestArticleVersion.Contents);
      //$('#txtDateTime').val(article.LatestArticleVersion.DateTime.format('yyyy/MM/dd hh:mm tt'));
      $('#chkPublished').attr('checked', article.Published);
      setDate();
      var articleVersionArray = article.ArticleVersionList;
      var versionList = document.getElementById('lstVersion');
      versionList.options.length = 0;
      $.each(articleVersionArray, function () {
        var idx = versionList.options.length;
        versionList.options[idx] = new Option("Version " + articleVersionArray[idx].Version + " - " + articleVersionArray[idx].DateTime.format('yyyy/MM/dd hh:mm tt'), articleVersionArray[idx].Version);
      });
      versionList.selectedIndex = versionList.length - 1;
      txtContent_changed = false;
      disableInputControl(false);

    }
  }
  function lstVersion_Change() {
    var versionList = document.getElementById('lstVersion');
    if (versionList.selectedIndex >= 0) {
      var elem = versionList.options[versionList.selectedIndex];
      var versionNumber = elem.value;
      var articleVersionArray = art.ArticleVersionList;
      for (i = 0; i < articleVersionArray.length; i++) {
        if (articleVersionArray[i].Version == versionNumber) {
          if (!txtContent_changed || confirm("Discard changes?")) {
            document.getElementById("txtContent").value = articleVersionArray[i].Contents;
            txtContent_changed = false;
            break;
           } else {
            break;
          }
        }
      }
    }
  }
  function editArticle() {
    var id_a = $('#hiddenFieldA').val();
    var lst = document.getElementById('selCategory');
    if (lst.selectedIndex >= 0) {
      disableInputControl(true);
      var category = lst.options[lst.selectedIndex].value;
      var title = $('#txtTitle').val();
      var titleUrl = $('#txtTitleUrl').val();
      var shortUrl = $('#txtShortUrl').val();
      var contents = $('#txtContent').val();
      var datetime = $('#txtDateTime').val();
      //var published = ($('#chkPublished:checked').val() != undefined);
      var published = $('#chkPublished').attr('checked');
      OpenRLO.Web.Service.ArticleService.Edit(art.TitleUrl, category, title, titleUrl, shortUrl, contents, datetime, published, function (m) {
        txtContent_changed = false;
        $('div#output').html(m + '<br/>');
        disableInputControl(false);
        txtContent_changed = false;
        window.location = "/admin/article/edit/" + titleUrl;
      }, function (err) {
        disableInputControl(false);
        $('div#output').html('Unable to save article.<br/>');
        $('div#output').html('Error saving article.<br/>');
        consoleDebug("ERROR SAVING ARTICLE: ", err);
      });
    }
  }
  function previewArticle() {
    disableInputControl(true);
    var art = new OpenRLO.Web.Data.Article();
    var ver = new OpenRLO.Web.Data.ArticleVersion();
    art.Category = "article-preview"; // new Date().format('yyyyMMddhhmmtt');
    art.Title = $('#txtTitle').val();
    art.TitleUrl = new Date().format('yyyyMMddhhmmss_') + $('#txtTitleUrl').val();
    art.ShortUrl = $('#txtShortUrl').val();
    art.Published = $('#chkPublished').attr('checked');
    art.PublishedDateTime = $('#txtDateTime').val();
    ver.DateTime = $('#txtDateTime').val();
    ver.Contents = $('#txtContent').val();
    ver.Version = 1;
    OpenRLO.Web.Service.TemplateService.Preview(art, ver, function (m) {
      disableInputControl(false);
      window.open(m, "_blank");
    }, function (err) {
      disableInputControl(false);
      $('div#output').html('Error previewing article.<br/>');
      consoleDebug("ERROR PREVIEWING ARTICLE [" + art.Title + "]", err);
    });
  }


  function generateTitleUrl() {
    $('#txtTitleUrl').val($('#txtTitle').val().toString().cleanString());
  }
  function generateShortUrl() {
    OpenRLO.Web.Service.ArticleService.GenerateShortUrl(function (sURL) {
      $('#txtShortUrl').val(sURL);
    }, function (m) {
      $('div#output').html('Unable to generate Short URL: ' + m.toString() + '<br/>');
    });
  }
  function checkShortUrl() {
    OpenRLO.Web.Service.ArticleService.ShortUrlExists($('#txtShortUrl').val(), function (b) {
      if (b) {
        $('div#output').html('Short URL Exists.<br/>');
        $('#lstVersion').attr('disabled', true);
        $('#selCategory').attr('disabled', true);
        $('#txtTitle').attr('disabled', true);
        $('#txtTitleUrl').attr('disabled', true);
        $('#txtTags').attr('disabled', true);
        $('#txtDateTime').attr('disabled', true);
        $('#txtContent').attr('disabled', true);
        $('#chkPublished').attr('disabled', true);
        $('#btnSave').attr('disabled', true);
        $('#btnCurrentDateTime').attr('disabled', true);
      } else {
        $('div#output').html('');
        $('#lstVersion').attr('disabled', false);
        $('#selCategory').attr('disabled', false);
        $('#txtTitle').attr('disabled', false);
        $('#txtTitleUrl').attr('disabled', false);
        $('#txtTags').attr('disabled', false);
        $('#txtDateTime').attr('disabled', false);
        $('#txtContent').attr('disabled', false);
        $('#chkPublished').attr('disabled', false);
        $('#btnSave').attr('disabled', false);
        $('#btnCurrentDateTime').attr('disabled', false);
      }
    }, function (m) {
      $('div#output').html('Unable to check Short URL: ' + m.toString() + '<br/>');
    });
  }
  function checkTitleUrl() {
    OpenRLO.Web.Service.ArticleService.TitleUrlExists($('#txtTitleUrl').val(), function (b) {
      if (b) {
        $('div#output').html('Title URL Exists.<br/>');
        $('#lstVersion').attr('disabled', true);
        $('#selCategory').attr('disabled', true);
        $('#txtTitle').attr('disabled', true);
        $('#txtShortUrl').attr('disabled', true);
        $('#txtTags').attr('disabled', true);
        $('#txtDateTime').attr('disabled', true);
        $('#txtContent').attr('disabled', true);
        $('#chkPublished').attr('disabled', true);
        $('#btnSave').attr('disabled', true);
        $('#btnCurrentDateTime').attr('disabled', true);
      } else {
        $('div#output').html('');
        $('#lstVersion').attr('disabled', false);
        $('#selCategory').attr('disabled', false);
        $('#txtTitle').attr('disabled', false);
        $('#txtShortUrl').attr('disabled', false);
        $('#txtTags').attr('disabled', false);
        $('#txtDateTime').attr('disabled', false);
        $('#txtContent').attr('disabled', false);
        $('#chkPublished').attr('disabled', false);
        $('#btnSave').attr('disabled', false);
        $('#btnCurrentDateTime').attr('disabled', false);
      }
    }, function (m) {
      $('div#output').html('Unable to check Title URL: ' + m.toString() + '<br/>');
    });
  }
</script>
</asp:Content>