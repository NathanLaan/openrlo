<%@ Page Language="C#" MasterPageFile="~/SiteMobile.Master" AutoEventWireup="true" CodeBehind="Create.aspx.cs" Inherits="OpenRLO.Web.Create" %>
<asp:Content ID="Content2" ContentPlaceHolderID="bodyContentPlaceHolder" runat="server">

  <div id="subject-modal" class="modal hide fade">
    <div class="modal-header">
      <a href="#" class="close">&times;</a>
      <h3>Subjects</h3>
    </div>
    <div class="modal-body">
      <p>stuff...</p>
      <p>other...</p>
    </div>
    <div class="modal-footer">
      <a href="#" class="btn primary">Save</a>
      <a href="#" class="btn secondary">Cancel</a>
    </div>
  </div>

  <h2>CREATE</h2>
  <button data-controls-modal="subject-modal" data-backdrop="true" data-keyboard="true" class="btn">Edit Subjects</button>
</asp:Content>