﻿namespace JukskeiGenesis.Models
{
    public class TournamentStateTracker
    {
        public static int TournamentId { get; set; }

        public static int CategoryId { get; set; }

        public static int TrackMatchesPlayed { get; set; } = 1;
    }
}