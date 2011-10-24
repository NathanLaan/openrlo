<%@ Page Title="" Language="C#" MasterPageFile="~/SiteAdmin.Master" AutoEventWireup="true" CodeBehind="AdminCategoryManage.aspx.cs" Inherits="OpenRLO.Web.Admin.AdminCategoryManage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="bodyContentPlaceHolder" runat="server">
  <asp:ScriptManager runat="server" ID="masterPageScriptManager" AsyncPostBackErrorMessage="timeout" AsyncPostBackTimeout="300">
    <Services>
      <asp:ServiceReference Path="~/Service/CategoryService.asmx" />
    </Services>
  </asp:ScriptManager>
  <h2>Add Category</h2>
  <label for="txtTitle">Title:</label><input type="text" id="txtTitle" size="40" maxlength="100" onkeyup="GenerateUrl();" />
  <br /><label for="txtUrl">URL:</label><input type="text" id="txtUrl" size="40" maxlength="100" />
  <br /><label for="button">&nbsp;</label><input type="button" value="Add" onclick="AddCategory();" />
  <br />
  
  <h2>Manage Category List</h2>
  <label>Categories:</label><select size="10" id="selList"></select>
  <br /><label>&nbsp;</label><input type="button" value="Up" id="btnUp" onclick="MoveUp();" />
  <input type="button" value="Down" onclick="MoveDn();" />
  <input type="button" value="Delete" id="btnDelete" onclick="ListDelete();" />
  <input type="button" value="Clear" id="btnCLear" onclick="ClearOutput();" />
  <br /><br /><div id="output"></div>

<script type="text/javascript">
  $(document).ready(function () {
    LoadList();
    ClearOutput();
  });
  function GenerateUrl() {
    $('#txtUrl').val($('#txtTitle').val().toString().toLowerCase().trim().replace(/ /g, '-'));
  }
  function ClearOutput() {
    $('div#output').html('');
  }
  function LoadList() {
    OpenRLO.Web.Service.CategoryService.GetList(function (a) {
      if (a !== null) {
        var listControl = $('#selList')[0];
        listControl.options.length = 0;
        $.each(a, function () {
          var idx = listControl.options.length;
          listControl.options[idx] = new Option(a[idx].Title, a[idx].Title);
        });
      }
    }, function (e) {
      $('div#output').html('Error: ' + e.toString() + '.<br/>');
    });
  }
  function MoveUp() {
    var lst = document.getElementById('selList');
    if (lst.selectedIndex >= 0) {
      var text = lst.options[lst.selectedIndex].value;
      $('div#output').html('MOVING: ' + text + '.<br/>');
      OpenRLO.Web.Service.CategoryService.MoveUp(text, function (b) {
        if (b == true) {
          LoadList();
        } else {
          $('div#output').html('Unable to move: ' + text + '.<br/>');
        }
      }, function (m) {
        $('div#output').html('Error: Moving ' + text + ' failed.<br/>');
      });
    } else {
      $('div#output').html('Please select a category.<br/>');
    }
  }
  function MoveDn() {
    var lst = document.getElementById('selList');
    if (lst.selectedIndex >= 0) {
      var text = lst.options[lst.selectedIndex].value;
      $('div#output').html('MOVING: ' + text + '.<br/>');
      OpenRLO.Web.Service.CategoryService.MoveDown(text, function (b) {
        if (b == true) {
          LoadList();
        } else {
          $('div#output').html('Unable to move: ' + text + '.<br/>');
        }
      }, function (m) {
        $('div#output').html('Error: Moving ' + text + ' failed.<br/>');
      });
    } else {
      $('div#output').html('Please select a category.<br/>');
    }
  }

  //
  //
  //
  function ListDelete() {
    var lst = document.getElementById('selList');
    if (lst.selectedIndex >= 0) {
      var text = lst.options[lst.selectedIndex].value;
      if (confirm("Delete " + text + "?")) {
        OpenRLO.Web.Service.CategoryService.Delete(text, function (b) {
          //document.getElementById('btnDelete').Disabled = false;
          if (b == true) {
            $('div#output').html(text + ' deleted<br/>');
            LoadList();
          } else {
            $('div#output').html('Unable to delete category.<br/>');
          }
        }, function (m) {
          //document.getElementById('btnDelete').Disabled = false;
          $('div#output').html('Error: Unable to delete category.<br/>');
        });
      }
    } else {
      $('div#output').html('Please select a category.<br/>');
    }
  }

  //
  //
  //
  function AddCategory() {
    OpenRLO.Web.Service.CategoryService.Exists($('#txtTitle').val(), ExistsCBS, ExistsCBF);
  }
  function ExistsCBS(b) {
    if (b == null) {
      $('div#output').html('ExistsCBS NULL.<br/>');
    } else {
      if (b == false) {
        var c = new OpenRLO.Web.Data.Category();
        c.Title = document.getElementById('txtTitle').value;
        c.Url = document.getElementById('txtUrl').value;
        OpenRLO.Web.Service.CategoryService.Add(c, function (message) {
          $('div#output').html('Category added.<br/>');
          $('#txtTitle').val('');
          $('#txtUrl').val('');
          LoadList();
        }, function AddCBF(message) {
          $('div#output').html('Unable to add category. Please try again..<br/>');
        });
      } else {
        $('div#output').html('Category ['+c.Title+'] already exists.<br/>');
      }
    }
  }
  function ExistsCBF(message) {
    $('div#output').html('Category [' + c.Title + '] already exists.<br/>');
  }
</script>
</asp:Content>