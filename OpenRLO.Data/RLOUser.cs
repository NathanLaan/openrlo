using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace OpenRLO.Data
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