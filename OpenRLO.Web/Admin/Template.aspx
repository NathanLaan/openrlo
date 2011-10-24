<%@ Page Title="" Language="C#" MasterPageFile="~/SiteAdmin.Master" AutoEventWireup="true" CodeBehind="Template.aspx.cs" Inherits="OpenRLO.Web.Admin.Template" %>
<asp:Content ID="Content1" ContentPlaceHolderID="bodyContentPlaceHolder" runat="server">
<!--<h2>Template</h2>-->
<br /><a href="#" id="generate">Generate Site Content</a>
<br /><a href="#" id="save">Save All Site Content</a>
<br /><a href="#" id="random">Generate Random</a>
<div id="output"></div>

<script type="text/javascript">

  $(document).ready(function () {
    $('#generate').click(function () {
      generateAll();
    });
  });
  $(document).ready(function () {
    $('#save').click(function () {
      saveAll();
    });
  });
  $(document).ready(function () {
    $('#random').click(function () {
      random();
    });
  });

  function generateAll() {
    $.ajax({
      type: "POST",
      url: "/service/TemplateService.asmx/GenerateAll",
      data: "{}",
      contentType: "application/json; charset=utf-8",
      dataType: "json",
      success: function (res) {
        consoleDebug(res);
        $('#output').append('Generate Site Content Successfull. <a href="/' + res.d + '/">VIEW ALTERNATIVE OUTPUT</a>.<br/>');
      },
      error: function (err) {
        consoleDebug('Generate Site Content Error', err);
        $('#output').append('Generate Site Content Error.<br/>');
      }
    });
  }

  function saveAll() {
    $.ajax({
      type: "POST",
      url: "/service/TemplateService.asmx/SaveAll",
      data: "{}",
      contentType: "application/json; charset=utf-8",
      dataType: "json",
      success: function (msg) {
        $('#output').append('Save All Site Content Successfull.<br/>');
      },
      error: function (err) {
        consoleDebug("SAVE ALL SITE ERROR", err);
        $('#output').append('Save All Site Content Error.<br/>');
      }
    });
  }

  function random() {
    $.ajax({
      type: "POST",
      url: "/service/ArticleService.asmx/GenerateRandomArticles",
      data: '{"num":"5"}',
      contentType: "application/json; charset=utf-8",
      dataType: "json",
      success: function () {
        $('#output').append('GENERATE RANDOM ARTICLES SUCCESS.<br/>');
      },
      error: function (err) {
        consoleDebug("GENERATE RANDOM ARTICLES ERROR", err);
        $('#output').append('GENERATE RANDOM ARTICLES ERROR.<br/>');
      }
    });
  }

</script>

</asp:Content>