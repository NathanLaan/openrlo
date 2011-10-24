<%@ Page Title="" Language="C#" MasterPageFile="~/SiteAdmin.Master" AutoEventWireup="true" CodeBehind="EmailTest.aspx.cs" Inherits="OpenRLO.Web.Admin.EmailTest" %>
<asp:Content ID="Content1" ContentPlaceHolderID="bodyContentPlaceHolder" runat="server">
  <asp:Button runat="server" ID="btnSendEmail" PostBackUrl="/admin/email" Text="Test Email" onclick="btnSendEmail_Click" />
</asp:Content>