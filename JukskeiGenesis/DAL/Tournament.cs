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
    
    public partial class Tournament
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Tournament()
        {
            this.Categories = new HashSet<Category>();
            this.Payments = new HashSet<Payment>();
            this.Rosters = new HashSet<Roster>();
        }
    
        public int Tournament_Id { get; set; }
        public string Tournament_Name { get; set; }
        public string Tournament_Location { get; set; }
        public string Tournament_Address { get; set; }
        public string Tournament_Type { get; set; }
        public System.DateTime Tournament_Start_Date { get; set; }
        public System.DateTime Tournament_End_Date { get; set; }
        public Nullable<int> Tournament_Extension { get; set; }
        public string Tournament_Duration { get; set; }
        public Nullable<int> Tournament_Pits_Playable { get; set; }
        public string Tournament_State { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Category> Categories { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Payment> Payments { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Roster> Rosters { get; set; }
    }
}
