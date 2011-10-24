<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMobile.Master" AutoEventWireup="true" CodeBehind="Twitter.aspx.cs" Inherits="OpenRLO.Web.Twitter" %>
<asp:Content ID="Content1" ContentPlaceHolderID="bodyContentPlaceHolder" runat="server">
<asp:Repeater runat="server" ID="tweetList">
<ItemTemplate><div><%# ((TweetSharp.Twitter.Model.TwitterStatus)Container.DataItem).Text %></div></ItemTemplate>
</asp:Repeater>
</asp:Content>