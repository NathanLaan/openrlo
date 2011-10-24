<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMobile.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="OpenRLO.Web.Admin.Login" %>
<asp:Content ID="Content2" ContentPlaceHolderID="bodyContentPlaceHolder" runat="server">
  <h2>Login</h2>
  <label>Username:</label><asp:TextBox runat="server" ID="txtUsername" ></asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtUsername" ErrorMessage="Please enter your username"></asp:RequiredFieldValidator>
  <br />
  <label>Password:</label><asp:TextBox TextMode="Password" runat="server" ID="txtPassword" ></asp:TextBox><asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtPassword" ErrorMessage="Please enter your password"></asp:RequiredFieldValidator>
  <br />
  <label>&nbsp;</label><asp:Button runat="server" ID="btnLogin" Text="Login" PostBackUrl="/admin/login" onclick="btnLogin_Click" />
  <br />
  <asp:Label runat="server" ID="lblOutput"></asp:Label>
</asp:Content>