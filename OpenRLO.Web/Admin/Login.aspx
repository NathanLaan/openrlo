<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMobile.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="OpenRLO.Web.Admin.Login" %>
<asp:Content ID="Content2" ContentPlaceHolderID="bodyContentPlaceHolder" runat="server">
  <h2>Login</h2>
  <form runat="server">
  <asp:TextBox runat="server" ID="txtUsername" class="input-small" placeholder="Username" ></asp:TextBox>
  <asp:TextBox runat="server" ID="txtPassword" class="input-small" placeholder="Password" TextMode="Password" ></asp:TextBox>
  <asp:Button class="btn runat="server" ID="btnLogin" Text="Login" PostBackUrl="/admin/login" onclick="btnLogin_Click" />
  <br />
  <br />
  <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtUsername" ErrorMessage="Please enter your username"></asp:RequiredFieldValidator>
  <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtPassword" ErrorMessage="Please enter your password"></asp:RequiredFieldValidator>
  <br />
  <asp:Label runat="server" ID="lblOutput"></asp:Label>
  </form>
</asp:Content>