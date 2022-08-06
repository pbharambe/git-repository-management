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