<%@ Page Language="C#" MasterPageFile="~/SiteMobile.Master" AutoEventWireup="true" CodeBehind="ManageSite.aspx.cs" Inherits="OpenRLO.Web.ManageSite" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageNameContent" runat="server">Manage Website</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="TaglineContent" runat="server"></asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="bodyContentPlaceHolder" runat="server">
  <form runat="server">
    <asp:ScriptManager runat="server" ID="masterPageScriptManager" AsyncPostBackErrorMessage="timeout" AsyncPostBackTimeout="300">
      <Services>
        <asp:ServiceReference Path="~/Service/SiteUserService.asmx" />
        <asp:ServiceReference Path="~/Service/SiteSettingsService.asmx" />
        <asp:ServiceReference Path="~/Service/LearningObjectService.asmx" />
        <asp:ServiceReference Path="~/Service/PageService.asmx" />
      </Services>
    </asp:ScriptManager>
  </form>

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
    </div>
    <div class="modal-footer"><a href="#" id="btnModalRLOConfirm" class="btn primary">CONFIRM</a><a href="#" id="btnModalRLOCancel" class="btn">Cancel</a></div>
  </div>

  <!-- PageModal -->
  <div id="modalPage" class="modal hide fade">
    <div class="modal-header">
      <a href="#" class="close close-modal">&times;</a>
      <h3 id="modalPageTitle">Edit Page</h3>
    </div>
    <div class="modal-body">
      <form class="form-stacked">
        <div class="clearfix">
          <label for="txtModalPageTitle">Title</label>
          <input class="span6" id="txtModalPageTitle" type="text" />
          <br />
          <label for="txtModalPageContents">Content</label>
          <textarea class="xxlarge" id="txtModalPageContents" name="pageContent" rows="10"></textarea>
          <span class="help-block"><strong>Note:</strong> Page content is formatted using <a href="http://daringfireball.net/projects/markdown/" target="_blank">MARKDOWN</a>.</span>
        </div>
      </form>
      <br />
      <br />
    </div>
    <div class="modal-footer"><a href="#" id="btnModalPageConfirm" class="btn primary">CONFIRM</a><a href="#" id="btnModalPageCancel" class="btn">Cancel</a></div>
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
    <li id="liPages" runat="server"><a href="#tabPages">Pages</a></li>
    <li id="liUsers" runat="server"><a href="#tabUsers">Users</a></li>
    <li id="liSettings" runat="server"><a href="#tabSiteSettings">Site Settings</a></li>
  </ul>
  
  <!---------------------->
  <!---------TABS--------->
  <!---------------------->
  <div class="pill-content">

    <!-- tabLearningObjects -->
    <div id="tabRLO">
      <form class="form-stacked">
        <div class="clearfix">
          <label for="lstRLO1">Learning Objects</label><select class="span6" id="lstRLO1"></select>
          <br />
          <br />
          <a href="#" class="btn" id="btnAddRLO">Add</a>
          <a href="#" class="btn" id="btnEditRLO">Edit</a>
          <a href="#" class="btn danger" id="btnDeleteRLO">Delete</a>
        </div>
      </form>
    </div>
    <!-- tabLearningObjects -->
         
    <div id="tabPages">
      <form class="form-stacked">
        <div class="clearfix">
          <label for="lstRLO2">Learning Objects</label><select class="span6" id="lstRLO2"></select>
          <br />
          <br />
          <label for="loTitle">Pages</label><select class="span6 multirows" size="10" id="pageList"></select>
          <br />
          <br />
          <a href="#" class="btn" id="btnPageAdd">Add</a>
          <a href="#" class="btn" id="btnPageMoveUp">Move Up</a>
          <a href="#" class="btn" id="btnPageMoveDown">Move Down</a>
          <a href="#" class="btn" id="btnPageEdit">Edit</a>
          <a href="#" class="btn danger" id="btnPageDelete">Delete</a>
        </div>
      </form>
    </div>

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

    <div id="tabSiteSettings">
      <form class="form-stacked">
        <div class="clearfix">
          <label for="txtSiteSettingsName">Site Name:</label><input class="span6" type="text" id="txtSiteSettingsName" />
          <br /><label for="txtSiteSettingsName">Site Copyright:</label><input class="span6" type="text" id="txtSiteSettingsCopyright" />
          <br /><label for="txtSiteSettingsName">Site URL:</label><input class="span6" type="text" id="txtSiteSettingsUrl" />
          <br /><label for="txtSiteSettingsName">Google Analytics:</label><input class="span6" type="text" id="txtSiteSettingsGoogleAnalytics" />
          <br />
          <br /><a href="#" class="btn" id="btnSiteSettingsSave">Save</a>
        </div>
      </form>
    </div>

  </div>
  <!-- tabs -->
  
  <script language="javascript" type="text/javascript">

    function loadSiteSettings() {
      OpenRLO.Web.Service.SiteSettingsService.Get(function (siteSettings) {
        $('#txtSiteSettingsName').val(siteSettings.SiteName);
        $('#txtSiteSettingsCopyright').val(siteSettings.SiteCopyright);
        $('#txtSiteSettingsUrl').val(siteSettings.SiteUrl);
        $('#txtSiteSettingsGoogleAnalytics').val(siteSettings.GoogleAnalyticsTrackingCode);
      }, function (m) {
        alert('Error loading Site Settings');
      });
    }
    function saveSiteSettings() {
      var siteSettings = new OpenRLO.Data.SiteSettings();
      siteSettings.SiteName = $('#txtSiteSettingsName').val();
      siteSettings.SiteCopyright = $('#txtSiteSettingsCopyright').val();
      siteSettings.SiteUrl = $('#txtSiteSettingsUrl').val();
      siteSettings.GoogleAnalyticsTrackingCode = $('#txtSiteSettingsGoogleAnalytics').val();
      OpenRLO.Web.Service.SiteSettingsService.Set(siteSettings, function (m) {
        alert(m);
      }, function (e) {
        alert('Error saving Site Settings');
      });
    }

    $(document).ready(function () {


      $('#btnSiteSettingsSave').click(function () {
        saveSiteSettings();
      });

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
      loadSiteSettings();

      //$("a[rel=popover]").popover({ offset: 10 }).click(function (e) {
      //  e.preventDefault();
      //});
      $('#modalRLO').modal({ keyboard: true, backdrop: true });
      $('#modalPage').modal({ keyboard: true, backdrop: true });
      $('#modalUser').modal({ keyboard: true, backdrop: true });


      // Page //////////////////////////////////////////////////////
      $('#btnPageMoveUp').click(function () {
        var rloUrl = $('#lstRLO2').val();
        var pageUrl = $('#pageList').val();
        OpenRLO.Web.Service.PageService.MovePageUp(rloUrl, pageUrl, function (a) {
          loadPageList(rloUrl);
          alert(a);
        }, function (m) {
          alert('Error: Unable to move page [' + pageUrl + ']');
        });
      });
      $('#btnPageMoveDown').click(function () {
        var rloUrl = $('#lstRLO2').val();
        var pageUrl = $('#pageList').val();
        OpenRLO.Web.Service.PageService.MovePageDown(rloUrl, pageUrl, function (a) {
          loadPageList(rloUrl);
          alert(a);
        }, function (m) {
          alert('Error: Unable to move page [' + pageUrl + ']');
        });
      });
      $('#lstRLO2').change(function () {
        loadPageList($(this).attr('value'));
      });
      $('#btnModalPageCancel').click(function () {
        $('#txtModalPageTitle').val('');
        $('#txtModalPageContents').val('');
        $('#modalPage').modal('hide');
      });
      $('#btnPageAdd').click(function () {
        $('#btnModalPageConfirm').unbind('click');
        var rloUrl = $('#lstRLO2').val();
        $('#btnModalPageConfirm').click(function () {
          var pageTitle = $('#txtModalPageTitle').val();
          var pageContent = $('#txtModalPageContents').val();
          OpenRLO.Web.Service.PageService.Add(rloUrl, pageTitle, pageContent, function (a) {
            loadPageList(rloUrl);
            alert(a);
            $('#txtModalPageTitle').val('');
            $('#txtModalPageContents').val('');
            $('#modalPage').modal('hide');
          }, function (m) {
            alert('Error: Unable to add page [' + pageTitle + ']');
          });

        });
        $('#btnModalPageConfirm').text('Add Page');
        $('#modalPageTitle').html('Add Page');
        $('#modalPage').modal('show');
      }); //END btnPageAdd
      $('#btnPageEdit').click(function () {
        $('#btnModalPageConfirm').unbind('click');
        var rloUrl = $('#lstRLO2').val();
        var pageUrl = $('#pageList').val();
        OpenRLO.Web.Service.PageService.GetByUrl(rloUrl, pageUrl, function (page) {
          if (page != null) {
            $('#btnModalPageConfirm').click(function () {
              var rloUrl = $('#lstRLO2').val();
              var oldPageUrl = $('#pageList').val();
              var newPageTitle = $('#txtModalPageTitle').val();
              var newPageContents = $('#txtModalPageContents').val();
              OpenRLO.Web.Service.PageService.Edit(rloUrl, oldPageUrl, newPageTitle, newPageContents, function (a) {
                loadPageList(rloUrl);
                alert(a);
                $('#txtModalPageTitle').val('');
                $('#txtModalPageContents').val('');
                $('#modalPage').modal('hide');
              }, function (m) {
                console.log(m);
                alert('Error saving page');
              });
            });
            $('#txtModalPageTitle').val(page.Title);
            $('#txtModalPageContents').val(page.Contents);
            $('#btnModalPageConfirm').text('Save');
            $('#modalPageTitle').html('Edit Page');
            $('#modalPage').modal('show');
          } else {
            //
            //TODO: Error handling
            //
            alert('Unable to load page details');
            $('#modalPage').modal('hide');
          }
        }, function (m) {
          alert('Error loading page details');
          $('#modalPage').modal('hide');
        });

      }); // END btnPageEdit

      $('#btnPageDelete').click(function () {
        var rloUrl = $('#lstRLO2').val();
        var pageUrl = $('#pageList').val();
        if (confirm('Delete ' + pageUrl + ' from ' + rloUrl + '?')) {
          OpenRLO.Web.Service.PageService.DeleteByUrl(rloUrl, pageUrl, function (a) {
            loadPageList(rloUrl);
            alert(a);
          }, function (m) {
            alert('Error: Unable to delete page [' + pageUrl + ']');
          });
        }
      });

      // Page //////////////////////////////////////////////////////


      // RLO //////////////////////////////////////////////////////

      // the modal needs to be manually activated since we are using 1 modal for ADD and EDIT

      $('#btnDeleteRLO').click(function () {
        var rloUrl = $('#lstRLO1').val();
        if (confirm('Delete ' + rloUrl + '?')) {
          OpenRLO.Web.Service.LearningObjectService.DeleteByUrl(rloUrl, function (m) {
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
            $('#modalUserTitle').html('Edit RLO');
            $('#btnModalRLOConfirm').unbind('click').text('Save').click(function () {
              var rloUrl = $('#lstRLO1').val();
              var rloTitle = $('#txtModalRLOTitle').val();
              OpenRLO.Web.Service.LearningObjectService.Edit(rloUrl, rloTitle, function (a) {
                loadLearningObjectList();
                alert(a);
                $('#txtModalRLOTitle').val('');
                $('#modalRLO').modal('hide');
              }, function (m) {
                alert('Error saving RLO');
              });
            });
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
        $('#txtModalRLOTitle').val('');
        $('#modalRLO').modal('hide');
      });

      // RLO //////////////////////////////////////////////////////



      // User

      //
      // the user modal needs to be manually activated since we are using 1 modal for ADD and EDIT
      //

      $('#btnModalUserCancel').click(function () {
        clearUserFields();
        $('#modalUser').modal('hide');
      });
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
      $('#btnUserAdd').click(function () {
        $('#modalUserTitle').html('Add User');
        $('#btnModalUserConfirm').unbind('click').text('Add User').click(function () {
          addUser();
        });
        $('#modalUser').modal('show');
      });
      $('#btnUserEdit').click(function () {
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
            $('#btnModalUserConfirm').unbind('click').text('Save').click(function () {
              saveEditUser();
            });
            $('#modalUserTitle').html('Edit User');
            $('#modalUser').modal('show');
          } else {
          }
        }, function (m) {
          alert('Error loading user details');
        });
      });

    });     // END document.ready()



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
        alert('Error saving user details');
      });
    }

    // addUser
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
                $('#modalUser').modal('hide');
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




    function loadPageList(rloUrl) {
      OpenRLO.Web.Service.PageService.GetList(rloUrl, function (a) {
        if (a != null) {
          var pageList = $('#pageList')[0];
          pageList.options.length = 0;
          $.each(a, function () {
            var i = pageList.options.length;
            pageList.options[i] = new Option((i + 1) + ": " + a[i].Title, a[i].Url);
          });
        }
      }, function (m) {
        alert('Error: Unable to load pages for [' + rloUrl + ']');
      });
    }


    function loadLearningObjectList() {
      OpenRLO.Web.Service.LearningObjectService.GetList(function (a) {
        if (a != null) {
          var listControl1 = $('#lstRLO1')[0];
          var listControl2 = $('#lstRLO2')[0];
          var listControl3 = $('#lstRLO2')[0];
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
          loadPageList($('#lstRLO2').val());
        }
      }, function (m) {
        console.log(m);
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