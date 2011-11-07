using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace OpenRLO.Web.App_Code
{
  public class RLOUser
  {
    public Guid UserID { get; set; }

    public RLOUser()
    {
      this.UserID = Guid.NewGuid();
    }
  }
}