<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMobile.Master" AutoEventWireup="true" CodeBehind="Learn.aspx.cs" Inherits="OpenRLO.Web.Learn" %>
<asp:Content ID="Content2" ContentPlaceHolderID="bodyContentPlaceHolder" runat="server">
  <form id="learnForm" runat="server">
    <asp:ScriptManager runat="server" ID="masterPageScriptManager" AsyncPostBackErrorMessage="timeout" AsyncPostBackTimeout="300">
      <Services>
        <asp:ServiceReference Path="~/Service/LearningObjectService.asmx" />
        <asp:ServiceReference Path="~/Service/PageService.asmx" />
      </Services>
    </asp:ScriptManager>
  </form>

  <h2 id="pageTitle">LEARN</h2>
  <div class="clearfix" id="pageContent">Loading page contents...</div>

  <br />
  <br />

  <!-- jump menu -->
  <div class="clearfix">
    Jump to page: <select class="span6" name="pageList" id="pageList"></select><a href="#" class="btn" id="jumpListButton">Go</a>
  </div>
  
  
  <span class="label important">TODO: Paging Controls</span>
  
  <script language="javascript" type="text/javascript">

    $(document).ready(function () {
      loadPageContent();
    });

    function loadPageContent() {
      // t = "learningObjectUrl"
      var t = $('#hiddenFieldT').val();
      var p = $('#hiddenFieldP').val();

      OpenRLO.Web.Service.PageService.GetList(t, function (a) {
        if (a != null) {
          var pageList = $('#pageList')[0];
          pageList.options.length = 0;
          $.each(a, function () {
            var i = pageList.options.length;
            pageList.options[i] = new Option((i+1) + ": " + a[i].Title, a[i].Url);
          });
        }
      }, function (m) {
        alert('Error loading page contents');
      });

      if (p == null || p == "") {
        p = 1;
      }

      OpenRLO.Web.Service.PageService.GetByUrl(t, p, function (page) {
        $('#pageContent').html("Loading page contents...");
        if (page != null) {
          $('#pageContent').html(page.Contents);
          $('#pageTitle').html(page.Title);
        } else {
          $('#pageContent').html("Invalid page contents!");
        }
      }, function (m) {
        alert('Error: ' + m.toString() + '.<br/>');
        $('#pageContent').html("Error loading page contents");
      });
      

    }

  </script>

</asp:Content>