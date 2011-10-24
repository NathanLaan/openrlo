<%@ Page Title="" Language="C#" MasterPageFile="~/SiteAdmin.Master" AutoEventWireup="true" CodeBehind="AdminSiteMenu.aspx.cs" Inherits="OpenRLO.Web.Admin.AdminSiteMenu" %>
<asp:Content ID="Content3" ContentPlaceHolderID="bodyContentPlaceHolder" runat="server">

<!--
List of existing articles.
List of existing menu items.
Button to add existing article to menu.
Button to remove existing menu item from menu.
Button to move selected existing menu item up.
Button to move selected existing menu item down.
-->

<asp:ListBox runat="server" ID="lstArticleList"></asp:ListBox>
<asp:Button runat="server" ID="btnAdd" Text="Add &gt;" />
<asp:Button runat="server" ID="btnRemove" Text="&lt; Remove" />
<asp:ListBox runat="server" ID="lstMenuList"></asp:ListBox>
<asp:Button runat="server" ID="btnUp" Text="Up" />
<asp:Button runat="server" ID="btnDown" Text="Down" />

</asp:Content>
