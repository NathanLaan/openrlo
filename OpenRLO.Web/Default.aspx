<%@ Page Language="C#" MasterPageFile="~/SiteMobile.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="OpenRLO.Web.Default" %>
<%@ OutputCache Duration="2400" VaryByParam="*"  %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageNameContent" runat="server">Open Social Learning</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="TaglineContent" runat="server"></asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="bodyContentPlaceHolder" runat="server">
  <form id="Form1" runat="server">
  <asp:ScriptManager runat="server" ID="masterPageScriptManager" AsyncPostBackErrorMessage="timeout" AsyncPostBackTimeout="300">
    <Services>
      <asp:ServiceReference Path="~/Service/SiteUserService.asmx" />
      <asp:ServiceReference Path="~/Service/LearningObjectService.asmx" />
    </Services>
  </asp:ScriptManager>
  </form>

  <script language="javascript" type="text/javascript">

    $(document).ready(function () {
      LoadLearningObjectList();
    });

    function LoadLearningObjectList() {
      OpenRLO.Web.Service.LearningObjectService.GetList(function (a) {
        if (a != null) {
          var listControl1 = $('#loList1')[0];
          listControl1.options.length = 0;
          $.each(a, function () {
            var i = listControl1.options.length;
            listControl1.options[i] = new Option(a[i].Title, a[i].Url);
          });
        }
      }, function (m) {
        alert('Error: ' + m.toString() + '.<br/>');
      });
    }

  </script>

<h3>LEARN</h3>
<form>
  <fieldset>
    <div class="clearfix">
      <select class="span6" name="normalSelect" id="loList1"></select>
      <button class="btn primary" id="goButton">Learn</button>
      <span class="help-block">Navigate to a learning object.</span>
    </div>
  </fieldset>
</form>
<form>
  <fieldset>
    <div class="clearfix">
      <input class="span6" id="" name="" type="text" placeholder="Search" /><button class="btn primary">Search</button>
      <span class="help-block">Search for learning objects by keywords.</span>
    </div>
  </fieldset>
</form>

<h3>MISSION</h3>
<p>OpenRLO aims to provide an open social based learning platform.</p>
<p>Knowledge is socially constructed through dialogue and interaction with others [Berger, P. (1966). The Social Construction of Reality. Anchor Books. ISBN 0385058985].</p>
<br />  
<br />

</asp:Content>