<%@ Page Language="C#" MasterPageFile="~/SiteMobile.Master" AutoEventWireup="true" CodeBehind="PagedContent.aspx.cs" Inherits="OpenRLO.Web.PagedContent" %>
<%@ OutputCache Duration="2400" VaryByParam="*"  %>


<asp:Content ID="Content1" ContentPlaceHolderID="PageNameContent" runat="server">Open Social Learning</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="TaglineContent" runat="server"></asp:Content>

<asp:Content ID="Content3" ContentPlaceHolderID="bodyContentPlaceHolder" runat="server">

MISSION
<br />

  <span runat="server" id="categoryHeader">
    <h2><asp:Label runat="server" ID="lblCategoryName" /></h2>
    <br />
  </span>
  <asp:Repeater runat="server" ID="articleList">
    <ItemTemplate>
<h2><a href="/<%# ((OpenRLO.Web.Data.Article)Container.DataItem).Category %>/<%# ((OpenRLO.Web.Data.Article)Container.DataItem).TitleUrl %>"><b><%# ((OpenRLO.Web.Data.Article)Container.DataItem).Title %></b> - <%# ((OpenRLO.Web.Data.Article)Container.DataItem).PublishedDateTime.ToString("MMM dd") %></a></h2>
<%# ((OpenRLO.Web.Data.Article)Container.DataItem).LatestArticleContentsHtml %><br />
    </ItemTemplate>
  </asp:Repeater>
  <asp:Repeater runat="server" ID="articleListAdmin">
    <ItemTemplate>
<h2><a href="/admin/article/edit/<%# ((OpenRLO.Web.Data.Article)Container.DataItem).TitleUrl %>"><b><%# ((OpenRLO.Web.Data.Article)Container.DataItem).Title %></b> - <%# ((OpenRLO.Web.Data.Article)Container.DataItem).PublishedDateTime.ToString("MMM dd")%></a></h2>
<%# ((OpenRLO.Web.Data.Article)Container.DataItem).LatestArticleContentsHtml %><br />
    </ItemTemplate>
  </asp:Repeater>
  <br />
  <asp:Label runat="server" ID="lblPrev">&laquo; Prev</asp:Label><asp:HyperLink runat="server" ID="lnkPrev">&laquo; Prev</asp:HyperLink>&nbsp;|&nbsp;<asp:HyperLink runat="server" ID="lnkNext">Next &raquo;</asp:HyperLink><asp:Label runat="server" ID="lblNext">Next &raquo;</asp:Label>

  
<br />
<br />
</asp:Content>