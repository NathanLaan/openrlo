﻿<%@ Page Language="C#" MasterPageFile="~/SiteMobile.Master" AutoEventWireup="true" CodeBehind="ManageContent.aspx.cs" Inherits="OpenRLO.Web.ManageContent" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageNameContent" runat="server">Manage Content</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="TaglineContent" runat="server"></asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="bodyContentPlaceHolder" runat="server">
  <form runat="server">
    <asp:ScriptManager runat="server" ID="masterPageScriptManager" AsyncPostBackErrorMessage="timeout" AsyncPostBackTimeout="300">
      <Services>
        <asp:ServiceReference Path="~/Service/SiteUserService.asmx" />
        <asp:ServiceReference Path="~/Service/LearningObjectService.asmx" />
        <asp:ServiceReference Path="~/Service/PageService.asmx" />
      </Services>
    </asp:ScriptManager>
  </form>

  <!-- LearningObject -->
  <div id="LearningObject-modal" class="modal hide fade">
    <div class="modal-header">
      <a href="#" class="close">&times;</a>
      <h3>Manage LearningObjects</h3>
    </div>
    <div class="modal-body">
      <form>
        <fieldset>
          <input class="span6" id="loTitle" type="text" placeholder="Learning Object Title" /><a href="#" class="btn" id="addLearningObject">Add LearningObject</a><br />
          <select class="span6" name="mediumSelect" id="loList1"></select><a href="#" class="btn danger" id="deleteLearningObject">Delete LearningObject</a>
          <br />TODO: Tags
        </fieldset>
      </form>
    </div>
    <!--<div class="modal-footer"><a href="#" class="btn primary">Done</a></div>-->
  </div>
  <!-- /LearningObject -->


  <button data-controls-modal="LearningObject-modal" data-backdrop="true" data-keyboard="true" class="btn">Manage Learning Objects</button>
  <br />
  <br />

  <h2>Content Pages</h2>
  <form>
    <fieldset>
      <!--<legend>Example form legend</legend>-->
      <div class="clearfix">
        <label for="loList2">LearningObject:</label>
        <div class="input">
          <select class="span6" name="mediumSelect" id="loList2"></select>
        </div>
      </div>
      <div class="clearfix">
        <label for="contentLearningObjectList">Page Title:</label>
        <div class="input">
          <input class="span6" id="pageTitle" type="text" placeholder="Page Title (used for sorting)" />
          <a href="#" class="btn success" id="addPage">Add Page</a><br />
        </div>
      </div>
      <div class="clearfix">
        <label for="pageContent">Page Contents:</label>
        <div class="input">
          <textarea class="xxlarge" id="pageContent" name="pageContent" rows="10"></textarea>
          <span class="help-block">Block of help text to describe the field above if need be.</span>
        </div>
      </div>
      <div class="clearfix">
        <div class="input">
          
        </div>
      </div><!-- /clearfix -->
      <br />
      <br />
      <div class="clearfix">
        <label for="pageList">Pages</label>
        <div class="input">
          <select class="span6" size="5" multiple="multiple" name="pageList" id="pageList">
          </select>
          <br />
          <a href="#" class="btn" id="movePageUp">Move Up</a>
          <a href="#" class="btn" id="movePageDown">Move Down</a>
          <a href="#" class="btn danger" id="deletePage">Delete Content Page</a>
        </div>
      </div><!-- /clearfix -->
    </fieldset>
  </form>
  <br /><br />

  <script language="javascript" type="text/javascript">

    $(document).ready(function () {
      loadLearningObjectList();
      $('#addLearningObject').click(function () {
        addLearningObject();
      });
      $('#deleteLearningObject').click(function () {
        deleteLearningObject();
      });
      $('#loList2').change(function () {
        loadPages($(this).attr('value'));
      });
      $('#addPage').click(function () {
        addPage();
      });
    });

    function addPage() {
      var learningObjectUrl = $('#loList2').val();
      var pageTitle = $('#pageTitle').val();
      var pageContent = $('#pageContent').val();

      alert('addPage(): ' + learningObjectUrl + " : " + pageTitle + " : " + pageContent);

      OpenRLO.Web.Service.PageService.Add(learningObjectUrl, pageTitle, pageContent, function (a) {
        loadPages(learningObjectUrl);
      }, function (m) {
        alert('Error: ' + m.toString() + '.<br/>');
      });
    }

    function loadPages(learningObjectUrl) {
      //alert('loadPages: ' + learningObjectUrl);
      // Get pages for LearningObjectURL
      OpenRLO.Web.Service.PageService.GetList(learningObjectUrl, function (a) {
        if (a != null) {
          var pageList = $('#pageList')[0];
          pageList.options.length = 0;
          $.each(a, function () {
            var i = pageList.options.length;
            pageList.options[i] = new Option(a[i].Title, a[i].Url);
          });
        }
      }, function (m) {
        alert('ERROR: Unable to load pages for [' + learningObjectUrl + ']');
      });
    }

    function loadLearningObjectList() {
      OpenRLO.Web.Service.LearningObjectService.GetList(function (a) {
        if (a != null) {
          var listControl1 = $('#loList1')[0];
          var listControl2 = $('#loList2')[0];
          listControl1.options.length = 0;
          listControl2.options.length = 0;
          $.each(a, function () {
            var i = listControl1.options.length;
            //listControl1.options[i] = new Option(a[i].Title + " [" + a[i].Url + "]", a[i].Title);
            //listControl2.options[i] = new Option(a[i].Title + " [" + a[i].Url + "]", a[i].Title);
            listControl1.options[i] = new Option(a[i].Title, a[i].Url);
            listControl2.options[i] = new Option(a[i].Title, a[i].Url);
          });
          loadPages($('#loList2').val());
        }
      }, function (m) {
        alert('Error: ' + m.toString() + '.<br/>');
      });
    }

    function addLearningObject() {
      var loTitle = $('#loTitle').val();
      OpenRLO.Web.Service.LearningObjectService.Add(loTitle, function (a) {
        loadLearningObjectList();
      }, function (m) {
        alert('Error: ' + m.toString() + '.<br/>');
      });
    }

    function deleteLearningObject() {
      var listControl = $('#loList1').get(0);
      if (listControl.selectedIndex >= 0) {
        var elem = listControl.options[listControl.selectedIndex];
        var text = elem.value;
        if (confirm('Delete ' + text + '?')) {
          OpenRLO.Web.Service.LearningObjectService.DeleteByUrl(text, function (s) {
            loadLearningObjectList();
          }, function (m) {
            alert('Error: ' + m.toString());
          });
        }
      } else {
        $('div#output').html('Please select a Learning Object from the list to delete.<br/>');
        alert('Please select a user from the list to delete');
      }
    }

  </script>

</asp:Content>