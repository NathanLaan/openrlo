<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMobile.Master" AutoEventWireup="true" CodeBehind="Learn.aspx.cs" Inherits="OpenRLO.Web.Learn" %>

<asp:Content ID="Content1" ContentPlaceHolderID="PageNameContent" runat="server"><div id="learningObjectTitle">Loading content...</div></asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="bodyContentPlaceHolder" runat="server">
  <form id="learnForm" runat="server">
    <asp:ScriptManager runat="server" ID="masterPageScriptManager" AsyncPostBackErrorMessage="timeout" AsyncPostBackTimeout="300">
      <Services>
        <asp:ServiceReference Path="~/Service/LearningObjectService.asmx" />
        <asp:ServiceReference Path="~/Service/PageService.asmx" />
      </Services>
    </asp:ScriptManager>
  </form>

  <h2 id="pageTitle"></h2>
  <div class="clearfix" id="pageContent">Loading content...</div>

  <br />
  <br />

  <!-- jump menu -->
  <div class="clearfix">
    Jump to: <select class="span4" name="pageList" id="pageList"></select>
    <a href="#" class="btn" id="btnJump">Go</a>
    <a href="#" class="btn" id="btnPrev">&lt;&lt; Prev</a>
    <a href="#" class="btn" id="btnNext">Next &gt;&gt;</a>
  </div>
  
  
  <script language="javascript" type="text/javascript">

    var _t, _p, _learningObject, gPage;

    $(document).ready(function () {
      _t = $('#hiddenFieldT').val();
      _p = $('#hiddenFieldP').val();
      if (_p == null || _p == "") {
        _p = 1;
      }
      loadPageContent();
      $('#btnJump').click(function () {
        var pageNumber = $('#pageList').val();
        window.location = "/learn/" + _learningObject.Url + "/" + pageNumber;
      });
//      $('#btnPrev').click(function () {
//        var pageNumber = _p - 1;
//        window.location = "/learn/" + _learningObject.Url + "/" + pageNumber;
//      });
//      $('#btnNext').click(function () {
//        var pageNumber = _p + 1;
//        window.location = "/learn/" + _learningObject.Url + "/" + pageNumber;
//      });
    });

    function setupLinks() {
      // force _p into an integer
      var pageNumber = parseInt(_p);

      if (pageNumber == 1) {
        $('#btnPrev').hide();
      }
      if (pageNumber >= _learningObject.PageCount) {
        $('#btnNext').hide();
      }

      $('#btnPrev').attr('href', '/learn/' + _learningObject.Url + '/' + (pageNumber - 1));
      $('#btnNext').attr('href', '/learn/' + _learningObject.Url + '/' + (pageNumber + 1));
    }

    function loadPageContent() {
      OpenRLO.Web.Service.PageService.GetList(_t, function (a) {
        if (a != null) {
          var pageList = $('#pageList')[0];
          pageList.options.length = 0;
          $.each(a, function () {
            var i = pageList.options.length;
            pageList.options[i] = new Option((i+1) + ": " + a[i].Title, a[i].Order);
          });
        }
      }, function (m) {
        alert('Error loading page contents');
      });

      OpenRLO.Web.Service.LearningObjectService.GetByUrl(_t, function (learningObject) {
        if (learningObject != null) {
          _learningObject = learningObject;
          $('#learningObjectTitle').html(_learningObject.Title);
          setupLinks();
        } else {
          $('#learningObjectTitle').html(_t);
        }
      }, function (m) {
        $('#pageContent').html("Error loading learning object.");
      });

      OpenRLO.Web.Service.PageService.GetByUrl2(_t, _p, function (page) {
        if (page != null) {
          _page = page;
          $('#pageContent').html(_page.HtmlContents);
          $('#pageTitle').html(_page.Title);
        } else {
          $('#pageContent').html("Invalid page contents");
        }
      }, function (m) {
        $('#pageContent').html("Error loading page contents");
      });
      

    }

  </script>

</asp:Content>