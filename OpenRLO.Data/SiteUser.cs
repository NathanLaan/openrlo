using System;
using System.Collections.Generic;
using System.Text;
using System.Security.Cryptography;
using System.Web.Security;

namespace OpenRLO.Data
{
  public class SiteUser
  {

    public Guid UserID { get; set; }
    public bool IsContentEditor { get; set; }
    public bool IsAdministrator { get; set; }
    
    public string Email{get;set;}
    public string Username { get; set; }
    public string Password { get; set; }
    public string Saltcode { get; set; }
    public string Timezone { get; set; }

    public SiteUser()
    {
      this.UserID = Guid.NewGuid();
    }

    public string Passcode
    {
      set
      {
        this.Saltcode = SiteUser.CreateSaltcode(8);
        this.Password = SiteUser.CreatePassword(value, this.Saltcode);
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