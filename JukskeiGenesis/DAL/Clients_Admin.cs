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
    
    public partial class Clients_Admin
    {
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public Clients_Admin()
        {
            this.Payments = new HashSet<Payment>();
        }
    
        public int Client_Admin_Id { get; set; }
        public string Client_Admin_UserName { get; set; }
        public string Client_Admin_Password { get; set; }
        public string Client_Admin_Name { get; set; }
        public string Client_Admin_SurName { get; set; }
        public string Client_Admin_Email { get; set; }
    
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<Payment> Payments { get; set; }
    }
}
