//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace DAL
{
    using System;
    using System.Collections.Generic;
    
    public partial class Player
    {
        public int Player_Id { get; set; }
        public string Player_Name { get; set; }
        public int Team_Id { get; set; }
    
        public virtual Team Team { get; set; }
    }
}
