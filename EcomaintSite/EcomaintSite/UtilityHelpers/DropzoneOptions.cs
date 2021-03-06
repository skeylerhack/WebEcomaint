using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace EcomaintSite.UtilityHelpers
{
    public class DropzoneOptions
    {
        public DropzoneOptions()
        {
            MaxFiles = 1;
            MaxFileSize = 2;
            AcceptedFiles = ".jpg, .jpeg, .png";
        }
        public string Url { get; set; }
        public int MaxFiles { get; set; }
        public int MaxFileSize { get; set; }
        public string AcceptedFiles { get; set; }
    }
}
