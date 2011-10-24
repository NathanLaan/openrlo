<%@ Page Title="" Language="C#" MasterPageFile="~/SiteAdmin.Master" AutoEventWireup="true" CodeBehind="AdminSiteLinkManage.aspx.cs" Inherits="OpenRLO.Web.Admin.AdminSiteLinkManage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="bodyContentPlaceHolder" runat="server">
  <asp:ScriptManager runat="server" ID="masterPageScriptManager" AsyncPostBackErrorMessage="timeout" AsyncPostBackTimeout="300">
    <Services>
      <asp:ServiceReference Path="~/Service/SiteLinkService.asmx" />
    </Services>
  </asp:ScriptManager>
  <h2>Add Site Link</h2>
  <label for="txtTitle">Title:</label><input type="text" id="txtTitle" size="50" maxlength="30" />
  <br /><label for="txtUrl">URL:</label><input type="text" id="txtUrl" size="50" maxlength="100" />
  <br /><label for="button">&nbsp;</label><input type="button" value="Add" onclick="AddSiteLink();" />
  <br />
  
  <h2>Manage Links</h2>
  <label for="siteLinkList">List:</label><select size="10" id="lstSiteLink"></select>
  <br /><label for="btnUp">&nbsp;</label><input type="button" value="Up" id="btnUp" onclick="MoveUp();" />
  <input type="button" value="Down" onclick="MoveDn();" />
  <input type="button" value="Delete" id="btnDelete" onclick="ListDelete();" />
  <input type="button" value="Clear" id="btnCLear" onclick="ClearOutput();" />
  <br /><br /><div id="output"></div>

<script type="text/javascript">
  $(document).ready(function () {
    LoadList();
    ClearOutput();
  });
  function ClearOutput() {
    $('div#output').html('');
  }
  function LoadList() {
    OpenRLO.Web.Service.SiteLinkService.GetList(function (a) {
      if (a != null) {
        var listControl = $('#lstSiteLink')[0];
        listControl.options.length = 0;
        $.each(a, function () {
          var idx = listControl.options.length;
          listControl.options[idx] = new Option(a[idx].Title + ' - ' + a[idx].Order, a[idx].Title);
        });
      }
    }, function (e) {
      $('div#output').html('Unable to get list of site links.<br>');
    });
  }
  function MoveUp() {
    var lst = document.getElementById('lstSiteLink');
    if (lst.selectedIndex >= 0) {
      var text = lst.options[lst.selectedIndex].value;
      OpenRLO.Web.Service.SiteLinkService.MoveUp(text, function (b) {
        if (b == true) {
          LoadSiteLinkList();
        } else {
          $('div#output').html('Unable to move ' + text + '.<br/>');
        }
      }, function (m) {
        $('div#output').html('Moving ' + text + ' failed<br/>');
      });
    } else {
      $('div#output').html('Please select a link from the list to move.<br/>');
    }
  }
  function MoveDn() {
    var lst = document.getElementById('lstSiteLink');
    if (lst.selectedIndex >= 0) {
      var elem = lst.options[lst.selectedIndex];
      var text = elem.value;
      OpenRLO.Web.Service.SiteLinkService.MoveDown(text, function (b) {
        if (b == true) {
          LoadSiteLinkList();
        } else {
          $('div#output').html('Unable to move ' + text + '.<br/>');
        }
      }, function (m) {
        $('div#output').html('Moving ' + text + ' failed<br/>');
      });
    } else {
      $('div#output').html('Please select a link from the list to move.<br/>');
    }
  }

  function ListDelete() {
    var lst = document.getElementById('lstSiteLink');
    if (lst.selectedIndex >= 0) {
      var text = lst.options[lst.selectedIndex].value;
      document.getElementById('btnDelete').Disabled = true;
      OpenRLO.Web.Service.SiteLinkService.Delete(text, function (b) {
        if (b == true) {
          $('div#output').html(text + ' deleted<br/>');
          LoadSiteLinkList();
        } else {
          $('div#output').html('Unable to delete<br/>');
        }
      }, function (m) {
        $('div#output').html('Delete failed.<br/>');
      });
    } else {
      $('div#output').html('Please select a link from the list to delete.<br/>');
    }
  }

  function AddSiteLink() {
    var siteLink = new OpenRLO.Web.Data.SiteLink();
    siteLink.Title = $('#txtTitle').val();
    siteLink.Url = $('#txtUrl').val();
    OpenRLO.Web.Service.SiteLinkService.Exists(siteLink.Title, function (b) {
      if (b == null) {
        $('div#output').html('ExistsCBS NULL.<br/>');
      } else {
        if (b == false) {
          $('div#output').html('Adding link...<br/>');
          OpenRLO.Web.Service.SiteLinkService.Add(siteLink, function (m) {
            $('div#output').html('Link added.<br/>');
            $('#txtTitle').val();
            $('#txtUrl').val();
            LoadSiteLinkList();
          }, function (m) {
            document.getElementById("spanOutput").innerHTML += "Unable to add link. Please try again.<br/>";
          });
        } else {
          $('div#output').html('Link already exists.<br/>');
        }
      }
    }, function (m) {
      $('div#output').html('Link already exists.<br/>');
    });
  }

</script>
</asp:Content>