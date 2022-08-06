variable "repository_name" {}

variable "repository_default_branch" {
  default = "master"
}

variable "repository_topics" {
  type    = list
  default = []
}

variable "auto_init" {
  default = true
}

variable "description" {
  default = ""
}

variable "private" {
  default = false
}

variable "has_downloads" {
  default = true
}

variable "has_issues" {
  default = true
}

variable "has_wiki" {
  default = true
}

variable "allow_merge_commit" {
  default = false
}

variable "allow_squash_merge" {
  default = true
}

variable "allow_rebase_merge" {
  default = false
}

variable "branches_to_protect" {
  type    = list
  default = ["master"]
}

variable "admin_team_id" {
  default = ""
}

variable "team_ids" {
  type    = list
  default = []
}

variable "enforce_admins" {
  default = true
}

variable "teams_webhook" {
  default = ""
}

resource "github_repository" "main" {
  name        = var.repository_name
  description = var.description

  default_branch = var.repository_default_branch
  topics = var.repository_topics

  private = var.private

  has_downloads = var.has_downloads
  has_issues    = var.has_issues
  has_wiki      = var.has_wiki

  allow_merge_commit = var.allow_merge_commit
  allow_squash_merge = var.allow_squash_merge
  allow_rebase_merge = var.allow_rebase_merge

  auto_init = var.auto_init

  lifecycle {
    prevent_destroy = true
  }
}

resource "github_repository_collaborator" "main_collaborator" {
  repository = github_repository.main.name
  username   = "A900878"
  #permission = "read"
}

resource "github_repository_webhook" "teams_notification" {
  repository = github_repository.main.name

  configuration {
    url          = var.teams_webhook
    content_type = "json"
    insecure_ssl = false
  }

  active = true

  events = ["commit_comment","create","delete","issue_comment","issues","label","pull_request","pull_request_review","pull_request_review_comment","push","release"]
}

resource "github_repository_webhook" "r2jenkins" {
  repository = github_repository.main.name

  configuration {
    url          = "https://ci-channelr2jenkins.sharedservices-prod-vpn.us.i06.c01.johndeerecloud.com/github-webhook/"
    content_type = "json"
    insecure_ssl = false
  }

  active = true

  events = ["push", "pull_request"]
}

resource "github_repository_webhook" "r2jenkins_pull_request" {
  repository = github_repository.main.name

  configuration {
    url          = "https://ci-channelr2jenkins.sharedservices-prod-vpn.us.i06.c01.johndeerecloud.com/ghprbhook/"
    content_type = "json"
    insecure_ssl = false
  }

  active = true

  events = ["pull_request"]
}

resource "github_team_repository" "admin" {
  team_id    = var.admin_team_id
  repository = github_repository.main.name
  permission = "admin"
}

resource "github_team_repository" "main" {
  count = length(var.team_ids)

  team_id    = var.team_ids[count.index]
  repository = github_repository.main.name
  permission = "push"
}

//resource "github_team_repository" "main" {
//  team_id    = var.team_ids[0]
//  repository = github_repository.main.name
//  permission = "push"
//}

resource "github_branch_protection" "main" {
  count = length(var.branches_to_protect)

  repository = github_repository.main.name
  branch     = var.branches_to_protect[count.index]

  required_pull_request_reviews {
    dismiss_stale_reviews = true
    dismissal_teams       = [var.admin_team_id]
  }

  enforce_admins = false
}

resource "github_issue_label" "veracode_flaw" {
  repository = github_repository.main.name
  name       = "Veracode Flaw"
  color      = "0092d4"
}

resource "github_issue_label" "work_in_progress" {
  repository = "${github_repository.main.name}"
  name       = "Work In Progress"
  color      = "d4c5f9"
}

resource "github_issue_label" "review_and_merge" {
  repository = "${github_repository.main.name}"
  name       = "Review and Merge"
  color      = "fbca04"
}

resource "github_issue_label" "sonar_issue_fix" {
  repository = "${github_repository.main.name}"
  name       = "Sonar Issue Fix"
  color      = "dcf287"
}
