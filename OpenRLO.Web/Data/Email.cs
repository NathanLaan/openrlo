using System;
using System.Collections.Generic;
using System.Text;
//using System.Web.Mail;
using System.Net.Mail;

namespace OpenRLO.Web.Data
{
  public class Email
  {

    public static void SendMail(string host, int port, string username, string password, string fromEmail, string fromName,
        string toEmail, string toName, string subject, string body, bool useSSL)
    {
      //
      // http://www.aspcode.net/Send-mail-from-ASPNET-using-your-gmail-account.aspx
      //
      // http://www.davidmillington.net/news/index.php/2005/12/18/using_smtpclient_credentials
      //

      //var client = new SmtpClient("smtp.gmail.com", 587)
      //{
      //  Credentials = new System.Net.NetworkCredential("nathanlaan@gmail.com", "mypwd"),
      //  EnableSsl = true
      //};
      //client.Send("myusername@gmail.com", "myusername@gmail.com", "test", "testbody");

      MailMessage mailMessage = new MailMessage();
      mailMessage.Sender = new MailAddress(fromEmail, fromName, System.Text.Encoding.UTF8);
      mailMessage.From = new MailAddress(fromEmail, fromName);
      mailMessage.To.Add(new MailAddress(toEmail, toName));
      mailMessage.Body = body;
      mailMessage.Subject = subject;
      mailMessage.IsBodyHtml = true;
      mailMessage.BodyEncoding = System.Text.Encoding.UTF8;
      mailMessage.SubjectEncoding = System.Text.Encoding.UTF8;
      mailMessage.Priority = MailPriority.Normal;

      SmtpClient smtpClient = new SmtpClient(host, port);
      smtpClient.UseDefaultCredentials = false;
      smtpClient.Credentials = new System.Net.NetworkCredential(username, password);
      smtpClient.EnableSsl = useSSL;
      smtpClient.Send(mailMessage);

      //System.Web.Mail.MailMessage Mail = new System.Web.Mail.MailMessage();
      //Mail.Fields["http://schemas.microsoft.com/cdo/configuration/smtpserver"] = sHost;
      //Mail.Fields["http://schemas.microsoft.com/cdo/configuration/sendusing"] = 2;
      //Mail.Fields["http://schemas.microsoft.com/cdo/configuration/smtpserverport"] = nPort.ToString();
      //if (fSSL)
      //  Mail.Fields["http://schemas.microsoft.com/cdo/configuration/smtpusessl"] = "true";
      //if (sUserName.Length == 0)
      //{
      //  //Ingen auth 
      //}
      //else
      //{
      //  Mail.Fields["http://schemas.microsoft.com/cdo/configuration/smtpauthenticate"] = 1;
      //  Mail.Fields["http://schemas.microsoft.com/cdo/configuration/sendusername"] = sUserName;
      //  Mail.Fields["http://schemas.microsoft.com/cdo/configuration/sendpassword"] = sPassword;
      //}
      //Mail.To = sToEmail;
      //Mail.From = sFromEmail;
      //Mail.Subject = sHeader;
      //Mail.Body = sMessage;
      //Mail.BodyFormat = System.Web.Mail.MailFormat.Text;
      //System.Web.Mail.SmtpMail.SmtpServer = sHost;
      //System.Web.Mail.SmtpMail.Send(Mail);
    }

  }
}
