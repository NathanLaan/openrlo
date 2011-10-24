<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMobile.Master" AutoEventWireup="true" CodeBehind="ViewArticle.aspx.cs" Inherits="OpenRLO.Web.ViewArticle" %>
<%@ OutputCache Duration="2400" VaryByParam="*"  %>
<asp:Content ID="Content2" ContentPlaceHolderID="bodyContentPlaceHolder" runat="server">
<a href="/">Home</a>&nbsp;&raquo;&nbsp;<asp:HyperLink runat="server" ID="lnkCategoryName">Category</asp:HyperLink>&nbsp;&raquo;&nbsp;<asp:Label runat="server" ID="lblArticleTitle" /><asp:Label runat="server" ID="lblEditArticle">&nbsp;&raquo;&nbsp;</asp:Label><asp:HyperLink runat="server" ID="lnkEditArticle">EDIT</asp:HyperLink>
<h2><asp:Label runat="server" ID="lblArticleName" /></h2>
<asp:Label runat="server" ID="lblArticleContent" />
<br /><asp:Label runat="server" ID="lblDateTime" />&nbsp;-&nbsp;<asp:HyperLink runat="server" ID="lnkPermalink">Permalink</asp:HyperLink>&nbsp;-&nbsp;<asp:HyperLink runat="server" ID="lnkShortUrl">Short URL</asp:HyperLink>
<br />
<br />
<div id="disqus_thread"></div>
<script type="text/javascript">
  /* * * CONFIGURATION VARIABLES: EDIT BEFORE PASTING INTO YOUR WEBPAGE * * */
  var disqus_shortname = 'nathanlaan'; // required: replace example with your forum shortname

  // The following are highly recommended additional parameters. Remove the slashes in front to use.
  // var disqus_identifier = 'unique_dynamic_id_1234';
  // var disqus_url = 'http://example.com/permalink-to-page.html';
  //var disqus_url = $('#hiddenFieldPermalink').val();
  var disqus_url = document.getElementById('hiddenFieldPermalink').value;

  /* * * DON'T EDIT BELOW THIS LINE * * */
  (function () {
    var dsq = document.createElement('script'); dsq.type = 'text/javascript'; dsq.async = true;
    dsq.src = 'http://' + disqus_shortname + '.disqus.com/embed.js';
    (document.getElementsByTagName('head')[0] || document.getElementsByTagName('body')[0]).appendChild(dsq);
  })();
</script>
<noscript>Please enable JavaScript to view the <a href="http://disqus.com/?ref_noscript">comments powered by Disqus.</a></noscript>
<a href="http://disqus.com" class="dsq-brlink">blog comments powered by <span class="logo-disqus">Disqus</span></a>


</asp:Content>