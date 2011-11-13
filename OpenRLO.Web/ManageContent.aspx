﻿<%@ Page Language="C#" MasterPageFile="~/SiteMobile.Master" AutoEventWireup="true" CodeBehind="ManageContent.aspx.cs" Inherits="OpenRLO.Web.ManageContent" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageNameContent" runat="server">Manage Content</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="TaglineContent" runat="server"></asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="bodyContentPlaceHolder" runat="server">
  <form runat="server">
  <asp:ScriptManager runat="server" ID="masterPageScriptManager" AsyncPostBackErrorMessage="timeout" AsyncPostBackTimeout="300">
    <Services>
      <asp:ServiceReference Path="~/Service/SiteUserService.asmx" />
      <asp:ServiceReference Path="~/Service/SubjectService.asmx" />
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
      <form action="">
        <fieldset>
          <div class="clearfix">
            <input class="span3" id="subjectTitle" name="" type="text" placeholder="New Subject" /><a href="#" class="btn success" id="addSubject">Add Subject</a>
            <select class="medium" name="mediumSelect" id="subjectList"></select><a href="#" class="btn danger" id="deleteSubject">Delete Subject</a>
          </div><!-- /clearfix -->
        </fieldset>
      </form>
    </div>
    <!--
    <div class="modal-footer">
      <a href="#" class="btn primary">OK</a>
    </div>
    -->
  </div>



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
      alert('deleteSubject()');
    }

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

  <h2>Subjects</h2>
  <button data-controls-modal="subject-modal" data-backdrop="true" data-keyboard="true" class="btn">Manage Subjects</button>
</asp:Content>