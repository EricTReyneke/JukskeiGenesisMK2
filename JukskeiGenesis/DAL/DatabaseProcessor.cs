using System.Collections.Generic;
using System.Linq;

namespace DAL
{
    public class DatabaseProcessor
    {
        private readonly JukskeiDatabaseEntities _jukskeiDB = new JukskeiDatabaseEntities();

        private List<Tournament> _tournamentList;

        public bool getLogin(string userName, string password)
        {
            return _jukskeiDB.Clients_Admin.FirstOrDefault(t => t.Client_Admin_UserName == userName && t.Client_Admin_Password == password) != null;
        }

        public List<Tournament> GetTournaments()
        {
            List<Tournament> _tournamentList = new List<Tournament>();

            _tournamentList = _jukskeiDB.Tournaments.Select(t => t).ToList();

            return _tournamentList;
        }
    }
}