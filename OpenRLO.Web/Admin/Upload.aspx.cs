using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace OpenRLO.Web.Admin
{
  public partial class Upload : System.Web.UI.Page
  {
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    public string ReverseMapPath(string path)
    {
      string appPath = HttpContext.Current.Server.MapPath("~");
      return string.Format("{0}", path.Replace(appPath, "").Replace("\\", "/"));
    }

    protected void btnUploadControl_Click(object sender, EventArgs e)
    {

      if (this.fupFileUploadControl.PostedFile != null && this.fupFileUploadControl.PostedFile.ContentLength > 0)
      {
        string fileName = System.IO.Path.GetFileName(this.fupFileUploadControl.PostedFile.FileName);
        string fileNameS = Server.MapPath(this.lstUploadLocationControl.SelectedValue) + fileName;
        string fileNameR = this.lstUploadLocationControl.SelectedValue + fileName;
        string fileNameM = ReverseMapPath(fileNameS);

        //Response.Write("FN: " + fileName + "<br/>");
        //Response.Write("SV: " + this.lstUploadLocationControl.SelectedValue + "<br/>");
        //Response.Write("MP: " + Server.MapPath(this.lstUploadLocationControl.SelectedValue) + "<br/>");

        try
        {
          string mapPath = Server.MapPath(this.lstUploadLocationControl.SelectedValue);
          if (!System.IO.Directory.Exists(mapPath))
          {
            System.IO.Directory.CreateDirectory(mapPath);
          }
        }
        catch (Exception ex)
        {
          Response.Write("ERROR: " + ex.Message);
        }

        try
        {
          this.fupFileUploadControl.PostedFile.SaveAs(fileNameS);
          //Response.Write("<a href=\"/" + fileNameM + "\">" + fileNameM + "</a> Uploaded Successfully.<br/><br/>");
          lblUploadedFile.Visible = true;
          //lnkUploadedFile.NavigateUrl = "/" + fileNameM;
          string remove = lstUploadLocationControl.Items[0].Value;
          string newurl = "http://media.nathanlaan.com/" + fileNameM.Remove(0, remove.Length - 1);
          lnkUploadedFile.NavigateUrl = newurl;
          lnkUploadedFile.Text = newurl;
        }
        catch (Exception ex)
        {
          Response.Write("ERROR: " + ex.Message);
        }
      }
      else
      {
        Response.Write("Please select a file to upload.");
      }
    }

  }
}