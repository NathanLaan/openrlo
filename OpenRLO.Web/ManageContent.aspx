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

  <!-- LearningObjectModal -->
  <div id="editLearningObjectModal" class="modal hide fade">
    <div class="modal-header">
      <a href="#" class="close close-modal">&times;</a>
      <h3>Edit Learning Object</h3>
    </div>
    <div class="modal-body">
      <form class="form-stacked">
        <div class="clearfix">
          <label for="editLearningObjectTitle">Title</label>
          <input class="span6" id="editLearningObjectTitle" type="text" />
        </div>
      </form>
      <br />
      <br />
    </div>
    <div class="modal-footer"><a href="#" id="btnEditLearningObjectSave" class="btn primary">Save</a><a href="#" id="btnEditLearningObjectCancel" class="btn">Cancel</a></div>
  </div>
  <!-- LearningObjectModal -->

  <!-- PageModal -->
  <div id="editPageModal" class="modal hide fade">
    <div class="modal-header">
      <a href="#" class="close close-modal">&times;</a>
      <h3>Edit Page</h3>
    </div>
    <div class="modal-body">
      <form class="form-stacked">
        <div class="clearfix">
          <label for="txtEditPageTitle">Title</label>
          <input class="span6" id="txtEditPageTitle" type="text" />
          <br />
          <br />
          <label for="txtEditPageContents">Content</label>
          <textarea class="xxlarge" id="txtEditPageContents" name="pageContent" rows="10"></textarea>
          <span class="help-block"><strong>Note:</strong> Page content is formatted using <a href="http://daringfireball.net/projects/markdown/" target="_blank">MARKDOWN</a>.</span>
        </div>
      </form>
      <br />
      <br />
    </div>
    <div class="modal-footer"><a href="#" id="btnEditPageSave" class="btn primary">Save</a><a href="#" id="btnEditPageCancel" class="btn">Cancel</a></div>
  </div>
  <!-- PageModal -->

  <ul class="tabs">
    <li class="active"><a href="#tabAddLearningObject">Add RLO</a></li>
    <li><a href="#tabEditLearningObjects">Edit RLOs</a></li>
    <li><a href="#tabAddPage">Add Page</a></li>
    <li><a href="#tabPages">Edit Pages</a></li>
  </ul>

  <!-- tabs -->
  <div class="pill-content">

    <!-- tabLearningObjects -->
    <div class="active" id="tabAddLearningObject">
      <form class="form-stacked">
        <div class="clearfix">
          <label for="loTitle">Title</label>
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
          <a href="#" data-controls-modal="editLearningObjectModal" data-backdrop="true" data-keyboard="true" class="btn" rel="popover" title="Edit Learning Object" data-content="Edit the selected Learning Object." id="btnEditLearningObject">Edit</a>
          <a href="#" class="btn danger" rel="popover" title="Delete Learning Object" data-content="Permanently delete the selected Learning Object." id="deleteLearningObject">Delete</a>
        </div>
      </form>
    </div>

    <div id="tabAddPage">
      <form class="form-stacked">
        <div class="clearfix">
          <label for="loTitle">Learning Objects</label>
          <select class="span6" id="loList2"></select>
          <br />
          <br />
          <label for="pageTitle">Title</label>
          <input class="span6" id="pageTitle" type="text" placeholder="Page Title (used for sorting)" />
          <br />
          <br />
          <label for="pageContent">Content</label>
          <textarea class="xxlarge" id="pageContent" name="pageContent" rows="10"></textarea>
          <span class="help-block"><strong>Note:</strong> Page content is formatted using <a href="http://daringfireball.net/projects/markdown/" target="_blank">MARKDOWN</a>.</span>
          <br />
          <br />
          <a href="#" class="btn" id="addPage">Add</a>
        </div>
      </form>
    </div>
     
    <div id="tabPages">
      <form class="form-stacked">
        <div class="clearfix">
          <label for="loTitle">Learning Objects</label>
          <select class="span6" id="loList3"></select>
          <br />
          <br />
          <label for="loTitle">Pages</label>
          <select class="span6" id="pageList"></select>
          <br />
          <br />
          <a href="#" class="btn" id="movePageUp">Move Up</a>
          <a href="#" class="btn" id="movePageDown">Move Down</a>
          <a href="#" data-controls-modal="editPageModal" data-backdrop="true" data-keyboard="true" class="btn" id="btnEditPage">Edit</a>
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

      $('#btnEditPage').click(function () {
        editPage();
      });
      $('#btnEditPageSave').click(function () {
        saveEditPage();
      });
      $('#btnEditPageCancel').click(function () {
        cancelEditPage();
      });

      $('#btnEditLearningObject').click(function () {
        editLearningObject();
      });
      $('#btnEditLearningObjectSave').click(function () {
        saveEditLearningObject();
      });
      $('#btnEditLearningObjectCancel').click(function () {
        cancelEditLearningObject();
      });
    });

    function editLearningObject() {
      var learningObjectUrl = $('#loList1').val();
      OpenRLO.Web.Service.LearningObjectService.GetByUrl(learningObjectUrl, function (lo) {
        if (lo != null) {
          $('#editLearningObjectTitle').val(lo.Title);
        } else {
          //
          //TODO: Error handling
          //
          $('#editLearningObjectTitle').val("Invalid Learning Object");
        }
      }, function (m) {
        $('#pageContent').html("Error loading page contents");
      });
    }
    function saveEditLearningObject() {
      var learningObjectUrl = $('#loList1').val();
      var newLearningObjectTitle = $('#editLearningObjectTitle').val();

      OpenRLO.Web.Service.LearningObjectService.Edit(learningObjectUrl, newLearningObjectTitle, function (a) {
        loadLearningObjectList();
        alert(a);
      }, function (m) {
        $('#pageContent').html("Error loading page contents");
      });

      $('#editLearningObjectModal').modal('hide');
    }
    function cancelEditLearningObject() {
      $('#editLearningObjectModal').modal('hide');
    }

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

    function editPage() {
      var learningObjectUrl = $('#loList3').val();
      var pageUrl = $('#pageList').val();
      OpenRLO.Web.Service.PageService.GetByUrl(learningObjectUrl, pageUrl, function (page) {
        if (page != null) {
          $('#txtEditPageTitle').val(page.Title);
          $('#txtEditPageContents').val(page.Contents);
        } else {
          //
          //TODO: Error handling
          //
          $('#txtEditPageTitle').val("Invalid page contents");
          $('#txtEditPageContents').val("Invalid page contents");
        }
      }, function (m) {
        $('#pageContent').html("Error loading page contents");
      });
    }

    function saveEditPage() {
      var learningObjectUrl = $('#loList3').val();
      var oldPageUrl = $('#pageList').val();
      var newPageTitle = $('#txtEditPageTitle').val();
      var newPageContents = $('#txtEditPageContents').val();

      //
      // TODO: It would be nice to disable everything while we are saving...
      //

      OpenRLO.Web.Service.PageService.Edit(learningObjectUrl, oldPageUrl, newPageTitle, newPageContents, function (a) {
        loadPages(learningObjectUrl);
        alert(a);
      }, function (m) {
        $('#pageContent').html("Error loading page contents");
      });

      $('#editPageModal').modal('hide');
    }

    function cancelEditPage() {
      $('#editPageModal').modal('hide');
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