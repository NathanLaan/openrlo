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


  <h2>LEARN</h2>
  <p>...</p>

  <!-- for testing purposes -->
  <div class="clearfix">
    <label for="pageList">Pages</label>
    <div class="input">
      <select class="span6" size="5" multiple="multiple" name="pageList" id="pageList"></select>
    </div>
  </div><!-- /clearfix -->
  <!-- for testing purposes -->
  
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
            pageList.options[i] = new Option(a[i].Title, a[i].Url);
          });
        }
      }, function (m) {
        alert('Error: ' + m.toString() + '.<br/>');
      });


      if (p != null) {

        alert("p: " + p);

        OpenRLO.Web.Service.PageService.GetByUrl(t, p, function (p) {
          if (p != null) {
            alert("CONTENT: " + p.Content);
          }
        }, function (m) {
          alert('Error: ' + m.toString() + '.<br/>');
        });
      }


    }

  </script>

</asp:Content>