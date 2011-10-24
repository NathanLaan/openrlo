using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Solution.Web.Anetro.Library.Utility;

namespace OpenRLO.Web.Admin
{
  public partial class EmailTest : System.Web.UI.Page
  {
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnSendEmail_Click(object sender, EventArgs e)
    {
      /*
        <network
             host="mail.nathanlaan.com"
             port="465"
             userName="noreply@nathanlaan.com"
             password="anetro#2011" />
       */
      /*
      Email.SendMail(
        //"mail.nathanlaan.com",
        //"imap.gmail.com",
        "smtp.gmail.com",
        //465,
        587,
        //"noreply@nathanlaan.com",
        //"nathanlaan@gmail.com",
        "nathanlaan",
        "deacoN.2009nal",
        //"noreply@nathanlaan.com",
        "nathanlaan@gmail.com",
        "Nathan Laan",
        "nathanlaan@hotmail.com",
        "Nathan Laan",
        "Message Subject",
        "Body Text",
        true);
       */

      Email.SendMail(
        "smtp.gmail.com",
        587,
        "noreply@nathanlaan.com",
        "anetro#2011",
        "noreply@nathanlaan.com",
        "Anetro Automated Email",
        "nathanlaan@hotmail.com",
        "Nathan Laan",
        "Message Subject",
        "Body Text",
        true);
    }
  }
}