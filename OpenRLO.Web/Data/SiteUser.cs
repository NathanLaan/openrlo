using System;
using System.Collections.Generic;
using System.Text;
using System.Security.Cryptography;
using System.Web.Security;

namespace OpenRLO.Web.Data
{
  public class SiteUser
  {

    public Guid UserID { get; set; }
    public bool IsContentCreator { get; set; }
    public bool IsAdministrator { get; set; }

    #region Email
    private string email;
    public string Email
    {
      get { return email; }
      set { email = value; }
    }
    #endregion
    #region Username
    private string username;
    public string Username
    {
      get { return username; }
      set { username = value; }
    }
    #endregion
    #region Showname
    private string showname;
    public string Showname
    {
      get { return showname; }
      set { showname = value; }
    }
    #endregion
    #region Password
    private string password;
    public string Password
    {
      get { return password; }
      set
      {
        this.password = value;
      }
    }
    #endregion
    #region Saltcode
    private string saltcode;
    public string Saltcode
    {
      get { return saltcode; }
      set { saltcode = value; }
    }
    #endregion
    #region Timezone
    private string timezone;
    public string Timezone
    {
      get { return timezone; }
      set { timezone = value; }
    }
    #endregion

    public string Passcode
    {
      set
      {
        this.saltcode = SiteUser.CreateSaltcode(8);
        this.password = SiteUser.CreatePassword(value, this.Saltcode);
      }
    }

    public static string CreateSaltcode(int size)
    {
      RNGCryptoServiceProvider rngCryptoServiceProvider = new RNGCryptoServiceProvider();
      byte[] buffer = new byte[size];
      rngCryptoServiceProvider.GetBytes(buffer);
      return Convert.ToBase64String(buffer);
    }

    public static string CreatePassword(string password, string saltcode)
    {
      string passwordAndSaltcode = String.Concat(password, saltcode);
      return FormsAuthentication.HashPasswordForStoringInConfigFile(passwordAndSaltcode, "sha1");;
    }

    public override string ToString()
    {
      StringBuilder stringBuilder = new StringBuilder();
      stringBuilder.Append(" Username: ");
      stringBuilder.Append(this.Username);
      stringBuilder.Append(System.Environment.NewLine);
      stringBuilder.Append(" Showname: ");
      stringBuilder.Append(this.Showname);
      stringBuilder.Append(System.Environment.NewLine);
      stringBuilder.Append(" Password: ");
      stringBuilder.Append(this.Password);
      stringBuilder.Append(System.Environment.NewLine);
      stringBuilder.Append(" Saltcode: ");
      stringBuilder.Append(this.Saltcode);
      stringBuilder.Append(System.Environment.NewLine);
      stringBuilder.Append(" Timezone: ");
      stringBuilder.Append(this.Timezone);
      stringBuilder.Append(System.Environment.NewLine);
      stringBuilder.Append(" Email: ");
      stringBuilder.Append(this.Email);
      return stringBuilder.ToString();
    }

  }
}