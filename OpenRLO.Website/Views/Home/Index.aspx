<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="pageTitle" ContentPlaceHolderID="PageTitleContent" runat="server">
OpenRLO
</asp:Content>

<asp:Content ID="pageNameTitle" ContentPlaceHolderID="PageNameContent" runat="server">
HOME
</asp:Content>

<asp:Content ID="taglineContent" ContentPlaceHolderID="TaglineContent" runat="server">
OpenRLO
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <h2><%: ViewData["Message"] %></h2>
    <p>PLACEHOLDER...</p>
</asp:Content>
