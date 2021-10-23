using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;

namespace Model.Data
{
    public class LeaderShipViewModel
    {
        public int STT { get; set; }
        public int IDLeadership { get; set; }
        public string Content { get; set; }
        public DateTime? DateCreate { get; set; }
        public bool Yes { get; set; }
        public bool No { get; set; }
        public bool NA { get; set; }
        public string NOTE { get; set; }
    }
}
