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


  <!--

  If we want a single dialog, then the add() or edit() function to show the dialog
  needs to
  (1) set the text of the header and buttons
  (2) remove existing events from buttons
  (3) add new events to buttons
  (4) show the dialog

  -->
  

  <div id="modalUserAdd" class="modal hide fade">
    <div class="modal-header">
      <a href="#" class="close close-modal">&times;</a>
      <h3>Add User</h3>
    </div>
    <div class="modal-body">
      <form class="form-stacked">
        <div class="clearfix">
          <label for="txtUsername">Username</label><input class="span6" id="txtUsername" type="text" placeholder="Username" onkeyup="GenerateUsername();" />
          <br /><br /><label for="txtPassword1">Password</label><input class="span6" id="txtPassword1" type="password" placeholder="Password" />
          <br /><br /><label for="txtPassword2">Confirm Password</label><input class="span6" id="txtPassword2" type="password" placeholder="Confirm Password" />
          <br /><br /><label for="txtEmail">Email</label><input class="span6" id="txtEmail" type="text" placeholder="Password" />
          <br /><br /><label for="chkIsAdministrator">Administrator</label><input type="checkbox" id="chkIsAdministrator" />&nbsp;User can administer other users
          <br /><br /><label for="chkIsContentEditor">Content Editor</label><input type="checkbox" id="chkIsContentEditor" />&nbsp;User can create & edit content
        </div>
      </form>
    </div>
    <div class="modal-footer"><a href="#" id="btnModalUserAdd" class="btn primary">Add User</a><a href="#" id="btnModalUserAddCancel" class="btn">Cancel</a></div>
  </div>

  <div id="modalUserEdit" class="modal hide fade">
    <div class="modal-header">
      <a href="#" class="close close-modal">&times;</a>
      <h3>Edit User</h3>
    </div>
    <div class="modal-body">
    </div>
    <div class="modal-footer"><a href="#" id="btnModalUserEditSave" class="btn primary">Save</a><a href="#" id="btnModalUserEditCancel" class="btn">Cancel</a></div>
  </div>


  <!-- ------- ---- ------- -->
  <!-- ------- TABS ------- -->


  <ul class="tabs" data-tabs="tabs">
    <li class="active"><a href="#tabRLO">RLOs</a></li>
    <li><a href="#tabAddPage">Add Page</a></li>
    <li><a href="#tabPages">Edit Pages</a></li>
    <li class="disabled"><a href="#tabUsers">Users</a></li>
  </ul>

  <!-- tabs -->
  <div class="pill-content">

  <div id="tabUsers">
    <form class="form-stacked">
      <div class="clearfix">
        <label for="lstUsers">Users</label>
        <select class="span6" id="lstUsers"></select>
        <br />
        <br />
        <a href="#" data-controls-modal="modalUserAdd" data-backdrop="true" data-keyboard="true" class="btn" id="btnEditUser">Add</a>
        <a href="#" data-controls-modal="modalUserEdit" data-backdrop="true" data-keyboard="true" class="btn" id="A1">Edit</a>
        <a href="#" class="btn danger" id="btnDeleteUser">Delete</a>
      </div>
    </form>
  </div>

    <!-- tabLearningObjects -->
    <div class="active" id="tabRLO">
      <form class="form-stacked">
        <div class="clearfix">
          <label for="loTitle">Title</label>
          <input class="span6" id="loTitle" type="text" placeholder="Learning Object Title" />
          <br />
          <br />
          <a href="#" class="btn" id="addLearningObject">Add</a><br />
        </div>
        <br />
        <br />
        <div class="clearfix">
          <label for="lstRLO1">Learning Objects</label>
          <select class="span6" id="lstRLO1"></select>
          <br />
          <br />
          <a href="#" data-controls-modal="editLearningObjectModal" data-backdrop="true" data-keyboard="true" class="btn" id="btnEditLearningObject">Edit</a>
          <a href="#" class="btn danger" id="deleteLearningObject">Delete</a>
        </div>
      </form>
    </div>
    <!-- tabLearningObjects -->

    <div id="tabAddPage">
      <form class="form-stacked">
        <div class="clearfix">
          <label for="loTitle">Learning Objects</label>
          <select class="span6" id="lstRLO2"></select>
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
          <select class="span6" id="lstRLO3"></select>
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

      $('#tabUsers').attr('enabled', 'false');

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
      $('#lstRLO3').change(function () {
        loadPages($(this).attr('value'));
      });
      $('#addPage').click(function () {
        addPage();
      });

      // Page
      $('#btnEditPage').click(function () {
        editPage();
      });
      $('#btnEditPageSave').click(function () {
        saveEditPage();
      });
      $('#btnEditPageCancel').click(function () {
        cancelEditPage();
      });

      // RLO
      $('#btnEditLearningObject').click(function () {
        editLearningObject();
      });
      $('#btnEditLearningObjectSave').click(function () {
        saveEditLearningObject();
      });
      $('#btnEditLearningObjectCancel').click(function () {
        cancelEditLearningObject();
      });

      // User
      $('#btnModalUserAddCancel').click(function () {
        $('#modalUserAdd').modal('hide');
      });
      $('#btnModalUserEditCancel').click(function () {
        $('#modalUserEdit').modal('hide');
      });

    });



    function AddUser() {
      var usr = new OpenRLO.Web.Data.SiteUser();
      usr.Username = $('#txtUsername').val();
      usr.Passcode = $('#txtPassword1').val();
      usr.TimeZone = $('#txtTimezone').val();
      usr.Email = $('#txtEmail').val();
      OpenRLO.Web.Service.SiteUserService.Exists(usr.Username, usr.Showname, function (b) {
        if (b) {
          alert('User account already exists');
        } else {
          if ($('#txtPassword1').val() != $('#txtPassword2').val()) {
            alert('Passwords do not match.<br/>');
          } else {
            OpenRLO.Web.Service.SiteUserService.Add(usr, function () {
              $('div#output').html('User added.<br/>');
              ClearFields();
              LoadList();
            }, function (m) {
              $('div#output').html('Error: ' + m.toString() + '.<br/>');
              LoadList();
            });
          }
        }
      }, function (m) {
        $('div#output').html('Error: ' + m.toString() + '.<br/>');
      });
    }`


    function editLearningObject() {
      var learningObjectUrl = $('#lstRLO1').val();
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
      var learningObjectUrl = $('#lstRLO1').val();
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
      var learningObjectUrl = $('#lstRLO2').val();
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
      var learningObjectUrl = $('#lstRLO3').val();
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
      var learningObjectUrl = $('#lstRLO3').val();
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
      var learningObjectUrl = $('#lstRLO3').val();
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
      var learningObjectUrl = $('#lstRLO3').val();
      var pageUrl = $('#pageList').val();
      OpenRLO.Web.Service.PageService.MovePageUp(learningObjectUrl, pageUrl, function (a) {
        loadPages(learningObjectUrl);
        alert(a);
      }, function (m) {
        alert('Error: Unable to move page [' + pageUrl + ']');
      });
    }

    function movePageDown() {
      var learningObjectUrl = $('#lstRLO3').val();
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
            pageList.options[i] = new Option((i + 1) + ": " + a[i].Title, a[i].Url);
          });
        }
      }, function (m) {
        alert('Error: Unable to load pages for [' + learningObjectUrl + ']');
      });
    }

    function loadLearningObjectList() {
      OpenRLO.Web.Service.LearningObjectService.GetList(function (a) {
        if (a != null) {
          var listControl1 = $('#lstRLO1')[0];
          var listControl2 = $('#lstRLO2')[0];
          var listControl3 = $('#lstRLO3')[0];
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
          loadPages($('#lstRLO3').val());
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
      var listControl = $('#lstRLO1').get(0);
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