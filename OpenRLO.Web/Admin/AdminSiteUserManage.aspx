<%@ Page Title="" Language="C#" MasterPageFile="~/SiteAdmin.Master" AutoEventWireup="true" CodeBehind="AdminSiteUserManage.aspx.cs" Inherits="OpenRLO.Web.Admin.AdminSiteUserManage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="bodyContentPlaceHolder" runat="server">
  <asp:ScriptManager runat="server" ID="masterPageScriptManager" AsyncPostBackErrorMessage="timeout" AsyncPostBackTimeout="300">
    <Services>
      <asp:ServiceReference Path="~/Service/SiteUserService.asmx" />
    </Services>
  </asp:ScriptManager>
  <!--<h2>Manage Users</h2>-->
  <br /><label for="selList">Users:</label><select id="lstUser" onchange="SelectedUserChange();"></select>
  <br /><label for="Delete">&nbsp;</label><input type="button" value="Delete" id="btnDelete" onclick="DeleteUser();" /><input type="button" value="Edit" id="btnEdit" onclick="EditUser();" />

  <h2 id="addEditUserTitle">Add User</h2>
  <label for="txtShowname">Display Name:</label><input type="text" id="txtShowname" size="40" maxlength="100" onkeyup="GenerateUsername();" />
  <br /><label for="txtUsername">Username:</label><input type="text" id="txtUsername" size="40" maxlength="100" />
  <br /><label for="txtPassword1">Password:</label><input type="text" id="txtPassword1" size="40" maxlength="100" />
  <br /><label for="txtPassword2">Confirm:</label><input type="text" id="txtPassword2" size="40" maxlength="100" />
  <br /><label for="txtTimezone">Timezone:</label><input type="text" id="txtTimezone" size="40" maxlength="100" />
  <br /><label for="txtEmail">Email:</label><input type="text" id="txtEmail" size="40" maxlength="100" />
  <br /><label for="btnAdd">&nbsp;</label><input type="button" value="Add" id="btnAdd" onclick="AddUser();" />
  <input type="button" value="Save" id="btnEditSave" disabled="disabled" onclick="SaveUser();" />
  <input type="button" value="Cancel" id="btnEditCancel" disabled="disabled" onclick="CancelEditUser();" />
  <br /><br /><div id="output"></div>
  <br />

<script type="text/javascript">
  $(document).ready(function () {
    LoadList();
  });
  function Sanitize(str) {
    str = str.toLowerCase();
    str = str.trim();
    str = str.replace(/ /g, "");
    return str;
  }
  function GenerateUsername() {
    $('#txtUsername').val( $('#txtShowname').val().toString().toLowerCase().trim().replace(/ /g, '') );
  }
  var curUser = null;
  function EditUser() {
    if ($("#lstUser option:selected") != null) {
      OpenRLO.Web.Service.SiteUserService.Get($("#lstUser option:selected").val(), function (usr) {
        if (usr != null) {
          curUser = usr;
          $('#txtUsername').val(usr.Username);
          $('#txtShowname').val(usr.Showname);
          //$('#txtPassword1').val(usr.Passcode);
          $('#txtTimezone').val(usr.Timezone);
          $('#txtEmail').val(usr.Email);
          $('#lstUser').attr('disabled', true);
          $('#btnAdd').attr('disabled', true);
          $('#btnDelete').attr('disabled', true);
          $('#btnEdit').attr('disabled', true);
          $('#btnEditSave').attr('disabled', false);
          $('#btnEditCancel').attr('disabled', false);
          $('#addEditUserTitle').html('Edit User');
        } else {
          $('div#output').html('Error: NULL user.<br/>');
        }
      }, function (m) {
        $('div#output').html('Error: ' + m.toString() + '.<br/>');
      });
    }
  }
  function SaveUser() {
    if (curUser != null) {
      $('div#output').html('Saving User...<br/>');
      var newUser = new OpenRLO.Web.Data.SiteUser();
      if ($('#txtPassword1').val() != null && $('#txtPassword1').val() != "") {
        newUser.Passcode = $('#txtPassword1').val();
      } else {
        newUser.Saltcode = curUser.Saltcode;
        newUser.Password = curUser.Password;
      }
      newUser.Username = $('#txtUsername').val();
      newUser.Showname = $('#txtShowname').val();
      newUser.TimeZone = $('#txtTimezone').val();
      newUser.Email = $('#txtEmail').val();
      OpenRLO.Web.Service.SiteUserService.Edit(curUser, newUser, function () {
        $('div#output').html('User Saved!<br/>');
        LoadList();
        $('#lstUser').attr('disabled', false);
        $('#btnAdd').attr('disabled', false);
        $('#btnDelete').attr('disabled', false);
        $('#btnEdit').attr('disabled', false);
        $('#btnEditSave').attr('disabled', true);
        $('#btnEditCancel').attr('disabled', true);
        $('#addEditUserTitle').html('Add User');
      }, function (m) {
        $('div#output').html('Error: ' + m.toString() + '.<br/>');
      });
    } else {
      $('div#output').html('NULL!<br/>');
      $('#lstUser').attr('disabled', false);
      $('#btnAdd').attr('disabled', false);
      $('#btnDelete').attr('disabled', false);
      $('#btnEdit').attr('disabled', false);
      $('#btnEditSave').attr('disabled', true);
      $('#btnEditCancel').attr('disabled', true);
      $('#addEditUserTitle').html('Add User');
    }
    ClearFields();
  }
  function CancelEditUser() {
    ClearFields();
    $('#lstUser').attr('disabled', false);
    $('#btnAdd').attr('disabled', false);
    $('#btnDelete').attr('disabled', false);
    $('#btnEdit').attr('disabled', false);
    $('#btnEditSave').attr('disabled', true);
    $('#btnEditCancel').attr('disabled', true);
    $('#addEditUserTitle').html('Add User');
  }
  function ClearFields() {
    $('input:text').val('');
  }
  function SelectedUserChange(){
    if ($("#lstUser option:selected") != null) {
      $('div#output').html($("#lstUser option:selected").val() + ' selected.<br/>');
    }
  }
  function LoadList() {
    OpenRLO.Web.Service.SiteUserService.GetList(function (a) {
      if (a != null) {
        var listControl = $('#lstUser')[0];
        listControl.options.length = 0;
        $.each(a, function () {
          var idx = listControl.options.length;
          listControl.options[idx] = new Option(a[idx].Showname + " [" + a[idx].Username+"]", a[idx].Username);
        });
      }
    }, function (m) {
      $('div#output').html('Error: ' + m.toString() + '.<br/>');
    });
  }
  function AddUser() {
    var usr = new OpenRLO.Web.Data.SiteUser();
    usr.Username = $('#txtUsername').val();
    usr.Showname = $('#txtShowname').val();
    usr.Passcode = $('#txtPassword1').val();
    usr.TimeZone = $('#txtTimezone').val();
    usr.Email = $('#txtEmail').val();
    OpenRLO.Web.Service.SiteUserService.Exists(usr.Username, usr.Showname, function (b) {
      if (b) {
        $('div#output').html('User account already exists.<br/>');
      } else {
        if ($('#txtPassword1').val() != $('#txtPassword2').val()) {
          $('div#output').html('Passwords do not match.<br/>');
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
  }
  function DeleteUser() {
    var listControl = $('#lstUser').get(0);
    if (listControl.selectedIndex >= 0) {
      var elem = listControl.options[listControl.selectedIndex];
      var text = elem.value;
      if (confirm('Delete ' + text + '?')) {
        OpenRLO.Web.Service.SiteUserService.Delete(text, function (s) {
          //$('div#output').html(text + ' deleted.<br/>');
          $('div#output').html(s + '.<br/>');
          LoadList();
        }, function (m) {
          $('div#output').html('Error: ' + m.toString() + '.<br/>');
        });
      }
    } else {
      $('div#output').html('Please select a user from the list to delete.<br/>');
    }
  }
</script>
</asp:Content>