using System;
using System.Collections.Generic;
using System.Linq;
using static NPOI.HSSF.Util.HSSFColor;

namespace DAL
{
    public class DatabaseProcessor
    {
        #region Rroperties

        private readonly JukskeiDatabaseEntities _jukskeiDB = new JukskeiDatabaseEntities();

        #endregion

        #region Public Methods

        /// <summary>
        /// Retrieves all Tournaments from the jukskeiDatabase.
        /// </summary>
        /// <returns></returns>
        public List<Tournament> GetTournaments() =>
            _jukskeiDB.Tournaments.Select(t => t).ToList();

        /// <summary>
        /// Algorithm to create a Roster on the Teams in a Category.
        /// </summary>
        /// <param name="teams"></param>
        /// <returns></returns>
        public IEnumerable<(string First, string Second)> ListMatches(List<string> teams)
        {
            var matches = new List<(string, string)>();
            if (teams == null || teams.Count < 2)
                return matches;

            if (teams.Count % 2 != 0)
                teams.Add("Bye");

            // Removed the shuffle step
            List<string> ShuffledList = teams;

            var restTeams = new List<string>(ShuffledList.Skip(1));
            var teamsCount = ShuffledList.Count;

            for (var day = 0; day < teamsCount - 1; day++)
            {
                if (restTeams[day % restTeams.Count]?.Equals(default) == false)                
                    matches.Add((ShuffledList[0], restTeams[day % restTeams.Count]));

                for (var index = 1; index < teamsCount / 2; index++)
                {
                    var firstTeam = restTeams[(day + index) % restTeams.Count];
                    var secondTeam = restTeams[(day + restTeams.Count - index) % restTeams.Count];
                    if (firstTeam?.Equals(default) == false && secondTeam?.Equals(default) == false)
                        matches.Add((firstTeam, secondTeam));
                }
            }

            return matches;
        }

        /// <summary>
        /// Creates a new entry of a Tournament and Categorries in the JukskeiDatabase.
        /// </summary>
        /// <param name="touryName"></param>
        /// <param name="tournyLocation"></param>
        /// <param name="tournyStreet"></param>
        /// <param name="startDate"></param>
        /// <param name="endDate"></param>
        /// <param name="tournyType"></param>
        /// <param name="tournyDuration"></param>
        /// <param name="pitsPlayable"></param>
        /// <param name="tournyCategory"></param>
        /// <returns></returns>
        public int CreateNewTournament(string touryName, string tournyLocation, string tournyStreet, DateTime startDate,
                                       DateTime endDate, string tournyType, string tournyDuration, int pitsPlayable, 
                                       string tournamentState, List<string> tournyCategory)
        {
            Tournament newTournament = new Tournament
            {
                Tournament_Name = touryName + " " + startDate.Year,
                Tournament_Location = tournyLocation,
                Tournament_Start_Date = startDate,
                Tournament_End_Date = endDate,
                Tournament_Extension = 0,
                Tournament_Type = tournyType,
                Tournament_Address = tournyStreet,
                Tournament_Pits_Playable = pitsPlayable,
                Tournament_Duration = tournyDuration,
                Tournament_State = tournamentState
            };

            foreach (var category in tournyCategory)
            {
                Category newCategory = new Category
                {
                    Tournament_Id = newTournament.Tournament_Id,
                    Category_Name = category
                };
                _jukskeiDB.Categories.Add(newCategory);
            }

            _jukskeiDB.Tournaments.Add(newTournament);
            _jukskeiDB.SaveChanges();

            return newTournament.Tournament_Id;
        }

        /// <summary>
        /// Retrieves the Categorries form the corrosponding TournamentId.
        /// </summary>
        /// <param name="tournamentId"></param>
        /// <returns></returns>
        public List<Category> GetCategories(int tournamentId) =>
            _jukskeiDB.Categories.Where(c => c.Tournament_Id == tournamentId).ToList();

        /// <summary>
        /// Retrieves the Teams of that corrosponding CategoryId.
        /// </summary>
        /// <param name="Category_Id"></param>
        /// <returns></returns>
        public List<Team> GetTeams(int Category_Id) =>
            _jukskeiDB.Teams.Where(t => t.Category_Id == Category_Id).ToList();

        /// <summary>
        /// Retrieves the MatchScores of that corrosponding Team.
        /// </summary>
        /// <param name="Category_Id"></param>
        /// <returns></returns>
        public List<MatchPoint> GetTeamMatchScore(int teamId) =>
            _jukskeiDB.MatchPoints.Where(t => t.Team_Id == teamId).ToList();

        /// <summary>
        /// Retrieves the Tournaments from the Tournament_Name in the database.
        /// </summary>
        /// <param name="tournamentName"></param>
        /// <returns></returns>
        public List<Tournament> SearchTournamentName(string tournamentName) =>
            _jukskeiDB.Tournaments.Where(w => w.Tournament_Name.Contains(tournamentName)).Select(t => t).ToList();

        /// <summary>
        /// Retrieves the Tournament fromfrom database using TournamentId.
        /// </summary>
        /// <param name="tournamentName"></param>
        /// <returns></returns>
        public Tournament RetrieveTournement(int TournamentId) =>
            _jukskeiDB.Tournaments.Where(w => w.Tournament_Id == TournamentId).Select(t => t).ToList()[0];

        /// <summary>
        /// Retrieves the Tournaments from the Tournament_State in the database.
        /// </summary>
        /// <param name="tournamentState"></param>
        /// <returns></returns>
        public List<Tournament> SearchTournamentState(string tournamentState) =>
            _jukskeiDB.Tournaments.Where(w => w.Tournament_State == tournamentState).Select(t => t).ToList();

        /// <summary>
        /// Writes the teams into the Database.
        /// </summary>
        /// <param name="teamAndCategoryNames"></param>
        public void AddTeamsToCategories(List<string> teamAndCategoryNames)
        {
            List<Category> cattegoryNames = GetCategories(2);

            foreach (Category category in cattegoryNames)
                foreach (var teamName in AddTeamsDynamicaly(teamAndCategoryNames, category.Category_Name))
                {
                    Team newTeam = new Team()
                    {
                        Team_Name = teamName,
                        Category_Id = category.Category_Id,
                        Tournament_Id = category.Tournament_Id,
                    };

                    _jukskeiDB.Teams.Add(newTeam);
                    _jukskeiDB.SaveChanges();
                }
        }

        #endregion

        #region Private Methods

        /// <summary>
        /// Devides the Teams into their respective Categories.
        /// </summary>
        /// <param name="teamAndCategoryNames"></param>
        /// <param name="categoryName"></param>
        /// <returns></returns>
        private List<string> AddTeamsDynamicaly(List<string> teamAndCategoryNames, string categoryName)
        {
            List<string> nameOfTeams = new List<string>();

            foreach (string team in teamAndCategoryNames)
                if (team.Split(' ').Last().Equals(categoryName))
                {
                    string[] teamAndCategoryArray = team.Split(' ');
                    nameOfTeams.Add(string.Join(", ", teamAndCategoryArray.Take(teamAndCategoryArray.Length - 1)));
                }

            return nameOfTeams;
        }
        #endregion
    }
}