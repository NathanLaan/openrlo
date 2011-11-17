<%@ Page Language="C#" MasterPageFile="~/SiteMobile.Master" AutoEventWireup="true" CodeBehind="ManageContent.aspx.cs" Inherits="OpenRLO.Web.ManageContent" %>

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
      <a href="#" class="close close-modal">&times;</a>
      <h3>Manage LearningObjects</h3>
    </div>
    <div class="modal-body">
      <form>
        <fieldset>
        </fieldset>
      </form>
      <br />
      <br />
    </div>
    <!--<div class="modal-footer"><a href="#" class="btn primary">Done</a></div>-->
  </div>
  <!-- /LearningObject -->

  <!--<button data-controls-modal="LearningObject-modal" data-backdrop="true" data-keyboard="true" class="btn">Manage Learning Objects</button>
  <br />
  <br />
  -->

  <ul class="tabs">
    <li class="active"><a href="#tabAddLearningObject">Add Learning Object</a></li>
    <li><a href="#tabEditLearningObjects">Edit Learning Objects</a></li>
    <li><a href="#tabAddPage">Add Page</a></li>
    <li><a href="#tabPages">Edit Pages</a></li>
  </ul>

  <!-- tabs -->
  <div class="pill-content">

    <!-- tabLearningObjects -->
    <div class="active" id="tabAddLearningObject">
      <form class="form-stacked">
        <div class="clearfix">
          <!--<h3>Learning Objects</h3>-->
          <label for="loTitle">Learning Object Title</label>
          <div class="input">
            <input class="span6" id="loTitle" type="text" placeholder="Learning Object Title" />
            <br />
            <br />
            <a href="#" class="btn" id="addLearningObject">Add</a><br />
          </div>
        </div>
      </form>
    </div>
    <!-- tabLearningObjects -->

    <!-- tabEditLearningObjects -->
    <div id="tabEditLearningObjects">
      <form class="form-stacked">
        <div class="clearfix">
          <label for="loList1">Learning Objects</label>
          <select class="span6" id="loList1"></select>
          <br />
          <br />
          <a href="#" class="btn" rel="popover" title="Edit Learning Object" data-content="Edit the selected Learning Object." id="A1">Edit</a>
          <a href="#" class="btn danger" rel="popover" title="Delete Learning Object" data-content="Permanently delete the selected Learning Object." id="deleteLearningObject">Delete</a>
        </div>
      </form>
    </div>

    <div id="tabAddPage">
      <form class="form-stacked">
        <div class="clearfix">
          <label for="loTitle">Learning Object</label>
          <select class="span6" id="loList2"></select>
          <br />
          <br />
          <label for="pageTitle">Page Title</label>
          <input class="span6" id="pageTitle" type="text" placeholder="Page Title (used for sorting)" />
          <br />
          <br />
          <label for="pageContent">Page Content</label>
          <textarea class="xxlarge" id="pageContent" name="pageContent" rows="10"></textarea>
          <br />
          <br />
          <a href="#" class="btn" id="addPage">Add</a>
        </div>
      </form>
    </div>
     
    <div id="tabPages">
      <form class="form-stacked">
        <!--<h3>Manage Learning Object Pages</h3>-->
        <div class="clearfix">
          <label for="loTitle">Learning Object</label>
          <select class="span6" id="loList3"></select>
          <br />
          <br />
          <label for="loTitle">Pages</label>
          <select class="span6" id="pageList"></select>
          <br />
          <br />
          <a href="#" class="btn" id="movePageUp">Move Up</a>
          <a href="#" class="btn" id="movePageDown">Move Down</a>
          <a href="#" class="btn" id="btnEditPage">Edit</a>
          <a href="#" class="btn danger" id="deletePage">Delete</a>
        </div>
      </form>
    </div>

  </div>
  <!-- tabs -->
  
  <script language="javascript" type="text/javascript">


    $(document).ready(function () {
      $("a[rel=popover]").popover({ offset: 10 }).click(function (e) {
        e.preventDefault();
      });
      $('.tabs').tabs();
      loadLearningObjectList();
      $('#addLearningObject').click(function () {
        addLearningObject();
      });
      $('#movePageUp').click(function () {
        movePageUp();
      });
      $('#movePageDown').click(function () {
        movePageDown();
      });
      $('#deletePage').click(function () {
        deletePage();
      });
      $('#deleteLearningObject').click(function () {
        deletePage();
      });
      $('#loList3').change(function () {
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

      OpenRLO.Web.Service.PageService.Add(learningObjectUrl, pageTitle, pageContent, function (a) {
        loadPages(learningObjectUrl);
        alert(a);
      }, function (m) {
        alert('Error: Unable to add page [' + pageTitle + ']');
      });
    }

    function deletePage() {
      var learningObjectUrl = $('#loList3').val();
      var pageUrl = $('#pageList').val();

      if (confirm('Delete ' + pageUrl + ' from ' + learningObjectUrl + '?')) {
        OpenRLO.Web.Service.PageService.DeleteByUrl(learningObjectUrl, pageUrl, function (a) {
          loadPages(learningObjectUrl);
          alert(a);
        }, function (m) {
          alert('Error: Unable to delete page [' + pageUrl + ']');
        });
      }
    }

    function movePageUp() {
      var learningObjectUrl = $('#loList3').val();
      var pageUrl = $('#pageList').val();
      OpenRLO.Web.Service.PageService.MovePageUp(learningObjectUrl, pageUrl, function (a) {
        loadPages(learningObjectUrl);
        alert(a);
      }, function (m) {
        alert('Error: Unable to move page [' + pageUrl + ']');
      });
    }

    function movePageDown() {
      var learningObjectUrl = $('#loList3').val();
      var pageUrl = $('#pageList').val();
      OpenRLO.Web.Service.PageService.MovePageDown(learningObjectUrl, pageUrl, function (a) {
        loadPages(learningObjectUrl);
        alert(a);
      }, function (m) {
        alert('Error: Unable to move page [' + pageUrl + ']');
      });
    }

    function loadPages(learningObjectUrl) {
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
        alert('Error: Unable to load pages for [' + learningObjectUrl + ']');
      });
    }

    function loadLearningObjectList() {
      OpenRLO.Web.Service.LearningObjectService.GetList(function (a) {
        if (a != null) {
          var listControl1 = $('#loList1')[0];
          var listControl2 = $('#loList2')[0];
          var listControl3 = $('#loList3')[0];
          listControl1.options.length = 0;
          listControl2.options.length = 0;
          listControl3.options.length = 0;
          $.each(a, function () {
            var i = listControl1.options.length;
            //listControl1.options[i] = new Option(a[i].Title + " [" + a[i].Url + "]", a[i].Title);
            //listControl2.options[i] = new Option(a[i].Title + " [" + a[i].Url + "]", a[i].Title);
            listControl1.options[i] = new Option(a[i].Title, a[i].Url);
            listControl2.options[i] = new Option(a[i].Title, a[i].Url);
            listControl3.options[i] = new Option(a[i].Title, a[i].Url);
          });
          loadPages($('#loList3').val());
        }
      }, function (m) {
        alert('Error: Unable to load Learning Object list.');
      });
    }

    function addLearningObject() {
      var loTitle = $('#loTitle').val();
      OpenRLO.Web.Service.LearningObjectService.Add(loTitle, function (a) {
        loadLearningObjectList();
        alert(a);
      }, function (m) {
        alert('Error: Unable to add Learning Object [' + loTitle + ']');
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
            alert('Error: Unable to delete [' + text + ']');
          });
        }
      } else {
        alert('Please select a user from the list to delete');
      }
    }

  </script>

</asp:Content>