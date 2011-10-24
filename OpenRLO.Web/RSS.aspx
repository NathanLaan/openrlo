<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RSS.aspx.cs" Inherits="OpenRLO.Web.RSS" ContentType="text/xml" %>
<asp:Repeater id="rptRSS" runat="server">
  <HeaderTemplate>
<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">
  <channel>
    <title><%# OpenRLO.Web.Global.SiteSettings.SiteName %></title>
    <link><%# OpenRLO.Web.Global.SiteSettings.SiteUrl %></link>
    <description><%# OpenRLO.Web.Global.SiteSettings.SiteFeedDescription %></description>
    <language>en-us</language>
    <generator>Anetro Content Management System <%# OpenRLO.Web.Global.SiteVersion %></generator>
    <atom:link href="<%# OpenRLO.Web.Global.SiteSettings.SiteUrl %>/feed" rel="self" type="application/rss+xml" />
  </HeaderTemplate>
  <ItemTemplate>
    <item>
    <title><%# ((OpenRLO.Web.Data.Article)Container.DataItem).Title %></title>
    <description><%# (DataBinder.Eval(Container.DataItem, "LatestArticleVersion.ContentsShort")) %></description>
    <link><%# OpenRLO.Web.Global.SiteSettings.SiteUrl%>/<%# DataBinder.Eval(Container.DataItem, "Category") %>/<%# DataBinder.Eval(Container.DataItem, "TitleUrl") %></link>
    <guid><%# OpenRLO.Web.Global.SiteSettings.SiteUrl%>/<%# DataBinder.Eval(Container.DataItem, "Category") %>/<%# DataBinder.Eval(Container.DataItem, "TitleUrl") %></guid>
    <pubDate><%# String.Format("{0:R}", DataBinder.Eval(Container.DataItem, "LatestArticleVersion.DateTime")) %></pubDate>
    </item>
  </ItemTemplate>
  <FooterTemplate>
  </channel>
</rss>
  </FooterTemplate>
</asp:Repeater>