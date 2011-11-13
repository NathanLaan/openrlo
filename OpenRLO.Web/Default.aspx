<%@ Page Language="C#" MasterPageFile="~/SiteMobile.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="OpenRLO.Web.Default" %>
<%@ OutputCache Duration="2400" VaryByParam="*"  %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageNameContent" runat="server">Open Social Learning</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="TaglineContent" runat="server"></asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="bodyContentPlaceHolder" runat="server">
  <form id="Form1" runat="server">
  <asp:ScriptManager runat="server" ID="masterPageScriptManager" AsyncPostBackErrorMessage="timeout" AsyncPostBackTimeout="300">
    <Services>
      <asp:ServiceReference Path="~/Service/SiteUserService.asmx" />
      <asp:ServiceReference Path="~/Service/SubjectService.asmx" />
    </Services>
  </asp:ScriptManager>
  </form>

<h3>LEARN</h3>
<p>Explore the learning objects by subject:</p>
<form action="">
  <fieldset>
    <div class="clearfix">
      <select class="span3" name="normalSelect" id="subjectList">
      </select>
      <button class="btn primary">GO</button>
    </div><!-- /clearfix -->
  </fieldset>
</form>
<p>Search for learning objects by keywords:</p>
<form action="">
  <fieldset>
    <div class="clearfix"><input class="span3" id="" name="" type="text" placeholder="Search" /><button class="btn primary">Search</button></div>
  </fieldset>
</form>
<h3>MISSION</h3>
<p>Knowledge is socially constructed through dialoge and interaction with others [Berger, P. (1966). The Social Construction of Reality. Anchor Books. ISBN 0385058985].</p>
<p>OpenRLO aims to provide an open social based learning platform.</p>
<br />  
<br />


  <script language="javascript" type="text/javascript">

    $(document).ready(function () {
      LoadSubjectList();
    });

    function LoadSubjectList() {
      OpenRLO.Web.Service.SubjectService.GetList(function (a) {
        if (a != null) {
          var listControl = $('#subjectList')[0];
          listControl.options.length = 0;
          $.each(a, function () {
            var i = listControl.options.length;
            listControl.options[i] = new Option(a[i].Title + " [" + a[i].Url + "]", a[i].Title);
          });
        }
      }, function (m) {
        $('div#output').html('Error: ' + m.toString() + '.<br/>');
      });
    }

  </script>

<br />  
<br />
</asp:Content>