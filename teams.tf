/**************************************************
                    * TEAMS *
 ***************************************************/
resource "github_team" "developers" {
  name        = "developers"
  description = "All Developers This team is synced with <DEVELOPER AD Group Name> AD Group."
  privacy     = "closed"
}

resource "github_team" "admin" {
  name        = "admin"
  description = "Admin team is synced with <ADMIN AD Group Name> AD Group."
  privacy     = "closed"
}

locals {
  team_ids = [
    github_team.developers.id
  ]
 
teams_webhook="< microsoft teams webhook url>"
}