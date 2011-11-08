using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace OpenRLO.Data
{
  public class LearningObjectItem
  {

    public string Title { get; set; }
    public string Url { get; set; }
    public DateTime ModifiedDateTime { get; set; }


    public void GenerateUrl()
    {
      this.Url = Title.Replace(" ", "");
    }

  }
}