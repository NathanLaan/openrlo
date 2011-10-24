<%@ Page Title="" Language="C#" MasterPageFile="~/SiteAdmin.Master" AutoEventWireup="true" CodeBehind="AdminArticleNew.aspx.cs" Inherits="OpenRLO.Web.Admin.AdminArticleNew" %>
<asp:Content ID="Content2" ContentPlaceHolderID="bodyContentPlaceHolder" runat="server">
  <asp:ScriptManager runat="server" ID="pageScriptManager" AsyncPostBackErrorMessage="timeout" AsyncPostBackTimeout="300">
    <Services>
      <asp:ServiceReference Path="~/Service/ArticleService.asmx" />
      <asp:ServiceReference Path="~/Service/CategoryService.asmx" />
      <asp:ServiceReference Path="~/Service/TemplateService.asmx" />
    </Services>
  </asp:ScriptManager>
  <!--<h2>New Article</h2>-->
    <br />
  <label for="txtCategory">Category:</label><select class="inputControl" id="selCategory"></select>
  <br /><label>Title:</label><input class="inputControl" type="text" id="txtTitle" size="40" maxlength="100" onkeyup="generateTitleUrl();" />
  <br /><label>Title URL:</label><input class="inputControl" type="text" id="txtTitleUrl" size="40" maxlength="100" onkeyup="checkTitleUrl();" />
  <br /><label>Short URL:</label><input class="inputControl" type="text" id="txtShortUrl" size="40" maxlength="100" onkeyup="checkShortUrl();" /><input class="inputControl" type="button" id="btnGenerateShortUrl" value="&laquo;&nbsp;New" onclick="generateShortUrl();" />
  <br /><label>Tags:</label><input class="inputControl" type="text" id="txtTags" size="40" maxlength="100" />
  <br /><label>Date/Time:</label><input class="inputControl" type="text" id="txtDateTime" size="40" maxlength="100" /><input type="button" class="inputControl" id="btnCurrentDateTime" value="&laquo;&nbsp;Now" onclick="setDate();" />
  <br /><textarea class="inputControl" id="txtContent" rows="24" cols="70" onchange="txtContent_OnChange();" onkeyup="txtContent_OnChange();"></textarea>
  <br /><a href="http://daringfireball.net/projects/markdown/" target="_blank">MARKDOWN</a>: [Text](http://link.com/) ![AltText](img)
  <br /><input class="inputControl" type="button" value="Preview" id="btnPreview" onclick="previewArticle();" />&nbsp;<input class="inputControl" type="button" value="Save" id="btnSave" onclick="addArticle();" />&nbsp;<input class="inputControl" type="checkbox" id="chkPublished" checked="checked" />Published&nbsp;
  <br /><br /><div id="output"></div>
  
<script type="text/javascript">
  $(document).ready(function () {
    $('#txtDateTime').val(new Date().format('yyyy/MM/dd hh:mm tt'));
    loadList();
    generateShortUrl();
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
  function loadList() {
    OpenRLO.Web.Service.CategoryService.GetList(function (a) {
      var optionList = $('#selCategory')[0];
      optionList.options.length = 0;
      optionList.options[0] = new Option('(None)', '(None)', true, true);
      if (a != null) {
        $.each(a, function (i,v) {
          var idx = optionList.options.length;
          optionList.options[idx] = new Option(v.Title, v.Url);
        });
      }
    }, function (m) {
      $('div#output').html('Unable to load category list.<br/>');
    });
  }
  function setDate() {
    $('#txtDateTime').val(new Date().format('yyyy/MM/dd hh:mm tt'));
  }
  var txtContent_changed = false;
  function txtContent_OnChange() {
    txtContent_changed = true;
  }
  function checkShortUrl() {
    OpenRLO.Web.Service.ArticleService.ShortUrlExists($('#txtShortUrl').val(), function (b) {
      if (b) {
        $('div#output').html('Short URL Exists.<br/>');
        $('#selCategory').attr('disabled', true);
        $('#txtTitle').attr('disabled', true);
        $('#txtTitleUrl').attr('disabled', true);
        $('#txtTags').attr('disabled', true);
        $('#txtDateTime').attr('disabled', true);
        $('#txtContent').attr('disabled', true);
        $('#chkPublished').attr('disabled', true);
        $('#btnSave').attr('disabled', true);
      } else {
        $('div#output').html('');
        $('#selCategory').attr('disabled', false);
        $('#txtTitle').attr('disabled', false);
        $('#txtTitleUrl').attr('disabled', false);
        $('#txtTags').attr('disabled', false);
        $('#txtDateTime').attr('disabled', false);
        $('#txtContent').attr('disabled', false);
        $('#chkPublished').attr('disabled', false);
        $('#btnSave').attr('disabled', false);
      }
    }, function (m) {
      $('div#output').html('Unable to check Short URL: ' + m.toString() + '<br/>');
    });
  }
  function checkTitleUrl() {
    OpenRLO.Web.Service.ArticleService.TitleUrlExists($('#txtTitleUrl').val(), function (b) {
      if (b) {
        $('div#output').html('Title URL Exists.<br/>');
        $('#selCategory').attr('disabled', true);
        $('#txtTitle').attr('disabled', true);
        $('#txtShortUrl').attr('disabled', true);
        $('#txtTags').attr('disabled', true);
        $('#txtDateTime').attr('disabled', true);
        $('#txtContent').attr('disabled', true);
        $('#chkPublished').attr('disabled', true);
        $('#btnSave').attr('disabled', true);
      } else {
        $('div#output').html('');
        $('#selCategory').attr('disabled', false);
        $('#txtTitle').attr('disabled', false);
        $('#txtShortUrl').attr('disabled', false);
        $('#txtTags').attr('disabled', false);
        $('#txtDateTime').attr('disabled', false);
        $('#txtContent').attr('disabled', false);
        $('#chkPublished').attr('disabled', false);
        $('#btnSave').attr('disabled', false);
      }
    }, function (m) {
      $('div#output').html('Unable to check Title URL: ' + m.toString() + '<br/>');
    });
  }
  function generateTitleUrl() {
    $('#txtTitleUrl').val($('#txtTitle').val().toString().cleanString());
  }
  function generateShortUrl() {
    OpenRLO.Web.Service.ArticleService.GenerateShortUrl(function (sURL) {
      $('#txtShortUrl').val(sURL);
      checkShortUrl();
    }, function (m) {
      $('div#output').html('Unable to generate Short URL: ' + m.toString() + '<br/>');
    });
  }
  function disableInputControl(d) {
    $('.inputControl').attr('disabled', d);
  }
  function addArticle() {
    var lst = document.getElementById('selCategory');
    if (lst.selectedIndex >= 0) {

      $('div#output').html('Saving...');
      disableInputControl(true);

      var art = new OpenRLO.Web.Data.Article();
      var ver = new OpenRLO.Web.Data.ArticleVersion();
      art.Category = lst.options[lst.selectedIndex].value;
      art.Title = $('#txtTitle').val();
      art.TitleUrl = $('#txtTitleUrl').val();
      art.ShortUrl = $('#txtShortUrl').val();
      //art.Published = ($('#chkPublished:checked').val() != undefined);
      art.Published = $('#chkPublished').attr('checked');
      art.PublishedDateTime = $('#txtDateTime').val();
      ver.DateTime = $('#txtDateTime').val();
      ver.Contents = $('#txtContent').val();
      ver.Version = 1;
      OpenRLO.Web.Service.ArticleService.Add(art, ver, function (m) {
        disableInputControl(false);
        $('div#output').html(m + '<br/>');
        //$('div#output').html(m + '<br><a href="' + art.ViewUrl + '">VIEW</a>&nbsp;|&nbsp;<a href="' + art.AdminUrl + '">EDIT</a><br/>');
        txtContent_changed = false;
        window.location = "/admin/article/edit/" + art.TitleUrl;
      }, function (err) {
        disableInputControl(false);
        $('div#output').html('Error saving article.<br/>');
        consoleDebug("ERROR SAVING ARTICLE [" + art.Title + "]", err);
      });
    }
  }

  function previewArticle() {
    disableInputControl(true);
    var art = new OpenRLO.Web.Data.Article();
    var ver = new OpenRLO.Web.Data.ArticleVersion();
    art.Category = "article-preview";// new Date().format('yyyyMMddhhmmtt');
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
</script>
</asp:Content>