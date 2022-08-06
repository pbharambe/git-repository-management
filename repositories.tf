/**************************************************
                    * REPOSITORIES *
***************************************************/

module "repository-management" {
  source = "./modules/github"
  repository_name = "repository-management"

  repository_topics=["devops"]
  repository_default_branch = "main"
  branches_to_protect = ["main"]
  //teams_webhook=local.teams_webhook

  admin_team_id = github_team.admin.id
  team_ids      = local.team_ids
}
// list the git repositories