<%@ Page Language="C#" MasterPageFile="~/SiteMobile.Master" AutoEventWireup="true" CodeBehind="ManageContent.aspx.cs" Inherits="OpenRLO.Web.ManageContent" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageNameContent" runat="server">Manage Content</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="TaglineContent" runat="server"></asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="bodyContentPlaceHolder" runat="server">
  <form runat="server">
  <asp:ScriptManager runat="server" ID="masterPageScriptManager" AsyncPostBackErrorMessage="timeout" AsyncPostBackTimeout="300">
    <Services>
      <asp:ServiceReference Path="~/Service/SiteUserService.asmx" />
      <asp:ServiceReference Path="~/Service/SubjectService.asmx" />
      <asp:ServiceReference Path="~/Service/TopicService.asmx" />
    </Services>
  </asp:ScriptManager>
  </form>

  <!-- SUBJECT -->
  <div id="subject-modal" class="modal hide fade">
    <div class="modal-header">
      <a href="#" class="close">&times;</a>
      <h3>Manage Subjects</h3>
    </div>
    <div class="modal-body">
      <form>
        <fieldset>
    <input class="span3" id="subjectTitle" type="text" placeholder="New Subject" /><a href="#" class="btn" id="addSubject">Add</a>
    <select class="medium" name="mediumSelect" id="subjectList"></select><a href="#" class="btn danger" id="deleteSubject">Delete</a>
        </fieldset>
      </form>
    </div>
    <!--
    <div class="modal-footer">
      <a href="#" class="btn primary">OK</a>
    </div>
    -->
  </div>
  <!-- /SUBJECT -->

  <!-- TOPIC -->
  <div id="topic-modal" class="modal hide fade">
    <div class="modal-header">
      <a href="#" class="close">&times;</a>
      <h3>Manage Topics</h3>
    </div>
    <div class="modal-body">
      <form>
        <fieldset>
    <select class="medium" name="mediumSelect" id="topicSubjectList"></select><input class="span3" id="topicTitle" type="text" placeholder="New Subject" /><a href="#" class="btn success" id="a1">Add Topic</a>
    <select class="medium" name="mediumSelect" id="topicList"></select><a href="#" class="btn danger" id="A2">Delete Topic</a>
        </fieldset>
      </form>
    </div>
    <!--
    <div class="modal-footer">
      <a href="#" class="btn primary">OK</a>
    </div>
    -->
  </div>
  <!-- /TOPIC -->



  <script language="javascript" type="text/javascript">

    $(document).ready(function () {
      LoadSubjectList();
      $('#addSubject').click(function () {
        addSubject();
      });
      $('#deleteSubject').click(function () {
        deleteSubject();
      });
    });

    function addSubject() {
      var subject = $('#subjectTitle').val()
      OpenRLO.Web.Service.SubjectService.Add(subject, function (a) {
        LoadSubjectList();
      }, function (m) {
        alert('Error: ' + m.toString() + '.<br/>');
      });
    }

    function deleteSubject() {
      var listControl = $('#subjectList').get(0);
      if (listControl.selectedIndex >= 0) {
        var elem = listControl.options[listControl.selectedIndex];
        var text = elem.value;
        if (confirm('Delete ' + text + '?')) {
          OpenRLO.Web.Service.SiteUserService.Delete(text, function (s) {
            LoadSubjectList();
          }, function (m) {
            alert('Error: ' + m.toString());
          });
        }
      } else {
        $('div#output').html('Please select a user from the list to delete.<br/>');
        alert('Please select a user from the list to delete');
      }
    }

    function LoadSubjectList() {
      OpenRLO.Web.Service.SubjectService.GetList(function (a) {
        if (a != null) {
          var listControl1 = $('#subjectList')[0];
          var listControl2 = $('#topicSubjectList')[0];
          listControl1.options.length = 0;
          listControl2.options.length = 0;
          $.each(a, function () {
            var i = listControl1.options.length;
            listControl1.options[i] = new Option(a[i].Title + " [" + a[i].Url + "]", a[i].Title);
            listControl2.options[i] = new Option(a[i].Title + " [" + a[i].Url + "]", a[i].Title);
          });
        }
      }, function (m) {
        alert('Error: ' + m.toString() + '.<br/>');
      });
    }

    function LoadTopicList() {
      OpenRLO.Web.Service.SubjectService.GetList(function (a) {
        if (a != null) {
          var listControl1 = $('#subjectList')[0];
          var listControl2 = $('#topicSubjectList')[0];
          listControl1.options.length = 0;
          listControl2.options.length = 0;
          $.each(a, function () {
            var i = listControl1.options.length;
            listControl1.options[i] = new Option(a[i].Title + " [" + a[i].Url + "]", a[i].Title);
            listControl2.options[i] = new Option(a[i].Title + " [" + a[i].Url + "]", a[i].Title);
          });
        }
      }, function (m) {
        alert('Error: ' + m.toString() + '.<br/>');
      });
    }

  </script>

  <h2>Content Pages</h2>
  <div class="clearfix">
    <select class="medium" name="mediumSelect" id="contentTopicList"></select><br />
    TEXTAREA<br />
    <a href="#" class="btn success" id="a3">Add Content</a><br />
    <select class="medium" name="mediumSelect" id="contentList"></select><a href="#" class="btn danger" id="A4">Delete Content Page</a>
  </div>
  <br /><br />

  <h2>Manage ...</h2>
  <button data-controls-modal="subject-modal" data-backdrop="true" data-keyboard="true" class="btn">Manage Subjects</button>
  <button data-controls-modal="topic-modal" data-backdrop="true" data-keyboard="true" class="btn">Manage Topics</button>

</asp:Content>