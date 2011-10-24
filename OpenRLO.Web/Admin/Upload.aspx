<%@ Page Title="" Language="C#" MasterPageFile="~/SiteAdmin.Master" AutoEventWireup="true" CodeBehind="Upload.aspx.cs" Inherits="OpenRLO.Web.Admin.Upload" %>
<asp:Content ID="Content1" ContentPlaceHolderID="bodyContentPlaceHolder" runat="server">
  <!--<h2>File Upload</h2>-->
  <br />
  <asp:FileUpload ID="fupFileUploadControl" runat="server" />
  <br />
  <asp:DropDownList ID="lstUploadLocationControl" runat="server">
    <asp:ListItem Text="\App_Data\Upload\" Value="\App_Data\Upload\" />
  </asp:DropDownList>
  <br />
  <br />
  <asp:Button ID="btnUploadControl" PostBackUrl="/admin/upload" runat="server" Text="Upload" onclick="btnUploadControl_Click" />
  <br />
  <br />
  <asp:Label ID="lblUploadedFile" runat="server" Visible="false">Your uploaded file:</asp:Label>
  <asp:HyperLink ID="lnkUploadedFile" runat="server" Text=""></asp:HyperLink>
</asp:Content>