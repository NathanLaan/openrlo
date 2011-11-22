<%@ Page Language="C#" MasterPageFile="~/SiteMobile.Master" AutoEventWireup="true" CodeBehind="ManageSite.aspx.cs" Inherits="OpenRLO.Web.ManageSite" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageNameContent" runat="server">Manage Website</asp:Content>
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

  <!-- modalRLO -->
  <div id="modalRLO" class="modal hide fade">
    <div class="modal-header">
      <a href="#" class="close close-modal">&times;</a>
      <h3 id="modalRLOTitle">Add RLO</h3>
    </div>
    <div class="modal-body">
      <form class="form-stacked">
        <div class="clearfix">
          <label for="txtRLOTitle">Title</label>
          <input class="span6" id="txtModalRLOTitle" type="text" />
        </div>
      </form>
      <br />
      <br />
    </div>
    <div class="modal-footer"><a href="#" id="btnModalRLOConfirm" class="btn primary">Add</a><a href="#" id="btnModalRLOCancel" class="btn">Cancel</a></div>
  </div>

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
  

  <!-- modalUser -->
  <div id="modalUser" class="modal hide fade">
    <div class="modal-header">
      <a href="#" class="close close-modal">&times;</a>
      <h3 id="modalUserTitle">TITLE</h3>
    </div>
    <div class="modal-body">
      <form class="form-stacked">
        <div class="clearfix">
          <label for="txtUsername">Username</label><input class="span6" id="txtUsername" type="text" placeholder="Username" />
          <br /><br /><label for="txtPassword1">Password</label><input class="span6" id="txtPassword1" type="password" placeholder="Password" />
          <br /><br /><label for="txtPassword2">Confirm Password</label><input class="span6" id="txtPassword2" type="password" placeholder="Confirm Password" />
          <br /><br /><label for="txtEmail">Email</label><input class="span6" id="txtEmail" type="text" placeholder="Password" />
          <br /><br /><label for="chkIsAdministrator">Administrator</label><input type="checkbox" id="chkIsAdministrator" />&nbsp;User can administer other users
          <br /><br /><label for="chkIsContentEditor">Content Editor</label><input type="checkbox" id="chkIsContentEditor" />&nbsp;User can create & edit content
        </div>
      </form>
    </div>
    <div class="modal-footer"><a href="#" id="btnModalUserConfirm" class="btn primary">CONFIRM</a><a href="#" id="btnModalUserCancel" class="btn">Cancel</a></div>
  </div>
  <!-- modalUser -->


  <!---------------------->
  <!---------TABS--------->
  <!---------------------->
  <ul class="tabs" data-tabs="tabs">
    <li id="liRLO" runat="server"><a href="#tabRLO">RLO</a></li>
    <li id="liAddPage" runat="server"><a href="#tabAddPage">Add Page</a></li>
    <li id="liEditPage" runat="server"><a href="#tabPages">Edit Pages</a></li>
    <li id="liUsers" runat="server"><a href="#tabUsers">Users</a></li>
    <li id="liSettings" runat="server"><a href="#tabSiteSettings">Site Settings</a></li>
  </ul>
  
  <!---------------------->
  <!---------TABS--------->
  <!---------------------->
  <div class="pill-content">

    <div id="tabSiteSettings">TBD</div>

    <div id="tabUsers">
      <form class="form-stacked">
        <div class="clearfix">
          <label for="lstUsers">Users</label>
          <select class="span6" id="lstUsers"></select>
          <br />
          <br />
          <a href="#" class="btn" id="btnUserAdd">Add</a>
          <a href="#" class="btn" id="btnUserEdit">Edit</a>
          <a href="#" class="btn danger" id="btnUserDelete">Delete</a>
        </div>
      </form>
    </div>

    <!-- tabLearningObjects -->
    <div id="tabRLO">
      <form class="form-stacked">
        <div class="clearfix">
          <label for="lstRLO1">Learning Objects</label>
          <select class="span6" id="lstRLO1"></select>
          <br />
          <br />
          <a href="#" class="btn" id="btnAddRLO">Add</a>
          <a href="#" class="btn" id="btnEditRLO">Edit</a>
          <a href="#" class="btn danger" id="btnDeleteRLO">Delete</a>
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

      $('.tabs').tabs();

      var isAdministrator = ($('#isAdministrator').val() === 'true');
      var isContentEditor = ($('#isContentEditor').val() === 'true');
      if (isAdministrator && !isContentEditor) {
        $('#tabRLO').removeClass('active');
        $('#tabUsers').addClass('active');
        $('#ctl00_bodyContentPlaceHolder_liRLO').removeClass('active');
        $('#ctl00_bodyContentPlaceHolder_liUsers').addClass('active');
      } else if (isContentEditor) {
        $('#tabRLO').addClass('active');
        $('#tabUsers').removeClass('active');
        $('#ctl00_bodyContentPlaceHolder_liRLO').addClass('active');
        $('#ctl00_bodyContentPlaceHolder_liUsers').removeClass('active');
      }


      loadLearningObjectList();
      loadUserList();

      $("a[rel=popover]").popover({ offset: 10 }).click(function (e) {
        e.preventDefault();
      });



      // Page //////////////////////////////////////////////////////
      $('#movePageUp').click(function () {
        movePageUp();
      });
      $('#movePageDown').click(function () {
        movePageDown();
      });
      $('#deletePage').click(function () {
        deletePage();
      });
      $('#lstRLO3').change(function () {
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

      // Page //////////////////////////////////////////////////////


      // RLO //////////////////////////////////////////////////////

      // the modal needs to be manually activated since we are using 1 modal for ADD and EDIT
      $('#modalRLO').modal({ keyboard: true, backdrop: true });

      $('#btnDeleteRLO').click(function () {
        //        var listControl = $('#lstRLO1').get(0);
        //        if (listControl.selectedIndex >= 0) {
        //          var elem = listControl.options[listControl.selectedIndex];
        //          var text = elem.value;
        //          if (confirm('Delete ' + text + '?')) {
        //            OpenRLO.Web.Service.LearningObjectService.DeleteByUrl(text, function (s) {
        //              loadLearningObjectList();
        //            }, function (m) {
        //              alert('Error: Unable to delete [' + text + ']');
        //            });
        //          }
        //        } else {
        //          alert('Please select a RLO from the list to delete');
        //        }
        var rloURL = $('#lstRLO1').val();
        if (confirm('Delete ' + rloURL + '?')) {
          OpenRLO.Web.Service.LearningObjectService.DeleteByUrl(rloURL, function (m) {
            loadLearningObjectList();
            alert(m);
          }, function (m) {
            alert('Error: Unable to delete RLO [' + pageUrl + ']');
          });
        }
      });
      $('#btnAddRLO').click(function () {
        $('#btnModalRLOConfirm').unbind('click');
        $('#btnModalRLOConfirm').click(function () {
          var rloTitle = $('#txtModalRLOTitle').val();
          OpenRLO.Web.Service.LearningObjectService.Add(rloTitle, function (a) {
            loadLearningObjectList();
            alert(a);
            $('#txtModalRLOTitle').val('');
            $('#modalRLO').modal('hide');
          }, function (m) {
            alert('Error: Unable to add Learning Object [' + rloTitle + ']');
          });
        });
        $('#btnModalRLOConfirm').text('Add RLO');
        $('#modalUserTitle').html('Add RLO');
        $('#modalRLO').modal('show');
      });
      $('#btnEditRLO').click(function () {
        var rloUrl = $('#lstRLO1').val();
        OpenRLO.Web.Service.LearningObjectService.GetByUrl(rloUrl, function (rlo) {
          if (rlo != null) {
            $('#txtModalRLOTitle').val(rlo.Title);
            $('#btnModalRLOConfirm').unbind('click');
            $('#btnModalRLOConfirm').click(function () {
              var rloURL = $('#lstRLO1').val();
              var rloTitle = $('#txtModalRLOTitle').val();
              OpenRLO.Web.Service.LearningObjectService.Edit(rloURL, rloTitle, function (a) {
                loadLearningObjectList();
                alert(a);
                $('#txtModalRLOTitle').val('');
                $('#modalRLO').modal('hide');
              }, function (m) {
                alert('Error saving RLO');
              });
            });
            $('#btnModalRLOConfirm').text('Save RLO');
            $('#modalUserTitle').html('Edit RLO');
            $('#modalRLO').modal('show');
          } else {
            //TODO: Error handling
            alert("Invalid Learning Object");
          }
        }, function (m) {
          alert("Error loading RLO details");
        });
      }); //btnEditRLO
      $('#btnModalRLOCancel').click(function () {
        $('#modalRLO').modal('hide');
      });

      // RLO //////////////////////////////////////////////////////



      // User

      //
      // the user modal needs to be manually activated since we are using 1 modal for ADD and EDIT
      //
      $('#modalUser').modal({ keyboard: true, backdrop: true });

      $('#btnUserDelete').click(function () {
        // get user display text
        var userText = $('#lstUsers option:selected').text();
        var userID = $('#lstUsers').val();

        //confirm if user should be deleted
        if (confirm('Delete user ' + userText + '?' + userID)) {
          OpenRLO.Web.Service.SiteUserService.Delete(userID, function (m) {
            alert(m);
            loadUserList();
          }, function (m) {
            alert('Error deleting user ' + userText);
          });
        }
      });
      $('#btnModalUserCancel').click(function () {
        $('#modalUser').modal('hide');
      });
      //$('#btnModalUserConfirm').click(function () {
      //  addUser();
      //});




      $('#btnUserAdd').click(function () {
        $('#btnModalUserConfirm').unbind('click');
        $('#btnModalUserConfirm').click(function () {
          addUser();
        });
        $('#btnModalUserConfirm').text('Add User');
        $('#modalUserTitle').html('Add User');
        $('#modalUser').modal('show');
      });
      $('#btnUserEdit').click(function () {
        //
        // get and load user details
        //
        var userID = $('#lstUsers').val();
        OpenRLO.Web.Service.SiteUserService.GetByID(userID, function (u) {
          if (u != null) {
            editUser = u;
            clearUserFields();
            $('#txtUsername').val(u.Username);
            $('#txtEmail').val(u.Email);
            $("#chkIsAdministrator").prop("checked", u.IsAdministrator);
            $("#chkIsContentEditor").prop("checked", u.IsContentEditor);

            // setup modal UI
            $('#btnModalUserConfirm').unbind('click');
            $('#btnModalUserConfirm').click(function () {
              saveEditUser();
            });
            $('#btnModalUserConfirm').text('Save User');
            $('#modalUserTitle').html('Edit User');
            $('#modalUser').modal('show');
          } else {
          }
        }, function (m) {
          alert('Error loading user details');
        });
      });

    });




    //
    // USER
    //

    var editUser = null;

    function saveEditUser() {
      var userID = editUser.UserID;

      var usr = new OpenRLO.Data.SiteUser();
      usr.Username = $('#txtUsername').val();
      //do NOT set this, or we might lose the password
      //usr.Passcode = $('#txtPassword1').val();
      usr.Email = $('#txtEmail').val();
      usr.IsAdministrator = $('#chkIsAdministrator').is(':checked'); //$('#chkIsAdministrator').val();
      usr.IsContentEditor = $('#chkIsContentEditor').is(':checked'); //$('#chkIsContentEditor').val();

      var password1 = $('#txtPassword1').val();
      var password2 = $('#txtPassword2').val();

      //
      // basic form validation
      //
      if (usr.Username == null || usr.Username == '') {
        alert('Please enter a username');
        return;
      }
      if (usr.Email == null || usr.Email == '') {
        alert('Please enter an email');
        return;
      }
      if (password1 != null && password1 != '' && password1 != password2) {
        alert('The passwords do not match');
        return;
      }
      if ((password1 == null || password1 == '') && password1 == password2) {
        // set the password to the old password
        usr.Saltcode = editUser.Saltcode;
        usr.Password = editUser.Password;
      } else if (password1 != null && password1 != '' && password1 == password2) {
        // set the new password
        usr.Passcode = password1;
      }

      OpenRLO.Web.Service.SiteUserService.Edit(userID, usr, function (u) {
        clearUserFields();
        loadUserList();
        $('#modalUser').modal('hide');
      }, function (m) {
        alert('Error loading user details');
      });

      $('#modalUserEdit').modal('hide');
    }

    function addUser() {

      var usr = new OpenRLO.Data.SiteUser();
      usr.Username = $('#txtUsername').val();
      usr.Passcode = $('#txtPassword1').val();
      usr.Email = $('#txtEmail').val();
      usr.IsAdministrator = $('#chkIsAdministrator').is(':checked'); //$('#chkIsAdministrator').val();
      usr.IsContentEditor = $('#chkIsContentEditor').is(':checked'); //$('#chkIsContentEditor').val();

      var password1 = $('#txtPassword1').val();
      var password2 = $('#txtPassword2').val();

      //
      // basic form validation
      //
      if (usr.Username == null || usr.Username == '') {
        alert('Please enter a username');
        return;
      }
      if (usr.Email == null || usr.Email == '') {
        alert('Please enter an email');
        return;
      }
      if (password1 == null || password1 == '') {
        alert('Please enter a password');
        return;
      }
      if (password1 != password2) {
        alert('The passwords do not match');
        return;
      }

      OpenRLO.Web.Service.SiteUserService.UsernameExists(usr.Username, function (b) {
        if (b) {
          alert('User account already exists');
        } else {
          OpenRLO.Web.Service.SiteUserService.EmailExists(usr.Username, function (b) {
            if (b) {
              alert('Email already exists');
            } else {
              OpenRLO.Web.Service.SiteUserService.Add(usr, function () {
                alert('User added');
                clearUserFields();
                loadUserList();
                $('#modalUserEdit').modal('hide');
              }, function (m) {
                alert('Error adding user');
                loadUserList();
              });
            }
          }, function (m) {
            alert('Error checking username');
          });
        }
      }, function (m) {
        alert('Error checking username');
      });
    }
    //addUser()

    function clearUserFields() {
      $('#txtUsername').val('');
      $('#txtPassword1').val('');
      $('#txtPassword2').val('');
      $('#txtEmail').val('');
      $("#chkIsAdministrator").prop("checked", false);
      $("#chkIsContentEditor").prop("checked", false);
    }

    function loadUserList() {
      OpenRLO.Web.Service.SiteUserService.GetList(function (a) {
        if (a != null) {
          var listControl = $('#lstUsers')[0];
          listControl.options.length = 0;
          $.each(a, function () {
            var idx = listControl.options.length;
            listControl.options[idx] = new Option(a[idx].Username + " [" + a[idx].Email + "]", a[idx].UserID);
          });
        }
      }, function (m) {
        $('div#output').html('Error: ' + m.toString() + '.<br/>');
      });
    }




    //
    // END USER
    //




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

    function deleteRLO() {
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
        alert('Please select a RLO from the list to delete');
      }
    }

  </script>

</asp:Content>