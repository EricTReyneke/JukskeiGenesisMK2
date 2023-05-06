using System;
using System.Collections.Generic;
using System.Linq;

namespace DAL
{
    public class DatabaseProcessor
    {
        #region Rroperties
        //private readonly JukskeiDatabaseEntities _jukskeiDB = new JukskeiDatabaseEntities();
        private readonly JukskeiDatabaseEntities1 _jukskeiDB = new JukskeiDatabaseEntities1();
        #endregion

        #region Public Methods
        //public bool getLogin(string userName, string password)
        //{
        //    return _jukskeiDB.Clients_Admin.FirstOrDefault(t => t.Client_Admin_UserName == userName && t.Client_Admin_Password == password) != null;
        //}

        public List<Tournament> GetTournaments()
        {
            List<Tournament> tournamentList = new List<Tournament>();

            tournamentList = _jukskeiDB.Tournaments.Select(t => t).ToList();

            return tournamentList;
        }

        //public IEnumerable<(string First, string Second)> ListMatches(List<string> teams)
        //{
        //    var matches = new List<(string, string)>();
        //    if (teams == null || teams.Count < 2)
        //    {
        //        return matches;
        //    }

        //    if (teams.Count % 2 != 0)
        //    {
        //        teams.Add("Bye");
        //    }

        //    string[] ShuffleString = teams.ToArray();

        //    Shuffle(ShuffleString);

        //    List<string> ShuffledList = ShuffleString.ToList();

        //    var restTeams = new List<string>(ShuffledList.Skip(1));
        //    var teamsCount = ShuffledList.Count;

        //    for (var day = 0; day < teamsCount - 1; day++)
        //    {
        //        if (restTeams[day % restTeams.Count]?.Equals(default) == false)
        //        {
        //            matches.Add((ShuffledList[0], restTeams[day % restTeams.Count]));
        //        }

        //        for (var index = 1; index < teamsCount / 2; index++)
        //        {
        //            var firstTeam = restTeams[(day + index) % restTeams.Count];
        //            var secondTeam = restTeams[(day + restTeams.Count - index) % restTeams.Count];
        //            if (firstTeam?.Equals(default) == false && secondTeam?.Equals(default) == false)
        //            {
        //                matches.Add((firstTeam, secondTeam));
        //            }
        //        }
        //    }

        //    return matches;
        //}

        public IEnumerable<(string First, string Second)> ListMatches(List<string> teams)
        {
            var matches = new List<(string, string)>();
            if (teams == null || teams.Count < 2)
            {
                return matches;
            }

            if (teams.Count % 2 != 0)
            {
                teams.Add("Bye");
            }

            // Removed the shuffle step
            List<string> ShuffledList = teams;

            var restTeams = new List<string>(ShuffledList.Skip(1));
            var teamsCount = ShuffledList.Count;

            for (var day = 0; day < teamsCount - 1; day++)
            {
                if (restTeams[day % restTeams.Count]?.Equals(default) == false)
                {
                    matches.Add((ShuffledList[0], restTeams[day % restTeams.Count]));
                }

                for (var index = 1; index < teamsCount / 2; index++)
                {
                    var firstTeam = restTeams[(day + index) % restTeams.Count];
                    var secondTeam = restTeams[(day + restTeams.Count - index) % restTeams.Count];
                    if (firstTeam?.Equals(default) == false && secondTeam?.Equals(default) == false)
                    {
                        matches.Add((firstTeam, secondTeam));
                    }
                }
            }

            return matches;
        }


        public int CreateNewTournament(string touryName, string tournyLocation, string tournyStreet, DateTime startDate,
                                       DateTime endDate, string tournyType, List<string> tournyCategory)
        {
            Tournament newTournament = new Tournament();
            newTournament.Tournament_Name = touryName + " " + startDate.Year;
            newTournament.Tournament_Location = tournyLocation;
            newTournament.Tournament_Start_Date = startDate;
            newTournament.Tournament_End_Date = endDate;
            newTournament.IsActive = false;
            newTournament.Tournament_Extension = 0;
            newTournament.Tournament_Type = tournyType;
            newTournament.Tournament_Address = tournyStreet;

            foreach (var category in tournyCategory)
            {
                Category newCategory = new Category();
                newCategory.Tournament_Id = newTournament.Tournament_Id;
                newCategory.Category_Name = category;
                _jukskeiDB.Categories.Add(newCategory);
            }

            _jukskeiDB.Tournaments.Add(newTournament);
            _jukskeiDB.SaveChanges();

            return newTournament.Tournament_Id;
        }

        //public int GetTournamentId()
        //{

        //}

        public List<Category> GetCategories(int tournamentId)
        {
            return _jukskeiDB.Categories.Where(c => c.Tournament_Id == tournamentId).ToList();
        }

        public List<Team> GetTeams(int Category_Id)
        {
            return _jukskeiDB.Teams.Where(t => t.Category_Id == Category_Id).ToList();
        }

        #endregion

        #region Private Methods
        private static void Shuffle<T>(T[] array)
        {
            Random random = new Random();
            for (int i = array.Length - 1; i > 0; i--)
            {
                int j = random.Next(i + 1);
                T temp = array[j];
                array[j] = array[i];
                array[i] = temp;
            }
        }
        #endregion
    }
}