<%@ Page Language="C#" MasterPageFile="~/SiteMobile.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="OpenRLO.Web.Login" %>
<asp:Content ID="Content2" ContentPlaceHolderID="bodyContentPlaceHolder" runat="server">
  <h2>Login</h2>
  <form runat="server">
    <asp:ScriptManager runat="server" ID="masterPageScriptManager" AsyncPostBackErrorMessage="timeout" AsyncPostBackTimeout="300">
      <Services>
        <asp:ServiceReference Path="~/Service/SiteUserService.asmx" />
      </Services>
    </asp:ScriptManager>
    <asp:TextBox runat="server" ID="txtUsername" class="input-small" placeholder="Username" ></asp:TextBox>
    <asp:TextBox runat="server" ID="txtPassword" class="input-small" placeholder="Password" TextMode="Password" ></asp:TextBox>
    <asp:Button class="btn" runat="server" ID="btnLogin" Text="Login" PostBackUrl="/login" onclick="btnLogin_Click" />
    <br />
    <br />
    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtUsername" ErrorMessage="Please enter your username"></asp:RequiredFieldValidator>
    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtPassword" ErrorMessage="Please enter your password"></asp:RequiredFieldValidator>
    <br />
    <asp:Label runat="server" ID="lblOutput"></asp:Label>
  </form>
  <br />

  <h2>Register Account</h2>
  <form class="form-stacked">
    <div class="clearfix">
      <br /><label for="txtUsername">Username</label><input class="span6" id="txtUsername2" type="text" placeholder="Username" />
      <br /><br /><label for="txtPassword1">Password</label><input class="span6" id="txtPassword1" type="password" placeholder="Password" />
      <br /><br /><label for="txtPassword2">Confirm Password</label><input class="span6" id="txtPassword2" type="password" placeholder="Confirm Password" />
      <br /><br /><label for="txtEmail">Email</label><input class="span6" id="txtEmail" type="text" placeholder="Password" />
      <br /><br /><a href="#" id="btnRegisterAccount" class="btn primary">Register</a>
    </div>
  </form>

  
  <script language="javascript" type="text/javascript">

    $(document).ready(function () {
      $('#btnRegisterAccount').click(function () {
        var username = $('#txtUsername2').val();
        var password1 = $('#txtPassword1').val();
        var password2 = $('#txtPassword2').val();
        var email = $('#txtEmail').val();

        //
        // basic form validation
        //
        if (username === null || username === '') {
          alert('Please enter a username');
          return;
        }
        if (email === null || email === '') {
          alert('Please enter an email');
          return;
        }
        if (password1 === null || password1 === '') {
          alert('Please enter a password');
          return;
        }
        if (password1 !== password2) {
          alert('The passwords do not match');
          return;
        }

        OpenRLO.Web.Service.SiteUserService.CreateAccount(username, password1, email, function (m) {
          if (m != null) {
            alert(m);
            $('#txtPassword1').val('');
            $('#txtPassword2').val('');
          }
        });
      });
    });
  </script>

</asp:Content>