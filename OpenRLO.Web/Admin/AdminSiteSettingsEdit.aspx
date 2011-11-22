<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMobile.Master" AutoEventWireup="true" CodeBehind="AdminSiteSettingsEdit.aspx.cs" Inherits="OpenRLO.Web.Admin.AdminSiteSettingsEdit" %>
<asp:Content ID="Content1" ContentPlaceHolderID="bodyContentPlaceHolder" runat="server">
  <form runat="server">
  <asp:ScriptManager runat="server" ID="pageScriptManager" AsyncPostBackErrorMessage="timeout" AsyncPostBackTimeout="300">
    <Services>
      <asp:ServiceReference Path="~/Service/SiteSettingsService.asmx" />
    </Services>
  </asp:ScriptManager>
  </form>
  <!--<h2>Edit Site Settings</h2>-->
  <br />
  <label for="txtName">Site Name:</label><input type="text" id="txtName" size="50" maxlength="50" />
  <br /><label>Site Copyright:</label><input type="text" id="txtCopyright" size="50" maxlength="50" />
  <br /><label>Site URL:</label><input type="text" id="txtUrl" size="50" maxlength="50" />
  <br /><label>Short URL:</label><input type="text" id="txtShortUrl" size="50" maxlength="50" />
  <br /><label>SURL Length:</label><input type="text" id="txtShortUrlLength" size="50" maxlength="50" />
  <br /><label>Feed URL:</label><input type="text" id="txtFeedUrl" size="50" maxlength="50" />
  <br /><label>Feed Title:</label><input type="text" id="txtFeedDescription" size="50" maxlength="50" />
  <br /><label>TimeZone:</label><input type="text" id="txtTimeZone" size="50" maxlength="50" />
  <br /><label>Upload URL:</label><input type="text" id="txtUploadSiteUrl" size="50" maxlength="50" />
  <br /><label>Google Analytics:</label><input type="text" id="txtGoogleAnalytics" size="50" maxlength="50" />
  <br /><label>&nbsp;</label><input type="button" value="Save" onclick="SaveSiteSettings();" />
  <br /><br /><div id="output"></div>
  
<script type="text/javascript">
  $(document).ready(function () {
    $('div#output').html('Ready().<br/>');
    LoadSiteSettings();
  });
  function LoadSiteSettings() {
    OpenRLO.Web.Service.SiteSettingsService.Get(function (siteSettings) {
      $('#txtName').val(siteSettings.SiteName);
      $('#txtUrl').val(siteSettings.SiteUrl);
      $('#txtCopyright').val(siteSettings.SiteCopyright);
      $('#txtFeedDescription').val(siteSettings.SiteFeedDescription);
      $('#txtFeedUrl').val(siteSettings.SiteFeedUrl);
      $('#txtTimeZone').val(siteSettings.TimeZone);
      $('#txtShortUrl').val(siteSettings.ShortURL);
      $('#txtShortUrlLength').val(siteSettings.ShortUrlLength);
      $('#txtUploadSiteUrl').val(siteSettings.UploadSiteUrl);
      $('#txtGoogleAnalytics').val(siteSettings.GoogleAnalyticsTrackingCode);
      $('div#output').html('Site Settings Loaded.<br/>');
    }, function (m) {
      $('div#output').html('Unable to load site settings.<br/>');
    });
  }
  function SaveSiteSettings() {
    var siteSettings = new OpenRLO.Web.Data.SiteSettings();
    siteSettings.SiteName = $('#txtName').val();
    siteSettings.SiteUrl = $('#txtUrl').val();
    siteSettings.SiteCopyright = $('#txtCopyright').val();
    siteSettings.SiteFeedDescription = $('#txtFeedDescription').val();
    siteSettings.SiteFeedUrl = $('#txtFeedUrl').val();
    siteSettings.TimeZone = $('#txtTimeZone').val();
    siteSettings.ShortURL = $('#txtShortUrl').val();
    siteSettings.UploadSiteUrl = $('#txtUploadSiteUrl').val();
    siteSettings.GoogleAnalyticsTrackingCode = $('#txtGoogleAnalytics').val();
    OpenRLO.Web.Service.SiteSettingsService.Set(siteSettings, function (m) {
      $('div#output').html(m.toString()+'<br/>');
    }, function (e) {
      $('div#output').html('Unable to save site settings: ' + e.toString() + '<br/>');
    });
  }
</script>
</asp:Content>